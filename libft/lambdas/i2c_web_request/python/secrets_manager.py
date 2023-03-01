import base64

import boto3
import cachetools.func
from botocore.exceptions import ClientError

from mask_logging import logger

logger = logger.get_logger()


def boto_secrets_manager_client():
    """Create a Secrets Manager client"""
    session = boto3.session.Session()
    logger.info("Creating boto client session in region: " + session.region_name)
    return session.client(service_name='secretsmanager', region_name=session.region_name)


@cachetools.func.ttl_cache(maxsize=16, ttl=900)
def get_secret(secret_name):
    client = boto_secrets_manager_client()
    try:
        get_secret_value_response = client.get_secret_value(SecretId=secret_name)
    except ClientError as e:
        raise e
    else:
        # Decrypts secret using the associated KMS CMK.
        # Depending on whether the secret is a string or binary, one of these fields will be populated.
        if 'SecretString' in get_secret_value_response:
            return get_secret_value_response['SecretString']

        return base64.b64decode(get_secret_value_response['SecretBinary'])

if __name__ == "__main__":
    print(get_secret('i2c_restapi_dev'))
