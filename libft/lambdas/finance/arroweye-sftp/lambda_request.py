# arroweye sftp
import uuid, jsonpickle, logging, os, errno, time
import botocore, boto3
from urllib.parse import unquote_plus
import pysftp, gnupg

from boto_helpers import boto_s3_client
from boto_helpers import ssm_get_parameters
from sftp_helpers import get_sftp_connection
from key_helpers import get_private_key_file
from key_helpers import get_private_key_passphrase

from lambda_env import LambdaEnv

from aws_xray_sdk.core import xray_recorder
from aws_xray_sdk.core import patch_all

logger = logging.getLogger()
logger.setLevel(logging.INFO)
patch_all()

def get_key_file(s3, keys_bucket, key_file):
    key_file_dest = '/tmp/{}'.format(key_file)
    if not os.path.exists(key_file_dest):
        s3.download_file(keys_bucket, key_file, key_file_dest)        
    return key_file_dest

def mtime_days(days):
    return days * 86400

class Request:
    def __init__(self):
        env_vars = ['keys_bucket', 'destination_bucket', 'working_directory', 
                    'sftp_private_key_param', 'sftp_private_key_secret',  'sftp_hostname', 
                    'sftp_port', 'sftp_username', 'pgp_key_secret', 'pgp_private_key_file']
        lenv = LambdaEnv(env_vars)
        self._keys_bucket       = lenv.value('keys_bucket')
        self._pgp_key_secret    = lenv.value('pgp_key_secret')
        self._pgp_private_key_file = lenv.value('pgp_private_key_file')
        self._dest_bucket_name  = lenv.value('destination_bucket')
        self._working_directory = lenv.value('working_directory')
#        self._days_to_examine   = 30 
        
        sftp_private_key_file = get_private_key_file(lenv.value('sftp_private_key_param'))
        sftp_private_key_pass = get_private_key_passphrase(lenv.value('sftp_private_key_secret'))

        self._sftp_client = get_sftp_connection(hostname = lenv.value('sftp_hostname'), 
                                                username = lenv.value('sftp_username'),
                                                port = lenv.value('sftp_port'), 
                                                private_key_file = sftp_private_key_file,
                                                private_key_pass = sftp_private_key_pass)
        
        self._s3 = boto_s3_client()
        
        # download key file from s3.
        private_key_file = get_key_file(self._s3, self._keys_bucket, self._pgp_private_key_file)
    
        private_key_passphrase = get_private_key_passphrase(self._pgp_key_secret)

        self.pgp_passphrase = get_private_key_passphrase(self._pgp_key_secret)

        self._gpg = gnupg.GPG(gnupghome="/tmp")
        with open(private_key_file) as key:
            key_data = key.read()
            import_result = self._gpg.import_keys(key_data)
            logger.info("import result: %s" % str(import_result.results))

        public_keys = self._gpg.list_keys()
        private_keys = self._gpg.list_keys(True)
        
        logger.info("public_keys: %s " % (public_keys))
        logger.info("private_keys: %s " % (private_keys))

    def _s3_exists(self, key):
        try:
            logger.info("check exists: %s -> %s" % (self._dest_bucket_name, key))
            obj = self._s3.head_object(Bucket=self._dest_bucket_name, Key=key)
            return True if (obj['ContentLength'] > 0) else False
        except botocore.exceptions.ClientError as exc:
            if exc.response['Error']['Code'] != '404':
                raise

    def _store_decrypted(self, source_file, target_file):
        # download the file.
        encrypted_path = '{}/{}-{}'.format(self._working_directory, uuid.uuid4(), source_file)
        decrypted_path = os.path.splitext(encrypted_path)[0]
        
        # Decrypt the file
        logger.info("store decrypted file: %s -> %s" % (encrypted_path, decrypted_path))
        try: 
            self._sftp_client.get(source_file, encrypted_path, preserve_mtime=True)
       
            with open(encrypted_path, 'rb') as fp:
                status = self._gpg.decrypt_file(fp, always_trust = True, passphrase = self.pgp_passphrase, output=decrypted_path)
                if not status:
                    raise Exception("decryption failed: %s" % encrypted_path)
            
            # copy the file to s3 the directory
            self._s3.upload_file(decrypted_path, self._dest_bucket_name, target_file)
        finally:
            if os.path.exists(encrypted_path):
                os.unlink(encrypted_path)
            if os.path.exists(decrypted_path):
                os.unlink(decrypted_path)


    def __call__(self, event, context):
        # SFTP to arroweye and list the available files
        now = time.time()
        for file_attr in self._sftp_client.listdir_attr('/'):
            source_file, source_file_attributes = file_attr.filename, file_attr
# mtime is changing...
#            if (source_file_attributes.st_mtime < (now - mtime_days(self._days_to_examine))):
#                logger.info("Ignoring file: %s with mtime %i days in the past..." % (source_file, self._days_to_examine))
#                continue                

            isfile = self._sftp_client.isfile(source_file)
            logger.info("source_file: %s" % source_file)
            if not isfile:
                logger.info("skipping non-file: %s" % source_file)
                continue

            # For each file not in S3 copy those files locally to efs
            target_file = os.path.splitext(os.path.basename(source_file))[0]
            if self._s3_exists(target_file): 
                logger.info("file exists: %s" % target_file)
                continue
            
            self._store_decrypted(source_file, target_file) 
            
def lambda_handler(event, context):
    logger.info('## EVENT:\r' + jsonpickle.encode(event))
    logger.info('## CONTEXT:\r' + jsonpickle.encode(context))
    return Request()(event, context)
