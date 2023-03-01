1. pg admin db backup - txt, tar, directory, custom
2. drop cascade db (schema and etc)
3. create new scheam (public)
4. run script on public schema ( 

```jsx
CREATE
EXTENSION IF NOT EXISTS "uuid-ossp";
```

1. restore db
2. run migration script
3. run services
4. check db
5. etc.