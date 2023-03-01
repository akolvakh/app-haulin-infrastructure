import unittest
import os
import logging
import jsonpickle
import inspect
from unittest import mock

from aws_xray_sdk.core import xray_recorder

test_del_object = {
    "Records": [
        {
            "eventVersion": "2.1",
            "eventSource": "aws:s3",
            "awsRegion": "us-east-2",
            "eventTime": "2021-08-22T00:16:51.315Z",
            "eventName": "ObjectRemoved:DeleteMarkerCreated",
            "userIdentity": {
                "principalId": "AWS:AROAVHHCKPGQRJGSYBIYR:billy.mullins@zytara.com"
            },
            "responseElements": {
                "x-amz-request-id": "RJ8B7021RCF5GC9C",
                "x-amz-id-2": "Cm9A9aSgtE15sYm4L4n7go37uPVIVlvKA2VJaHR3EYxbgWMcL0UAZ+v9IUu2gbUfufUncWb+qXwzq4rSa8w6unsCgGM+PLwPNL7kac/uafs="
            },
            "s3": {
                "s3SchemaVersion": "1.0",
                "configurationId": "tf-s3-lambda-20210821141453193900000001",
                "bucket": {
                    "name": "sutton-drop-06988ea1871e4eaa49ab9a4a848b6eec",
                    "ownerIdentity": {
                        "principalId": "A353DYWQGCMSRP"
                    },
                    "arn": "arn:aws:s3:::sutton-drop-06988ea1871e4eaa49ab9a4a848b6eec"
                },
                "object": {
                    "key": "hello_world/s3_trigger.tf",
                    "eTag": "d41d8cd98f00b204e9800998ecf8427e",
                    "versionId": "2gk5xQ96hnCnZKEB7SRuAOQ8Rj_lgSCs",
                    "sequencer": "006121977579D99E88"
                }
            }
        }
    ]
}

test_new_object = {
    "Records": [
        {
            "eventVersion": "2.1",
            "eventSource": "aws:s3",
            "awsRegion": "us-east-2",
            "eventTime": "2021-08-21T14:16:33.762Z",
            "eventName": "ObjectCreated:Put",
            "userIdentity": {
                "principalId": "AWS:AROAVHHCKPGQRJGSYBIYR:billy.mullins@zytara.com"
            },
            "responseElements": {
                "x-amz-request-id": "27G3KM7SP13ZV8T1",
                "x-amz-id-2": "fbQglNX0PZ4szt7iPMNf8gNMp3adRxV6tNjrXErLF4MC/UX1C1FzbnfQ7XMTDSw8YItDYhTaYZKcOjVsEQa/OLZQDBlG8WBj"
            },
            "s3": {
                "s3SchemaVersion": "1.0",
                "configurationId": "tf-s3-lambda-20210821141453193900000001",
                "bucket": {
                    "name": "source_bucket_name",
                    "ownerIdentity": {
                        "principalId": "A353DYWQGCMSRP"
                    },
                    "arn": "arn:aws:s3:::source_bucket_name"
                },
                "object": {
                    "key": "hello.txt",
                    "size": 6,
                    "eTag": "b1946ac92492d2347c6235b4d2611184",
                    "versionId": "6x7BEau0x4GQt.BTBaXfE3.sWWvmSGuZ",
                    "sequencer": "0061210AC3681AEE3C"
                }
            }
        }
    ]
}

sutton_public_key = open(os.path.dirname(os.path.realpath(__file__)) + '/public_keys/sutton-public.asc').read()
zytara_public_key = open(os.path.dirname(os.path.realpath(__file__)) + '/public_keys/zytara-public.asc').read()


logger = logging.getLogger()
xray_recorder.configure(
  context_missing='LOG_ERROR'
)

xray_recorder.begin_segment('test_init')
request = __import__('lambda_request')
handler = request.lambda_handler
xray_recorder.end_segment()

def whoami():
    return inspect.stack()[1][3]

def call_lambda(test_name, event, context):
  xray_recorder.begin_segment(test_name)
  try:
    logger.warning('## EVENT')
    logger.warning(jsonpickle.encode(event))
    
    os.environ["environment"] = "test"
    os.environ['source_bucket'] = "source_bucket_name"
    os.environ['destination_bucket'] = "dest_bucket_name"
    os.environ['public_key1'] = 'zytara-public-key'
    os.environ['public_key2'] = 'sutton-public-key'
    
    workdir = "/tmp/working_directory"
    os.environ['working_directory'] = workdir
    if not os.path.exists(workdir):
        os.mkdir(workdir)
        
    return handler(event, context)  
  finally:
    xray_recorder.end_segment()

class TestFunction(unittest.TestCase):
  def boto_s3_client(self):
    class MockBotoClient:
        def __init__(self):
            self._buckets = { 'dest_bucket_name' : {} }

        def download_file(self, bucket, src, dest):
            with open(dest, "w+") as file:
                file.write("hello world")
        
        def upload_file(self, source_fn, dest_bucket, dest_key):
            if not dest_bucket in self._buckets:
                self._buckets[dest_bucket] = {}
            self._buckets[dest_bucket][dest_key] = source_fn
    
        def delete_object(self, Bucket=None, Key=None):
            if not Bucket or not Key:
                raise Exception("You must specifiy Bucket and Key")
            if Bucket in self._buckets:
                if Key in self._buckets[Bucket]:
                    del self._buckets[Bucket][Key]
    
        def list_objects(self, Bucket=None, Prefix=None):
            if Bucket in self._buckets:
                return { 'Contents' : True }
            return { }
    
    return MockBotoClient()

  def ssm_get_parameters(self, names):
    values = []
    if 'zytara-public-key' in names:
        values.append({ 'Value' : sutton_public_key })
    if 'sutton-public-key' in names:
        values.append({ 'Value' : zytara_public_key })
    return values

  def test_new_object(self):
    s3_client = self.boto_s3_client()
    def boto_s3_client():
        return s3_client
    
    with mock.patch('lambda_request.boto_s3_client', new = boto_s3_client):
        with mock.patch('lambda_request.ssm_get_parameters', new = self.ssm_get_parameters):
            context = {'requestid' : '123'}
            call_lambda(whoami(), test_new_object, context)

    self.assertTrue('dest_bucket_name' in s3_client._buckets)
    self.assertTrue('hello.txt.pgp' in s3_client._buckets['dest_bucket_name'])
  
    #TODO: decrypt and compare the result
  
  def test_del_object(self):
    s3_client = self.boto_s3_client()
    
    def boto_s3_client():
        return s3_client
   
    # add a file to s3_client here and see that it is deleted below
    
    with mock.patch('lambda_request.boto_s3_client', new = boto_s3_client):
       with mock.patch('lambda_request.ssm_get_parameters', new = self.ssm_get_parameters):
            context = {'requestid' : '123'}
            call_lambda(whoami(), test_del_object, context)
            
    # do asserts 
  
if __name__ == '__main__':
    logging.disable(logging.CRITICAL)
    unittest.main()
