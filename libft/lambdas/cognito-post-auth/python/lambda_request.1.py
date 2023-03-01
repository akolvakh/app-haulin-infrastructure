import json
import boto3
import psycopg2
import os

def getCredentials():
    credential = {}
    
    secret_name = os.environ["SECRET_NAME"]
    region_name = os.environ["REGION"]
    
    client = boto3.client(
      service_name='secretsmanager',
      region_name=region_name
    )
    
    get_secret_value_response = client.get_secret_value(
      SecretId=secret_name
    )
    
    secret = json.loads(get_secret_value_response['SecretString'])
    
    credential['username']    = secret['username']
    credential['password']    = secret['password']
    credential['host']        = secret['host']
    credential['db']          = secret['db']
    credential['userPoolId']  = secret['userPoolId']

    return credential

def lambda_handler(event, context):

    #Check cognito user status

    if event['request']['userAttributes']['cognito:user_status'] == "CONFIRMED":
      return event
    else:
      credential = getCredentials()
      connection = psycopg2.connect(user=credential['username'], password=credential['password'], host=credential['host'], database=credential['db'])
      cursor = connection.cursor()
      query = "UPDATE tutor set status = %s WHERE email = %s"
      cursor.execute(query,('LIVE', event['request']['userAttributes']['email'], ))
      cursor.close()
      connection.commit()
      count = cursor.rowcount

      print(event)

      if event['request']['userAttributes']['email_verified'] == "true":
        return event
      else:
        credential = getCredentials()
        client = boto3.client('cognito-idp')
        UserPool_Id = credential['userPoolId']
        group = client.admin_update_user_attributes(
                      UserPoolId=UserPool_Id,
                      Username=event['userName'],
                      # Username=event['request']['userAttributes']['sub'],
                      UserAttributes=[
                          {
                              'Name': 'email_verified',
                              'Value': 'true'
                          },
                      ],
                  )

      print(count, "Successfully Updated!")
      return event


  # data=('m.maksitaliev@gmail.com')
  # results = cursor.fetchall()


  # Debugging
  # print(event['request']['userAttributes']['email'])
  # print(event['request']['userAttributes']['cognito:user_status'])
  # json.loads(json.dumps(event['request']['userAttributes']))
  # j = json.dumps(event['request']['userAttributes'])
  # print(j)