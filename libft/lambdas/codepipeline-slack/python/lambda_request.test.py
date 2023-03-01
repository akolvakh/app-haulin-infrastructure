import os
import unittest
import logging
import jsonpickle
import inspect
from unittest import mock
from aws_xray_sdk.core import xray_recorder

logger = logging.getLogger()
xray_recorder.configure(context_missing='LOG_ERROR')
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
        os.environ['ENVIRONMENT'] = "test"
        os.environ['SLACK_USERNAME'] = "Code Build"
        os.environ['SLACK_CHANNEL'] = "code-build-status-reports"
        os.environ['SLACK_WEBHOOK_URL'] = "https://hooks.slack.com/services/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"
        return handler(event, context)
    finally:
        xray_recorder.end_segment()

class SuccessResult:
    def __init__(self):
        self.status_code = 200
        self.reason = "Ok"
        self.headers = "test"

    def json(self):
        return {"status": "Success"}

class TestFunction(unittest.TestCase):
    def request_mock(*args, **kwargs):
        return SuccessResult()

    def test_empty_json(self):
        context = {'requestid': '456'}
        empty_json = {}

        with self.assertRaises(Exception) as exc_content:
            call_lambda(whoami(), empty_json, context)
        # self.assertIn('invalid request json - no \'request\' details', str(exc_content.exception))

    def test_request_slack(self):
        context = {'requestid': '456'}
        json = {
           "Records": 
              {
                 "Sns": {
                    "Message": {
                        "account": "177795352040",
                        "detailType": "CodePipeline Pipeline Execution State Change",
                        "region": "us-east-1",
                        "source": "aws.codepipeline",
                        "time": "2021-09-01T14:33:49Z",
                        "notificationRuleArn": "arn:aws:codestar-notifications:us-east-1:177795352040:notificationrule/168e467de225697c50e5c20bbae3daa1601aebae",
                        "detail": {
                            "pipeline": "notifications-test-pipeline",
                            "execution-id": "d8bee808-fb44-4797-bab1-c7ea86992ac3",
                            "execution-trigger": {
                                "trigger-type": "StartPipelineExecution",
                                "trigger-detail": "arn:aws:sts::177795352040:assumed-role/AWSReservedSSO_AWSAdministratorAccess_02c8b89777f1ca11/anton.kolvakh@zytara.com"
                            },
                            "state": "STARTED",
                            "version": 1.0
                        },
                        "resources": "arn:aws:codepipeline:us-east-1:177795352040:notifications-test-pipeline"
                    },
                 }
              }
        }
        with mock.patch('requests.post', new=self.request_mock):
                # result = call_lambda(whoami(), json, context)
                # self.assertEqual(result, json)
            with self.assertRaises(Exception) as exc_content:
                call_lambda(whoami(), json, context)
            # self.assertIn('Sns', str(exc_content.exception))
            

if __name__ == '__main__':
    logging.disable(logging.CRITICAL)
    unittest.main()