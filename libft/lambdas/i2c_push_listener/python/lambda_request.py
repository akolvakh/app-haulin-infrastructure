from aws_xray_sdk.core import patch_all

import sqs
from acquirer_details import AcquirerDetails, ResponseCode
from lambda_env import LambdaEnv
from lambda_response import HealthCheckResponse, EventNotificationResponse
from mask_logging import logger

logger = logger.get_logger()
patch_all()


class Request:
    def __call__(self, event, context):
        caller_id = get_caller_id()
        logger.info("Caller ID:" + caller_id)
        acquirer = AcquirerDetails.get_acquirer_details(caller_id)
        response_code = acquirer.auth(event)

        if "HealthCheckId" in event:
            logger.info("Health check event.")
            return HealthCheckResponse(response_code, event["HealthCheckId"])
        elif "Transaction" in event:
            logger.info("Notification event.")
            if ResponseCode.APPROVED.value == response_code:
                response_code = sqs.send_message(event)
                return EventNotificationResponse(response_code, event["Transaction"]["NotificationEventId"])
            else:
                return EventNotificationResponse(response_code, event["Transaction"]["NotificationEventId"])
        else:
            raise Exception('An event is not a health check or notification event.')


def get_caller_id(base="i2c_push_api_", key="environment"):
    lenv = LambdaEnv([key])
    return base + lenv.value(key)


def lambda_handler(event, context):
    logger.info('## EVENT:')
    logger.info(event)
    logger.info('## CONTEXT:')
    logger.info(context)
    result = dict(Request()(event, context).json())
    logger.info('## RESULT:')
    logger.info(result)
    return result
