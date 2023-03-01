import unittest
import logging
import inspect
from unittest import mock

logger = logging.getLogger()
request = __import__('lambda_request')
handler = request.lambda_handler

def whoami():
    return inspect.stack()[1][3]

def call_lambda(test_name, event, context):
    logger.warning('## EVENT')
    return handler(event, context)

class SuccessResult:
    def __init__(self):
        self.status_code = 200
        self.reason = "Ok"
        self.headers = "test"

    def json(self):
        return {"status": "Success"}

class TestFunction(unittest.TestCase):
    def request_mock(self):
        return SuccessResult()

    def test_request(self):
        context = {'requestid': '456'}
        json = {
                "version": "1.0",
                "context": {
                    "eventType": "viewer-response"
                },
                "viewer": {
                    "ip": "0.0.0.0"
                },
                "request": {
                    "method": "GET",
                    "uri": "/index.html",
                    "querystring": {
                        "test": { "value": "true" },
                        "arg": { "value": "val1", "multivalue": [ { "value": "val1" }, { "value": "val2" } ] }
                    },
                    "headers": {
                        "host": { "value": "www.example.com" },
                        "accept": { "value": "text/html", "multivalue": [ { "value": "text/html" }, { "value": "application/xhtml+xml" } ] }
                    },
                    "cookies": {
                        "id": { "value": "CookeIdValue" },
                        "loggedIn": { "value": "false" }
                    }
                },
                "Records": [
                    {
                         "cf": {
                              "response": {
                                  "statusCode": 200,
                                  "statusDescription": "OK",
                                  "headers": {
                                      "content-type": {"value": "text/html; charset=UTF-8"}
                                  }
                              }
                         }
                    }
                ],
                "response": {
                    "statusCode": 200,
                    "statusDescription": "OK",
                    "headers": {
                        "server": { "value": "CustomOriginServer" },
                        "content-type": {"value": "text/html; charset=UTF-8"},
                        "content-length": {"value": "9593" }
                    },
                    "cookies": {
                        "id": { "value": "a3fWa", "multivalue": [ { "value": "a3fWa" }, { "value": "a3fWb" } ], "attributes": "Expires=Wed, 05 Jan 2024 07:28:00 GMT" },
                        "loggedIn": { "value": "true", "attributes": "Secure; Path=/; Domain=example.com; Expires=Wed, 05 Jan 2024 07:28:00 GMT" }
                    }
                }
            }

        with mock.patch('requests.post', new=self.request_mock):
            result = call_lambda(whoami(), json, context)
            self.assertEqual([{ "key": "Cache-Control", "value": "public, max-age=432000" }], result["headers"]["cache-control"])


if __name__ == '__main__':
    logging.disable(logging.CRITICAL)
    unittest.main()