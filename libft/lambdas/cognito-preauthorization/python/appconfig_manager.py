import boto3, os
from botocore.exceptions import ClientError
import logging
import cachetools.func

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def boto_ssm_client():
    session = boto3.session.Session()
    logging.info("Creating boto client session for Ssm in region: " + session.region_name)
    return session.client(service_name='ssm', region_name=session.region_name)


@cachetools.func.ttl_cache(maxsize=16, ttl=900)
def get_version_configurations(parameter_name):
    client = boto_ssm_client()
    try:
        get_configuration_response = client.get_parameter(Name=parameter_name)
    except ClientError as e:
        raise e
    else:
        return get_configuration_response['Parameter']['Value']
