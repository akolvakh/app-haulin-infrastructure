import boto3
import os
import json
import phonenumbers
from phonenumbers import geocoder
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    
    
    
    
    number = '+380993713793'
    message = {"foo": "bar"}
    
    
    
    
    # request = event['request']
    # trigger_source = event['triggerSource']
    # phone_number = request["userAttributes"]["phone_number"]
    
    my_number = phonenumbers.parse("+380993713793")
    
    my_number = phonenumbers.parse("+380993713793")
    
    print(my_number)
    
    
    # logger.info(print(geocoder.description_for_number(my_number,"en")))
    
    logger.info('Trigger source = %s', trigger_source)
    logger.info('Phone number = %s', phone_number)
    logger.info('Request = %s', request)
    
    
    
    
    
    client = boto3.client('sns')
    response = client.publish(
        # TargetArn=arn,
        PhoneNumber = number,
        Message=json.dumps({'default': json.dumps(message)}),
        MessageStructure='json'
    )
    
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }


# def lambda_handler(event, context):
#     request = event['request']
#     phone_number = request["userAttributes"]["phone_number"]
    
#     trigger_source = event['triggerSource']
#     if trigger_source == 'CustomSMSSender_UpdateUserAttribute'
#         trigger_source = '':
#         get_trigger_source(trigger_source, phone_number)
#         logger.info('Request = %s', request)
#     return event
    
    # from phonenumbers.phonenumberutil import (
    # region_code_for_country_code,
    # region_code_for_number,
    # )
    
    # if event['trigger']
    
    # logger.info(phone_number)