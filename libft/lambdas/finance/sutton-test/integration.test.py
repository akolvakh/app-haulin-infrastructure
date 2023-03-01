import os, logging, sys, random
import pysftp, boto3, gnupg, botocore
import time, tempfile

from boto_helpers import *
from key_helpers import *
from sftp_helpers import *

# TODO - move into a config file, for the event there are multiple environments to
# test, however at the moment only one, and only one set of settings, so just makework to do
# that now.
KEYS_BUCKET          = "finance-keystore-06988ea1871e4eaa49ab9a4a848b6eec"
SSH_KEY_FILE         = "sutton-ssh-private-key.id_rsa"
SSH_KEY_PASS_SECRET  = "finance-ssh-private-key-passphrase"
PGP_KEY_SECRET       = "finance-pgp-private-key-passphrase"
PGP_PRIVATE_KEY_FILE = "zytara-arroweye-private-key.asc"
SOURCE_BUCKET        = 'sutton-drop-06988ea1871e4eaa49ab9a4a848b6eec'
TEST_DIRECTORY       = 'zytara-test'
DEST_BUCKET          = 'sutton-drop-pgp-06988ea1871e4eaa49ab9a4a848b6eec'
TRANSIT_DELAY        = 60
HOSTNAME             = "64.186.193.3"
USERNAME             = "zytara"
PORT                 = 992

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def get_key_file(s3, key_file):
    key_file_dest = '/tmp/{}'.format(key_file)
    if not os.path.exists(key_file_dest):
        s3.download_file(KEYS_BUCKET, key_file, key_file_dest)        
    return key_file_dest

class TestClass:
  def __init__(self):
    self.s3 = boto_s3_client()
  
    # download key file from s3
    private_key_file = get_key_file(self.s3, SSH_KEY_FILE)
    
    private_key_passphrase = get_private_key_passphrase(SSH_KEY_PASS_SECRET)

    self.pgp_passphrase = get_private_key_passphrase(PGP_KEY_SECRET)

    self.sftp = get_sftp_connection(HOSTNAME, 
                                    USERNAME, 
                                    PORT, 
                                    private_key_file, 
                                    private_key_passphrase)
    
    # download key files from s3
    self.pgp_private_key = get_key_file(self.s3, PGP_PRIVATE_KEY_FILE)

    self.gpg = gnupg.GPG()
    with open(self.pgp_private_key) as key:
      key_data = key.read()
      private_key = self.gpg.import_keys(key_data)
 
  def wait_s3_delete(self, destination_key_pgp):
    delay = 0
    while (delay < TRANSIT_DELAY):
      try:
        response = self.s3.head_object(Bucket=DEST_BUCKET, Key=destination_key_pgp)
      except botocore.exceptions.ClientError as error:
        logger.info("Not found means success: %s" % str(error))
        return True
      logger.info("Waiting for delete object in %s at %s" % (DEST_BUCKET, destination_key_pgp))
      time.sleep(5)
      delay += 5
    return False
    
  def wait_s3_arrive(self, destination_key_pgp):
    delay = 0
    while (delay < TRANSIT_DELAY):
      try:
        self.s3.head_object(Bucket=DEST_BUCKET, Key=destination_key_pgp)
        logger.info("Found object...")
        return True
      except botocore.exceptions.ClientError as error:
        logger.info("Waiting for object in %s at %s" % (DEST_BUCKET, destination_key_pgp))
        time.sleep(5)
        delay += 5
    return False
 
  def wait_sftp_arrive(self, destination_key_pgp):
    delay = 0
    while (delay < TRANSIT_DELAY):
        if self.sftp.exists(destination_key_pgp):
            return True
        logger.info("Waiting for object in sftp at %s" % (destination_key_pgp))
        time.sleep(5)
        delay += 5
    return False 

  def wait_sftp_delete(self, destination_key_pgp):
    delay = 0
    while (delay < TRANSIT_DELAY):
        if not self.sftp.exists(destination_key_pgp):
            return True
        logger.info("Waiting for delete of object in sftp at %s" % (destination_key_pgp))
        time.sleep(5)
        delay += 5
    return False
  
  def run(self):
    temp = tempfile.NamedTemporaryFile(delete=False)
    destination_key = os.path.join(TEST_DIRECTORY, os.path.basename(temp.name))
   
    test_string = b"Hello from integration tests: %d" % random.randint(0, 4000000)

    logger.info("Sending: %s" % test_string)
    try:
      temp.write(test_string) # Write a byte string using fp.write()
      temp.close()
    
      # put object in s3
      self.s3.upload_file(temp.name, SOURCE_BUCKET, destination_key)
    finally:
      if os.path.exists(temp.name):
        os.unlink(temp.name)

    destination_key_pgp = ".".join([destination_key, "pgp"])
      
    assert self.wait_s3_arrive(destination_key_pgp), "PGP file failed to arrive in bucket"

    assert self.wait_sftp_arrive(destination_key_pgp), "PGP file failed to arrive in sftp"
   
    pgp_file = tempfile.NamedTemporaryFile(suffix=".pgp", delete=False)
    try:
        self.sftp.get(destination_key_pgp, pgp_file.name)

        # decrypt file
        with open(pgp_file.name) as fp:
          decrypted_data = self.gpg.decrypt_file(fp, always_trust = True, passphrase = self.pgp_passphrase)

          # compare conents to test_string
          assert decrypted_data.ok, "Decryption failed"

          assert str(decrypted_data) == test_string.decode(), "Decrypted data does not match the test string"
          logger.info("Decryption and data validation successful!")
    finally:
      if os.path.exists(pgp_file.name):
        os.unlink(pgp_file.name)

    # Deleting the object should flow through to the pgp bucket as well...
    logger.info("Deleting Object: %s %s" % (SOURCE_BUCKET, destination_key))
    self.s3.delete_object(Bucket=SOURCE_BUCKET, Key=destination_key)
    
    # Wait for object to delete in DEST_BUCKET
    assert self.wait_s3_delete(destination_key_pgp), "PGP file failed to delete from bucket"
    
    assert self.wait_sftp_delete(destination_key_pgp), "PGP file failed to delete from bucket"

    logger.info("Test completed successfully")

if __name__ == '__main__':
  TestClass().run()

