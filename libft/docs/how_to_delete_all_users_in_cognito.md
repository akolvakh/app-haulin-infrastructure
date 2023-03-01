Here is a bash version based on @ajilpm's batch script:

```
# deleteAllUsers.sh
COGNITO_USER_POOL_ID=$1

aws cognito-idp list-users --user-pool-id $COGNITO_USER_POOL_ID |
jq -r '.Users | .[] | .Username' |
while read user; do
  aws cognito-idp admin-delete-user --user-pool-id $COGNITO_USER_POOL_ID --username $user
  echo "$user deleted"
done

```

You must have *jq* installed and remember to make the script executable: `chmod +x deleteAllUsers.sh`.

The user pool id can be provided as a command line argument: `./deleteAllUsers.sh COGNITO_USER_POOL_ID`.