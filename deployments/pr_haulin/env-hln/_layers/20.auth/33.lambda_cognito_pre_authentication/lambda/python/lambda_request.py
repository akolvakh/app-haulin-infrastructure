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
    
    credential['username']   = secret['username']
    credential['password']   = secret['password']
    credential['host']       = secret['host']
    credential['db']         = secret['db']
    credential['userPoolId'] = secret['userPoolId']
    
    return credential

def get_admin_details(email):
    try:
        credential = getCredentials()
        connection = psycopg2.connect(user=credential['username'],
                                      password=credential['password'],
                                      host=credential['host'],
                                      database=credential['db'])

        print("Using Python variable in PostgreSQL select Query")
        cursor = connection.cursor()
        postgreSQL_select_Query = "select * from admin where email = %s"
        cursor.execute(postgreSQL_select_Query, (email,))
        admin_records = cursor.fetchall()

        return admin_records

    except (Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        # closing database connection
        if connection:
            cursor.close()
            connection.commit()
            connection.close()
            print("PostgreSQL connection is closed \n")

def get_admin_status(email):
    try:
        credential = getCredentials()
        connection = psycopg2.connect(user=credential['username'],
                                      password=credential['password'],
                                      host=credential['host'],
                                      database=credential['db'])

        print("Using Python variable in PostgreSQL select Query")
        cursor = connection.cursor()
        postgreSQL_select_Query = "select user_status from admin where email = %s"
        cursor.execute(postgreSQL_select_Query, (email,))
        admin_records = cursor.fetchone()

        return admin_records[0]

    except (Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        # closing database connection
        if connection:
            cursor.close()
            connection.commit()
            connection.close()
            print("PostgreSQL connection is closed \n")

def add_admin(event, context):
    try:
        credential = getCredentials()
        connection = psycopg2.connect(user=credential['username'],
                                      password=credential['password'],
                                      host=credential['host'],
                                      database=credential['db'])

        print("Using Python variable in PostgreSQL select Query")
        cursor = connection.cursor()
        postgreSQL_select_Query = "INSERT INTO admin (user_status, first_name, last_name, email, gender) VALUES(%s, %s, %s, %s, %s)"
        cursor.execute(postgreSQL_select_Query,('LIVE', 'test', 'test', event['request']['userAttributes']['email'], 'OTHER', ))

    except (Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        # closing database connection
        if connection:
            cursor.close()
            connection.commit()
            connection.close()
            print("PostgreSQL connection is closed \n")

def update_status(event, context):
    try:
        credential = getCredentials()
        connection = psycopg2.connect(user=credential['username'],
                                      password=credential['password'],
                                      host=credential['host'],
                                      database=credential['db'])

        print("Using Python variable in PostgreSQL UPDATE Query")
        cursor = connection.cursor()
        postgreSQL_select_Query = "UPDATE admin set user_status = %s WHERE email = %s"
        cursor.execute(postgreSQL_select_Query,('LIVE', event['request']['userAttributes']['email'], ))

    except (Exception, psycopg2.Error) as error:
        print("Error fetching data from PostgreSQL table", error)

    finally:
        # closing database connection
        if connection:
            cursor.close()
            connection.commit()
            connection.close()
            print("PostgreSQL connection is closed \n")

def lambda_handler(event, context):

    credential = getCredentials()

    client = boto3.client('cognito-idp')
    UserPool_Id = credential['userPoolId']

    # group = client.admin_list_groups_for_user(
    #             Username=event['request']['userAttributes']['sub'],
    #             UserPoolId=UserPool_Id
    #         )
    # # refactor it!
    # if group['Groups'][0]['GroupName'] == "admin":
    #   if get_admin_details(event['request']['userAttributes']['email']):
    #       status = get_admin_status(event['request']['userAttributes']['email'])
    #       print(status)
    #       if status == "LIVE":
    #           print("Status is alrady LIVE")
    #           return event
    #       else:
    #           update_status(event, context)
    #   else:
    #       add_admin(event, context)

    # return event




    # Debugging
    print(event['request']['userAttributes']['email'])
    print(event['request']['userAttributes']['cognito:user_status'])
    json.loads(json.dumps(event['request']['userAttributes']))
    j = json.dumps(event['request'])
    print(j)

    group = client.admin_list_groups_for_user(
                Username=event['userName'],
                UserPoolId=UserPool_Id
            )




    # # refactor it!
    # if group['Groups'][0]['GroupName'] == "admin":
    #   if get_admin_details(event['userName']):
    #       status = get_admin_status(event['userName'])
    #       print(status)
    #       if status == "LIVE":
    #           print("Status is alrady LIVE")
    #           return event
    #       else:
    #           update_status(event, context)
    #   else:
    #       add_admin(event, context)

    # return event


        # refactor it!
    if group['Groups'][0]['GroupName'] == "admin":
      if get_admin_details(event['request']['userAttributes']['email']):
          status = get_admin_status(event['request']['userAttributes']['email'])
          print(status)
          if status == "LIVE":
              print("Status is alrady LIVE")
              return event
          else:
              update_status(event, context)
      else:
          add_admin(event, context)

    return event