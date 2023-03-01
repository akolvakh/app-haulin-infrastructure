# Resend email

```jsx
aws cognito-idp admin-get-user --user-pool-id us-east-1_TApa2HLk9 --username jane@example.com
```

```jsx
aws cognito-idp admin-update-user-attributes --user-pool-id us-east-1_TApa2HLk9 --username 3273a829-a589-4a66-91f3-f38cc31d321f --user-attributes Name=email_verified,Value=true
```

```jsx
aws cognito-idp admin-create-user --region us-east-1 --user-pool-id us-east-1_TApa2HLk9 --username "${array[i]}" --message-action RESEND
```

```jsx
aws cognito-idp admin-set-user-password --user-pool-id "us-east-1_TApa2HLk9"  --username "1e209373-5e0a-4e0a-8404-ed391cb8cb69" --password "@A31121965a@" --permanent
```

# Change email

```jsx
aws cognito-idp admin-update-user-attributes --user-pool-id us-east-1_TApa2HLk9 --username 3273a829-a589-4a66-91f3-f38cc31d321f --user-attributes Name=email,Value=email
```

```jsx
UPDATE public.tutor
SET email = 'maxwhull@yahoo.com'
WHERE id = '80595eb6-199e-465c-8c2e-f4fffe8e5356';
```

```jsx
SELECT * 
FROM tutor 
WHERE email='soccersoph47@gmail.com';
```

# Internal notes

```jsx
Hello!

Your account was reactivated.

Please, check your mailbox for email with new temporary password.

Thank you!
```

```jsx
account was reactivated via scripts
```

```jsx
account was reactivated via aws cognito console
```