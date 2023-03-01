import inspect
import logging
import os
import unittest
from unittest import mock

import jsonpickle
from aws_xray_sdk.core import xray_recorder

from lambda_request import Request
from urllib3.connectionpool import HTTPConnectionPool

acquirer = {
    "id": "ZytaraTest",
    "password": "helloworld123",
    "userId": "bmullins"
}

managed_secrets = {
  "acquirer_userid"  : acquirer["userId"],
  "acquirer_password": acquirer["password"],
  "acquirer_id"      : acquirer["id"]
}

request_url = "ws2.mycardplace.com"

def apply_acquirer(json):
    json2 = dict(json)
    key = list(json2.keys())[0]
    json2[key]["acquirer"] = acquirer
    return json2

echoReqJson = { "echo": {} }
echoReqJsonAcquirer = apply_acquirer(echoReqJson)

addCardReqJson = {
    "addCard": {
        "card": {
            "cardLinkType": "",
            "cardProgramId": "ZytaraTestProgram",
            "primaryCardReferenceId": "1234567891245",
            "startingNumbers": "123565"
        },
        "profile": {
            "address": "10 Downing Street",
            "cellNumber": "9999999999",
            "city": "Philadelphia",
            "country": "USA",
            "dob": "03/03/1986",
            "email": "jessica.freund@zytara.com",
            "firstName": "Jessica",
            "lastName": "Jessica",
            "middleName": "Freund",
            "postalCode": "09876",
            "ssn": "123456789",
            "stateCode": "PA",
            "suffix": "Senior"
        }
    }
}

addCardReqJsonAcquirer = apply_acquirer(addCardReqJson)

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
    os.environ["environment"] = "test"
    os.environ['request_url'] = request_url
    return handler(event, context)  
  finally:
    xray_recorder.end_segment()

class SuccessResult:
    def __init__(self):
        self.status_code = 200
        self.reason      = "Ok"
    
    def json(self):
        return {"status": 'Success'}

class FailedResultNoJsonMethod:
    def __init__(self):
        self.status_code = 500
        self.reason      = "Internal Server Error"
        self.headers     = "headers"
    
class FailedResult(FailedResultNoJsonMethod):
    def json(self):
        return {"status": 'Failed'}
    
class FailedResultBadJson(FailedResultNoJsonMethod):
    def json(self):
        raise Exception("Bad Json")
        
class TestFunction(unittest.TestCase):
  def boto_secrets_manager_client(self):
    class MockBotoClient:
        def get_secret_value(self, SecretId):
            return { 'SecretString' : jsonpickle.encode(managed_secrets) }
  
    return MockBotoClient()

  def common_validation(self, *args, **kwargs):
        # validate the auth parameter
        self.assertEqual(kwargs['auth'], ('bmullins', 'helloworld123'))
    
        # validate the content-type
        self.assertEqual(kwargs['headers']['Content-type'], 'application/json')      

  def test_empty_json(self):
        context = {'requestid' : '456'}
        empty_json = {}
        result = call_lambda(whoami(), empty_json, context)
        self.assertEqual(result["status_code"], 400)

  def test_bad_json(self):
        context = {'requestid' : '456'}
        bad_request = { "key1" : "hello", "key2" : "hello"}
        result = call_lambda(whoami(), bad_request, context)
        self.assertEqual(result["status_code"], 400)
  
  def test_echo_request(self):
    def request_mock(*args, **kwargs):
        # validate the URL
        if args[1] != 'https://%s:6443/MCPWebServicesRestful/services/MCPWSHandler/echo' % request_url:
            self.assertFalse('%s - bad url' % args[1])

        # validate the formed request
        self.assertEqual(jsonpickle.decode(kwargs['data']), echoReqJsonAcquirer, "request json should match")
    
        self.common_validation(*args, **kwargs)
        
        return SuccessResult()

    with mock.patch('secrets_manager.boto_secrets_manager_client', new = self.boto_secrets_manager_client):
        with mock.patch('requests.Session.post', new=request_mock):
            context = {'requestid' : '123'}
            result = call_lambda(whoami(), echoReqJson, context)
            self.assertEqual(result["json"], {"status": 'Success'}, "json should match")
            self.assertEqual(result["status_code"], 200, "status_code should match")
            self.assertEqual(result["reason"], 'Ok', "reason should match")
  
  def addcard_common_validation(self, *args, **kwargs):
        # validate the URL
        if args[1] != 'https://%s:6443/MCPWebServicesRestful/services/MCPWSHandler/addCard' % request_url:
            self.assertFalse('%s - bad url' % args[1])

        # validate the formed request
        self.assertEqual(jsonpickle.decode(kwargs['data']), addCardReqJsonAcquirer, "echo request json should match")
        
        self.common_validation(*args, **kwargs)
      
  def test_addcard_request_failed_bad_json(self):
    def request_mock(*args, **kwargs):
        self.addcard_common_validation(*args, **kwargs)
        return FailedResultBadJson()

    with mock.patch('secrets_manager.boto_secrets_manager_client', new = self.boto_secrets_manager_client):
        with mock.patch('requests.Session.post', new=request_mock):
            context = {'requestid' : '456'}
            result = call_lambda(whoami(), addCardReqJson, context)
            self.assertEqual(result["json"], '{}', "json should match")
            self.assertEqual(result["status_code"], 500, "status_code should match")
            self.assertEqual(result["reason"], 'Internal Server Error', "reason should match")
      
  def test_addcard_request_failed(self):
    def request_mock(*args, **kwargs):
        self.addcard_common_validation(*args, **kwargs)
        return FailedResult()

    with mock.patch('secrets_manager.boto_secrets_manager_client', new = self.boto_secrets_manager_client):
        with mock.patch('requests.Session.post', new=request_mock):
            context = {'requestid' : '456'}
            result = call_lambda(whoami(), addCardReqJson, context)
            self.assertEqual(result["json"], {"status": 'Failed'}, "json should match")
            self.assertEqual(result["status_code"], 500, "status_code should match")
            self.assertEqual(result["reason"], 'Internal Server Error', "reason should match")
      
  def test_addcard_request(self):
    def request_mock(*args, **kwargs):
        self.addcard_common_validation(*args, **kwargs)
        return SuccessResult()

    with mock.patch('secrets_manager.boto_secrets_manager_client', new = self.boto_secrets_manager_client):
        with mock.patch('requests.Session.post', new=request_mock):
            context = {'requestid' : '456'}
            result = call_lambda(whoami(), addCardReqJson, context)
            self.assertEqual(result["json"], {"status": 'Success'}, "json should match")
            self.assertEqual(result["status_code"], 200, "status_code should match")
            self.assertEqual(result["reason"], 'Ok', "reason should match")

  def test_retries(self):
    def spy_decorator(method_to_decorate):
        my_mock = unittest.mock.MagicMock()

        def wrapper(self, *args, **kwargs):
            url = args[1] if len(args) > 0 else kwargs['url']
            # trigger mock for counting requests
            if url == '/500':
                my_mock(*args, **kwargs)

            return method_to_decorate(self, *args, **kwargs)

        wrapper.mock = my_mock
        return wrapper

    # Preparing session beforehand. It needed for closing after the test.
    os.environ['request_url'] = request_url
    session = Request()._get_session()
    def mock_session(self):
        return session

    # Using mock url because we just want to test retries logic
    def mock_request_url(self, api):
        return "https://httpstat.us/500"

    # Decorator for a method that will help count requests
    decorated = spy_decorator(HTTPConnectionPool.urlopen)
    with mock.patch('secrets_manager.boto_secrets_manager_client', new=self.boto_secrets_manager_client):
        with unittest.mock.patch.object(Request, '_get_url', mock_request_url):
            with unittest.mock.patch.object(Request, '_get_session', mock_session):
                with unittest.mock.patch.object(HTTPConnectionPool, 'urlopen', decorated):
                    result = call_lambda(whoami(), echoReqJson, {'requestid': '456'})
                session.close()

    total_requests_count = 6  # 1 original request + 5 retries
    self.assertEqual(decorated.mock.call_count, total_requests_count, 'Requests count should match')
    self.assertEqual(result, {'status_code': 503, 'reason': 'Max retries exceeded', 'json': '{}'},
                     'Max retries exceeded error response should match')

if __name__ == '__main__':
    logging.disable(logging.CRITICAL)
    unittest.main()
