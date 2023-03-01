import logging

import boto3
from botocore.exceptions import ClientError

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def boto_cognito_client():
    session = boto3.session.Session()
    logging.info("Creating boto client session for cognito in region: " + session.region_name)

    return session.client(service_name='cognito-idp', region_name=session.region_name)


def set_cognito_group(user_pool_id, username, group_name):
    client = boto_cognito_client()
    try:
        response = client.admin_add_user_to_group(
            UserPoolId=user_pool_id,
            Username=username,
            GroupName=group_name
        )
    except ClientError as e:
        raise e
    else:
        return response
