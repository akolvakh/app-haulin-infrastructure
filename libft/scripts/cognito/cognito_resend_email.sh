# set variables in this way - avoid magic numbers and variables
# exceptions
COGNITO_USER_POOL_ID=$1
EMAIL=$2

# #get email + username
# aws cognito-idp admin-get-user --user-pool-id $COGNITO_USER_POOL_ID --username $EMAIL |
# jq -r '.Username' |
# while read user; do
#   echo "Username - $user"
#   USERNAME=$user
#   echo "$USERNAME"
# done

USERNAME=$(aws cognito-idp admin-get-user --user-pool-id $COGNITO_USER_POOL_ID --username $EMAIL | jq -r '.Username')

# verify email
aws cognito-idp admin-get-user --user-pool-id $COGNITO_USER_POOL_ID --username $EMAIL |
jq -r '.UserAttributes | .[1] | .Value' |
while read value; do
    echo "Email_verified - $value"
    echo "USERNAME - $USERNAME"
    if [ "$value" = false ] ; then
        aws cognito-idp admin-update-user-attributes --user-pool-id $COGNITO_USER_POOL_ID --username $USERNAME --user-attributes Name=email_verified,Value=true
    fi
done

#show updated user's attributes
aws cognito-idp admin-get-user --user-pool-id $COGNITO_USER_POOL_ID --username $EMAIL

#resend activation email to user
aws cognito-idp admin-get-user --user-pool-id $COGNITO_USER_POOL_ID --username $EMAIL |
jq -r '.UserStatus' |
while read value; do
    echo "UserStatus - $value"
    if [ "$value" = "FORCE_CHANGE_PASSWORD" ] ; then
        aws cognito-idp admin-create-user --region us-east-1 --user-pool-id $COGNITO_USER_POOL_ID --username "$EMAIL" --message-action RESEND
    fi
done