import boto3, uuid, jsonpickle, logging, os, errno
from urllib.parse import unquote_plus
import pysftp

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

class Request:
    def __init__(self):
        env_vars = ['source_bucket', 'working_directory', 'sftp_private_key_param', 'sftp_private_key_secret', 
                    'sftp_hostname', 'sftp_port', 'sftp_username']
        lenv = LambdaEnv(env_vars)
        self._source_bucket_name = lenv.value('source_bucket')
        self._working_directory = lenv.value('working_directory')
        
        private_key_file = get_private_key_file(lenv.value('sftp_private_key_param'))
        private_key_pass = get_private_key_passphrase(lenv.value('sftp_private_key_secret'))

        self._sftp_client = get_sftp_connection(hostname = lenv.value('sftp_hostname'), 
                                                username = lenv.value('sftp_username'),
                                                port = lenv.value('sftp_port'), 
                                                private_key_file = private_key_file,
                                                private_key_pass = private_key_pass)
        
    def _create(self, bucket_name, key):
        s3 = boto_s3_client();
        logger.info("Copying remote object: %s" % (key)) 
   
        download_path = None
        try: 
            basename = os.path.basename(key)
           
            # download to storage mount point 
            download_path = '{}/{}-{}'.format(self._working_directory, uuid.uuid4(), basename)
            logger.info("Downloading: %s to %s" % (key, download_path))
            s3.download_file(bucket_name, key, download_path)

            # transmit file over sftp
            self._sftp_client.put(download_path, remotepath=key, confirm=True)            
        finally:
            if download_path and os.path.exists(download_path):
                os.unlink(download_path)
    
    def _remove(self, key):
        logger.info("Deleting remote object: %s" % (key)) 
        # delete file over sftp
        try:
            self._sftp_client.remove(key)
        except IOError as err:
            if err.errno != errno.ENOENT:
                logger.info("File doesn't exist...")
                raise
       
    def __call__(self, event, context):
        # Loop through every file uploaded
        for record in event['Records']:
            event_name = record['eventName']
            bucket_name = record['s3']['bucket']['name']
            key = unquote_plus(record['s3']['object']['key'])
            
            logger.info("%s: (bucket, key) -> (%s, %s) " % (event_name, bucket_name, key))
           
            # directory must already exist, manually create any new directories.
            directory_that_must_exist = os.path.dirname(key)
            if directory_that_must_exist and not self._sftp_client.exists(directory_that_must_exist):
                logger.error("No such directory at destination, create manually: %s" % directory_that_must_exist)
                return
            
            if event_name == "ObjectRemoved:DeleteMarkerCreated":
                self._remove(key)
            else:
                self._create(bucket_name, key)

def lambda_handler(event, context):
    logger.info('## EVENT:\r' + jsonpickle.encode(event))
    logger.info('## CONTEXT:\r' + jsonpickle.encode(context))
    return Request()(event, context)
