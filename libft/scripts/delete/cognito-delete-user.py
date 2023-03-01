import boto3 as aws
import pandas as pd

client_cognito = aws.client('cognito-idp')
getProperties = pd.read_csv('CognitoUsers.csv',header=0)
usernames = getProperties['email']

for username in usernames:
    response = client_cognito.admin_delete_user(
        UserPoolId="us-east-1_xxxxxxxxx",
        Username = username,
    )