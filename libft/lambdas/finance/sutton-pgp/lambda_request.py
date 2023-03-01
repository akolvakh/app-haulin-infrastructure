import boto3, uuid, jsonpickle, logging, os
from urllib.parse import unquote_plus
import gnupg

from boto_helpers import boto_s3_client
from boto_helpers import ssm_get_parameters

from lambda_env import LambdaEnv

from aws_xray_sdk.core import xray_recorder
from aws_xray_sdk.core import patch_all

logger = logging.getLogger()
logger.setLevel(logging.INFO)
patch_all()

class Request:
    def __init__(self):
        lenv = LambdaEnv(['source_bucket', 'destination_bucket', 'working_directory', 'public_key1', 'public_key2'])
        self._source_bucket_name = lenv.value('source_bucket')
        self._dest_bucket_name = lenv.value('destination_bucket')
        self._working_directory = lenv.value('working_directory')
        self._gpg = gnupg.GPG(gnupghome="/tmp")
        
        parameters = ssm_get_parameters([lenv.value('public_key1'), lenv.value('public_key2')])
        
        public_key1 = self._gpg.import_keys(parameters[0]['Value'])
        public_key2 = self._gpg.import_keys(parameters[1]['Value'])

        self._recipients = list(set(public_key1.fingerprints + public_key2.fingerprints))
    
    def _create(self, s3, bucket_name, key):
        download_path = None
        encrypted_path = None
        try: 
            basename = os.path.basename(key)
            download_path = '{}/{}-{}'.format(self._working_directory, uuid.uuid4(), basename)
            
            logger.info("Downloading: %s to %s" % (key, download_path))
            s3.download_file(bucket_name, key, download_path)
            
            encrypted_path = '.'.join([download_path, "pgp"])
            destination_key = '.'.join([key, "pgp"])
             
            with open(download_path, "rb") as read_stream:
                logger.info("Encrypting to %s" % (encrypted_path))
                self._gpg.encrypt_file(read_stream, self._recipients, always_trust=True, output=encrypted_path)
            
            s3.upload_file(encrypted_path, self._dest_bucket_name, destination_key)
            logger.info("Uploaded %s to %s as %s" % (download_path, self._dest_bucket_name, destination_key))
        finally:
            if download_path and os.path.exists(download_path):
                os.unlink(download_path)
            if encrypted_path and os.path.exists(encrypted_path):
                os.unlink(encrypted_path)
    
    def _remove(self, s3, key):
        destination_key = '.'.join([key, "pgp"])
        logger.info("Deleting object: %s from %s" % (destination_key, self._dest_bucket_name)) 
        s3.delete_object(Bucket=self._dest_bucket_name, Key=destination_key)
       
    def _path_exists(self, s3, path):
        result = s3.list_objects(Bucket=self._dest_bucket_name, Prefix=path)
        if 'Contents' in result:
            logger.info("Path exists: %s" % path)
            return True
        return False
       
    def __call__(self, event, context):
        s3 = boto_s3_client()
        
        # Loop through every file uploaded
        for record in event['Records']:
            event_name = record['eventName']
            bucket_name = record['s3']['bucket']['name']
            key = unquote_plus(record['s3']['object']['key'])
            
            logger.info("%s: (bucket, key) -> (%s, %s) " % (event_name, bucket_name, key))
            
            # directory must already exist, manually create any new directories.
            directory_that_must_exist = os.path.dirname(key)
            if directory_that_must_exist and not self._path_exists(s3, directory_that_must_exist):
                logger.error("No such directory at destination, create manually: %s" % directory_that_must_exist)
                return
            
            if event_name == "ObjectRemoved:DeleteMarkerCreated":
                self._remove(s3, key)
            else:
                self._create(s3, bucket_name, key)

def lambda_handler(event, context):
    logger.info('## EVENT:\r' + jsonpickle.encode(event))
    logger.info('## CONTEXT:\r' + jsonpickle.encode(context))
    return Request()(event, context)
