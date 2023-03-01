import inspect
import logging
import os
import unittest
from unittest import mock

from aws_xray_sdk.core import xray_recorder

logger = logging.getLogger()
xray_recorder.configure(
    context_missing='LOG_ERROR'
)

xray_recorder.begin_segment('test_init')
request = __import__('lambda_request')
handler = request.lambda_handler
xray_recorder.end_segment()

env_type = "ENV_TYPE"
prod = "prod"
stage = "staging"
post_request = "requests.post"


def whoami():
    return inspect.stack()[1][3]


def call_lambda(test_name, event, context):
    xray_recorder.begin_segment(test_name)
    try:
        os.environ["API_DNS_NAME"] = "dummy"
        return handler(event, context)
    finally:
        xray_recorder.end_segment()


class SuccessResult:
    def __init__(self, is_added_to_wait_list):
        self.status_code = 200
        self.reason = "Ok"
        self.headers = "test"
        self.is_added_to_wait_list = is_added_to_wait_list

    def json(self):
        return {"status": "Success", "addedToWaitList": self.is_added_to_wait_list}


class TestFunction(unittest.TestCase):
    def request_mock(*args, **kwargs):
        return SuccessResult("")

    def request_allowed_early_access_mock(*args, **kwargs):
        return SuccessResult(False)

    def request_disallowed_early_access_mock(*args, **kwargs):
        return SuccessResult(True)

    def test_empty_json(self):
        context = {'requestid': '456'}
        empty_json = {}

        with self.assertRaises(Exception) as exc_content:
            os.environ[env_type] = prod
            call_lambda(whoami(), empty_json, context)
        self.assertIn('invalid request json - no \'request\' details', str(exc_content.exception))

    def test_request_early_access_false_valid(self):
        context = {'requestid': '456'}
        json = {
            "request": {
                "clientMetadata": {
                    "earlyAccess": "false"
                },
                "userAttributes": {
                    "email": "test1@zytara.com"
                }
            }
        }

        with mock.patch(post_request, new=self.request_allowed_early_access_mock):
            os.environ[env_type] = prod
            result = call_lambda(whoami(), json, context)
            self.assertEqual(result, json)

    def test_request_early_access_false_invalid(self):
        context = {'requestid': '456'}
        json = {
            "request": {
                "clientMetadata": {
                    "earlyAccess": "false"
                },
                "userAttributes": {
                    "email": "test2@zytara.com"
                }
            }
        }

        with mock.patch(post_request, new=self.request_disallowed_early_access_mock):
            with self.assertRaises(Exception):
                os.environ[env_type] = prod
                call_lambda(whoami(), json, context)

    def test_request_early_access(self):
        context = {'requestid': '456'}
        json = {
            "request": {
                "clientMetadata": {
                    "earlyAccess": "true"
                },
                "userAttributes": {
                    "email": "test3@zytara.com"
                }
            }
        }
        with mock.patch(post_request, new=self.request_mock):
            with self.assertRaises(Exception) as exc_content:
                os.environ[env_type] = prod
                call_lambda(whoami(), json, context)
            self.assertIn('Success', str(exc_content.exception))

    def test_request_early_access_with_not_zytara_email_in_prod(self):
        context = {'requestid': '456'}
        json = {
            "request": {
                "clientMetadata": {
                    "earlyAccess": "true"
                },
                "userAttributes": {
                    "email": "test@gmail.com"
                }
            }
        }
        with mock.patch(post_request, new=self.request_mock):
            with self.assertRaises(Exception) as exc_content:
                os.environ[env_type] = prod
                call_lambda(whoami(), json, context)
            self.assertIn('Success', str(exc_content.exception))

    def test_request_early_access_with_not_zytara_email_in_stage(self):
        context = {'requestid': '456'}
        json = {
            "request": {
                "clientMetadata": {
                    "earlyAccess": "true"
                },
                "userAttributes": {
                    "email": "test@gmail.com"
                }
            }
        }
        with mock.patch(post_request, new=self.request_mock):
            with self.assertRaises(Exception) as exc_content:
                os.environ[env_type] = stage
                call_lambda(whoami(), json, context)
            self.assertIn('invalid request json - domain name is not \'zytara.com\'', str(exc_content.exception))


if __name__ == '__main__':
    logging.disable(logging.CRITICAL)
    unittest.main()
