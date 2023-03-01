from ast import literal_eval

import boto3
import jsonpickle

from lambda_env import LambdaEnv
from lambda_response import ResponseCode
from mask_logging import logger

logger = logger.get_logger()


class SqsMessage:
    def __init__(self, event_notification):
        self._transaction = event_notification["Transaction"]
        self._card = event_notification["Card"]

    def to_message(self):
        return jsonpickle.encode({"Transaction": self._transaction, "Card": self._card})


def boto_sqs_client():
    session = boto3.session.Session()
    logger.info("Creating boto client session in region: " + session.region_name)
    return session.client(service_name='sqs', region_name=session.region_name)


def send_message(notification_event):
    client = boto_sqs_client()
    key = "queue_url"
    queue_urls = LambdaEnv([key]).value(key)
    logger.info("Sending messages to queues: " + queue_urls)
    queue_urls = literal_eval(queue_urls)
    try:
        for queue_url in queue_urls:
            client.send_message(
                QueueUrl=queue_url,
                MessageBody=SqsMessage(notification_event).to_message(),
                MessageGroupId=notification_event["Card"]["CustomerId"]
            )
            logger.info("Message successfully sent to queue " + queue_url)
    except Exception as e:
        logger.error("Exception while sending message to SQS: ")
        logger.error(e)
        return ResponseCode.ERROR.value
    else:
        return ResponseCode.APPROVED.value
