import logging
import boto3

def boto_s3_client():
    session = boto3.session.Session()
    logging.info("Creating boto s3 client session in region: " + session.region_name)
    return session.client(service_name='s3', region_name = session.region_name)

def ssm_get_parameters(names):
    session = boto3.session.Session()
    logging.info("Creating boto ssm client session in region: " + session.region_name)
    ssm = session.client(service_name='ssm', region_name = session.region_name)
    return ssm.get_parameters(Names=names)['Parameters']
