import os
import unittest
import logging
import jsonpickle
import inspect
from unittest import mock

from aws_xray_sdk.core import xray_recorder

logger = logging.getLogger()
xray_recorder.configure(
    context_missing='LOG_ERROR'
)

app_config = {
    "ios-minimal-version": "1.5.0",
    "android-minimal-version": "2.0.0"
}

xray_recorder.begin_segment('test_init')
request = __import__('lambda_request')
handler = request.lambda_handler
xray_recorder.end_segment()


def call_lambda(test_name, event, context):
    xray_recorder.begin_segment(test_name)
    try:
        os.environ["ENV_TYPE"] = "dummy"
        return handler(event, context)
    finally:
        xray_recorder.end_segment()


def whoami():
    return inspect.stack()[1][3]


class TestFunction(unittest.TestCase):
    def get_parameter(self, Name):
        return jsonpickle.encode(app_config)

    def test_force_update_request_with_lower_version(self):
        with mock.patch('appconfig_manager.get_version_configurations', new=self.get_parameter):
            context = {'requestid': '456'}
            event = {
                "callerContext": {
                    "awsSdkVersion": "aws-sdk-ios-2.22.1",
                },
                "request": {
                    "userAttributes": {
                        "userName": "string"
                    },
                    "validationData": {
                        "ios": "1.3.0"
                    }
                }
            }

            with self.assertRaises(Exception) as exc_content:
                call_lambda(whoami(), event, context)
            self.assertIn("Outdated version of application", str(exc_content.exception))
            self.assertEqual("string", event["request"]["userAttributes"]["userName"])

    def test_force_update_request_without_version(self):
        with mock.patch('appconfig_manager.get_version_configurations', new=self.get_parameter):
            context = {'requestid': '456'}
            event = {
                "callerContext": {
                    "awsSdkVersion": "aws-sdk-android-2.22.1",
                },
                "request": {
                    "userAttributes": {
                        "userName": "string"
                    },
                    "validationData": {
                    }
                }
            }
            with self.assertRaises(Exception) as exc_content:
                call_lambda(whoami(), event, context)
            self.assertIn("Outdated version of application", str(exc_content.exception))
            self.assertEqual("string", event["request"]["userAttributes"]["userName"])

    def test_force_update_request_without_version_not_from_mobile(self):
        with mock.patch('appconfig_manager.get_version_configurations', new=self.get_parameter):
            context = {'requestid': '456'}
            event = {
                "callerContext": {
                    "awsSdkVersion": "aws-sdk",
                },
                "request": {
                    "userAttributes": {
                        "userName": "string"
                    },
                    "validationData": {
                    }
                }
            }
            self.assertEqual(call_lambda(whoami(), event, context), event)
            self.assertEqual("string", event["request"]["userAttributes"]["userName"])

    def test_force_update_request_with_same_version(self):
        with mock.patch('appconfig_manager.get_version_configurations', new=self.get_parameter):
            context = {'requestid': '456'}
            event = {
                "callerContext": {
                    "awsSdkVersion": "aws-sdk-ios-2.22.1",
                },
                "request": {
                    "userAttributes": {
                        "userName": "string"
                    },
                    "validationData": {
                        "ios": "1.5.0"
                    }
                }
            }
            self.assertEqual(call_lambda(whoami(), event, context), event)

    def test_force_update_request_with_higher_version(self):
        with mock.patch('appconfig_manager.get_version_configurations', new=self.get_parameter):
            context = {'requestid': '456'}
            event = {
                "callerContext": {
                    "awsSdkVersion": "aws-sdk-android-2.22.1",
                },
                "request": {
                    "userAttributes": {
                        "userName": "string"
                    },
                    "validationData": {
                        "android": "2.0.1"
                    }
                }
            }
            self.assertEqual(call_lambda(whoami(), event, context), event)


if __name__ == '__main__':
    logging.disable(logging.CRITICAL)
    unittest.main()
