import json
import os
import logging

import boto3
from kafka import KafkaProducer

EVENT_TYPE_HEADER_NAME = "EVENT_TYPE"

USER_STATUS_AFTER_EMAIL_VERIFICATION = 'ACTIVATED'

logging.basicConfig(format='%(asctime)s %(message)s')
logger = logging.getLogger()
logger.setLevel(logging.INFO)


def get_credentials():
    credential = {}
    secret_name = os.environ["SECRET_NAME"]
    region_name = os.environ["REGION"]

    client = boto3.client(service_name='secretsmanager', region_name=region_name)
    get_secret_value_response = client.get_secret_value(SecretId=secret_name)
    secret = json.loads(get_secret_value_response['SecretString'])

    credential['bootstrap_servers'] = secret['bootstrap_servers']
    credential['users_topic'] = secret['users_topic']
    return credential


def send_message(bootstrap_servers, topic, message):
    try:
        producer = KafkaProducer(bootstrap_servers=bootstrap_servers,
                                 value_serializer=lambda m: json.dumps(m).encode())
        headers = [(EVENT_TYPE_HEADER_NAME, b"USER_REGISTERED")]
        producer.send(topic=topic, value=message, headers=headers)
        producer.flush()
        producer.close()
    except Exception:
        logger.error('Unable to send the topic %s message %s', topic, message)
        raise


def add_user_to_group(tutors_group_name, user_name, user_pool_id):
    client = boto3.client('cognito-idp')
    try:
        client.admin_add_user_to_group(GroupName=tutors_group_name, Username=user_name, UserPoolId=user_pool_id)
    except Exception:
        logger.error('Unable to assign user %s to group %s', user_name, tutors_group_name)
        raise


def extract_groups(group_string):
    if not group_string:
        raise ValueError('User groups value is not present')
    group_string = group_string.replace(' ', '')
    if not group_string:
        raise ValueError('User groups value is empty')
    groups = list(set(group_string.split(',')))
    return groups


def handle_confirmed_user(event, user_attributes):
    credentials = get_credentials()
    group_string = user_attributes.get('custom:groups')

    groups = extract_groups(group_string)

    user_name = event['userName']
    user_event = {
        'firstName': user_attributes.get('name'),
        'lastName': user_attributes.get('family_name'),
        'userName': user_name,
        'email': user_attributes.get('email'),
        'status': USER_STATUS_AFTER_EMAIL_VERIFICATION,
        'phoneNumber': user_attributes.get('phone_number'),
        'groups': groups
    }
    user_pool_id = event['userPoolId']
    for group in groups:
        add_user_to_group(group, user_name, user_pool_id)
    send_message(credentials['bootstrap_servers'], credentials['users_topic'], user_event)


def lambda_handler(event, context):
    if event['triggerSource'] == 'PostConfirmation_ConfirmSignUp':
        user_attributes = event['request']['userAttributes']
        if user_attributes['cognito:user_status'] == "CONFIRMED":
            try:
                handle_confirmed_user(event, user_attributes)
            except Exception:
                logger.error('Unable to handle event %s', event)
                raise
        else:
            logger.warning('Unable to process event, actual user_status=[%s] is not CONFIRMED',
                           user_attributes['cognito:user_status'])
    else:
        logger.warning('Unable to process event, actual trigger=[%s] source is not PostConfirmation_ConfirmSignUp',
                       event['triggerSource'])
    return event
