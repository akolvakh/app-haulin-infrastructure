#########################
###FOR LOCAL DEBUGGING###
#########################
import boto3
import os
import json
import sys
import logging
import phonenumbers
from phonenumbers import geocoder
from phonenumbers.phonenumberutil import (
    region_code_for_country_code,
    region_code_for_number,
)

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def ft_send_sms(number, message):
    """docstring for fname"""
    #example for phonenumber and message in json
    # number = '+380993713793'
    # message = {"foo": "bar"}
    
    #also check this sns boto3 function in doc.
    #maybe you need to specify additional arguments - region, arn, etc.
    client = boto3.client('sns')
    response = client.publish(
        PhoneNumber = number,
        Message=json.dumps({'default': json.dumps(message)}),
        MessageStructure='json'
    )

def main():
    #here instead of string-phonenumber should be phonenumber from cognito evant ==>  phone_number = event['request']["userAttributes"]["phone_number"]
    my_number = phonenumbers.parse("+12012987481")
    print(my_number)
    
    #this is just to see specific geolocation (state, city)
    geolocation = geocoder.description_for_number(my_number,"en")
    print(geolocation)
    
    country = region_code_for_country_code(my_number.country_code)
    print(country)
    
    if country == "US":
        #uncomment this block and pass needed arguments into function
        # ft_send_sms(PHONENUMBER, MESSAGE)
        return {
        'statusCode': 200,
        'body': json.dumps('This is fine fire!')
        }
    else:
        return {
        'statusCode': 400,
        'body': json.dumps('This is not USA phone number!')
        }
    
    
if __name__ == "__main__":
    sys.exit(main())






#########################
###FOR AWS LAMBDA     ###
#########################
import boto3
import os #maybe you don't need this module in lambda
import json
import logging
import phonenumbers
from phonenumbers import geocoder
from phonenumbers.phonenumberutil import (
    region_code_for_country_code,
    region_code_for_number,
)

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def ft_send_sms(number, message):
    """docstring for fname"""
    #example for phonenumber and message in json
    # number = '+380993713793'
    # message = {"foo": "bar"}
    
    #also check this sns boto3 function in doc.
    #maybe you need to specify additional arguments - region, arn, etc.
    client = boto3.client('sns')
    response = client.publish(
        PhoneNumber = number,
        Message=json.dumps({'default': json.dumps(message)}),
        MessageStructure='json'
    )

def lambda_handler(event, context):
    
    request         = event['request']
    trigger_source  = event['triggerSource']
    phone_number    = request["userAttributes"]["phone_number"]
    message         = request["userAttributes"]["message"] #IDK is it right? or maybe it is located in another attribute. Also, check format - is it JSON or STRING?
    
    trigger_number = phonenumbers.parse(phone_number)
    print(my_number)
    
    #this is just to see specific geolocation (state, city)
    geolocation = geocoder.description_for_number(trigger_number,"en")
    print(geolocation)
    
    country = region_code_for_country_code(trigger_number.country_code)
    print(country)
    
    if country == "US":
        ft_send_sms(trigger_number, message)
        return {
        'statusCode': 200,
        'body': json.dumps('The sms was successfully sent!')
        }
    else:
        return {
        'statusCode': 400,
        'body': json.dumps('This is not USA phone number! The sms was not sent!')
        }
    
    
    logger.info('Trigger source = %s', trigger_source)
    logger.info('Phone number = %s', phone_number)
    logger.info('Request = %s', request)












# Do you need this 'CustomSMSSender_UpdateUserAttribute' check? Or this is for what?

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
    
    
    
# logger.info(print(geocoder.description_for_number(my_number,"en")))