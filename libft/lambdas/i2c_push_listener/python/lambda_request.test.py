import inspect
import logging
import os
import unittest
from unittest import mock

import jsonpickle
from aws_xray_sdk.core import xray_recorder
from parameterized import parameterized

from lambda_response import ResponseCode

acquirer = {
    "id": "ZytaraTest",
    "password": "helloworld123",
    "userId": "ZytaraUser"
}

managed_secrets = {
    "acquirer_userid": acquirer["userId"],
    "acquirer_password": acquirer["password"],
    "acquirer_id": acquirer["id"]
}


def apply_acquirer(json):
    json2 = dict(json)
    key = list(json2.keys())[0]
    json2[key]["acquirer"] = acquirer
    return json2


health_or_notification_id = 1234
sm_mock = 'secrets_manager.boto_secrets_manager_client'
header_correct_auth = {
    "Id": "ZytaraTest",
    "UserId": "ZytaraUser",
    "Password": "helloworld123"
}

header_wrong_id = {
    "Id": "ZytaraWrong",
    "UserId": "ZytaraUser",
    "Password": "helloworld123"
}

header_wrong_password = {
    "Id": "ZytaraTest",
    "UserId": "ZytaraUser",
    "Password": "incorrect"
}

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


def call_lambda(test_name, event):
    xray_recorder.begin_segment(test_name)
    try:
        os.environ["environment"] = "test"
        os.environ["queue_url"] = "['test']"
        context = {'requestid': '456'}
        return handler(event, context)
    finally:
        xray_recorder.end_segment()


def boto_secrets_manager_client():
    class MockBotoClient:
        def get_secret_value(self, SecretId):
            return {'SecretString': jsonpickle.encode(managed_secrets)}

    return MockBotoClient()


class TestFunction(unittest.TestCase):

    @parameterized.expand([
        ("successful", header_correct_auth, ResponseCode.APPROVED.value),
        ("wrong_id", header_wrong_id, ResponseCode.INV_ACQUIRER.value),
        ("wrong_password", header_wrong_password, ResponseCode.ACQ_BAD_USER.value),
    ])
    def test_health_check(self, name, header, code):
        health_check = {
            "Header": header,
            "HealthCheckId": health_or_notification_id
        }
        with mock.patch(sm_mock, new=boto_secrets_manager_client):
            result = call_lambda(whoami(), health_check)
            self.assertEqual(result["ResponseCode"], code)
            self.assertEqual(result["HealthCheckId"], health_check["HealthCheckId"])

    @parameterized.expand([
        ("successful", header_correct_auth, ResponseCode.APPROVED.value),
        ("wrong_id", header_wrong_id, ResponseCode.INV_ACQUIRER.value),
        ("wrong_password", header_wrong_password, ResponseCode.ACQ_BAD_USER.value),
    ])
    def test_notification_auth_event(self, name, header, code):
        def boto_sqs_client():
            class MockBotoClient:
                def send_message(self, QueueUrl, MessageBody, MessageGroupId):
                    pass

            return MockBotoClient()

        notification_event_check = {
            "Header": header,
            "Card": {
                "CustomerId": 1
            },
            "Transaction": {
                "NotificationEventId": health_or_notification_id
            }
        }
        with mock.patch(sm_mock, new=boto_secrets_manager_client):
            with mock.patch('sqs.boto_sqs_client', new=boto_sqs_client):
                result = call_lambda(whoami(), notification_event_check)
                self.assertEqual(result["ResponseCode"], code)
                self.assertEqual(result["NotificationEventId"],
                                 notification_event_check["Transaction"]["NotificationEventId"])

    def test_unknown_auth_event(self):
        some_event = {
            "Header": header_correct_auth,
            "SomeEvent": "SomeValue"
        }
        with mock.patch(sm_mock, new=boto_secrets_manager_client) and self.assertRaises(Exception) as exc_content:
            call_lambda(whoami(), some_event)
        self.assertIn('An event is not a health check or notification event.', str(exc_content.exception))

    def test_sqs_send_message_failed(self):
        def boto_sqs_client():
            class MockBotoClient:
                def send_message(self, QueueUrl, MessageBody, MessageGroupId):
                    raise Exception()

            return MockBotoClient()

        notification_event_check = {
            "Header": header_correct_auth,
            "Card": {
                "CustomerId": 1
            },
            "Transaction": {
                "NotificationEventId": health_or_notification_id
            }
        }
        with mock.patch(sm_mock, new=boto_secrets_manager_client):
            with mock.patch('sqs.boto_sqs_client', new=boto_sqs_client):
                result = call_lambda(whoami(), notification_event_check)
                self.assertEqual(result["ResponseCode"], ResponseCode.ERROR.value)
                self.assertEqual(result["NotificationEventId"],
                                 notification_event_check["Transaction"]["NotificationEventId"])


if __name__ == '__main__':
    logging.disable(logging.CRITICAL)
    unittest.main()
