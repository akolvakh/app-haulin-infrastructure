# Cognito post-confirmation lambda for publishing user created event

Cognito triggers lambda once user confirmed the email. Lambda publishes event to provided Kafka topic.
Event structure:

```json
{
  "id": "a2b3fbb2-e8a1-11ec-967d-2b606f8016ec",
  "userName": "user1",
  "surName": "lastName",
  "email": "test@mail.com",
  "phoneNumber": "+14325551212"
}
```

## Run and testing steps

1. Install python 3.8
2. Generate and activate venv (virtualenv venv)

```shell
virtualenv venv
source venv/bin/activate
```

3. Install dependencies from `requirements.txt` (`pip install -r requirements.txt`)
4. Run `python -m lambda_function_test`

## Cognito post-confirmation trigger deploy prerequisites

1. Lambda packaged to `zip` and deployed
2. Topic for user creation exists in Kafka
3. Cognito user pool has permission `lambda:InvokeFunction`
4. Cognito user pool has custom attribute with name `groups` (Should be created as `custom:groups`) 
5. Cognito groups should be created
and allows web-app to write it. Attribute params **(Type=`String`	MinLength= `0`	MaxLength=`2048` Mutable=`true`)**
5. Lambda has permissions for accessing secret-manager `secretsmanager:GetSecretValue`, `secretsmanager:DescribeSecret`
6. Env variables provided `SECRET_NAME` - name of the secret that stored configs, `REGION` - aws region
7. Secret manager contains keys  
   `bootstrap_servers` - list of host/port pairs for Kafka cluster
   `users_topic` - name of the topic for user creation(topic must be pre-created in Kafka)
8. Lambda has permission `cognito-idp:AdminAddUserToGroup` (lambda assigns user to the group) for the user pool 
where lambda attached
9. DLQ created for this lambda

## Package lambda as .zip

```shell
pip install --target ./package kafka-python==2.0.2 && cd package
zip -r ../lambda_function.zip . && cd ..
zip -g lambda_function.zip lambda_function.py
```
