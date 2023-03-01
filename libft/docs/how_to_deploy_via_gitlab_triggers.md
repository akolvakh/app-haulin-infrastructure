# [USS][PROD] full deployment

```jsx
curl -X POST \
-F token=ed507dc30a816e5b743035876ea48e \
-F "ref=v2.6.0" \
-F "variables[RUN_ALL_TESTS]=false" \
-F "variables[USS_BUILD_SERVICE_IMPORT_PROD]=true" \
-F "variables[USS_BUILD_SERVICE_LESSON_MANAGEMENT_PROD]=true" \
-F "variables[USS_BUILD_SERVICE_MESSAGE_BUS_PROD]=true" \
-F "variables[USS_BUILD_SERVICE_PROGRAM_MANAGEMENT_PROD]=true" \
-F "variables[USS_BUILD_SERVICE_USER_PROD]=true" \
-F "variables[USS_BUILD_SERVICE_PAYMENT_PROD]=true" \
-F "variables[USS_BUILD_SERVICE_API_GATEWAY_PROD]=true" \
-F "variables[USS_SERVICE_IMPORT_PROD]=true" \
-F "variables[USS_SERVICE_LESSON_MANAGEMENT_PROD]=true" \
-F "variables[USS_SERVICE_MESSAGE_BUS_PROD]=true" \
-F "variables[USS_SERVICE_PROGRAM_MANAGEMENT_PROD]=true" \
-F "variables[USS_SERVICE_USER_PROD]=true" \
-F "variables[USS_SERVICE_PAYMENT_PROD]=true" \
-F "variables[USS_SERVICE_API_GATEWAY_PROD]=true" \
-F "variables[USS_SERVICE_TOA_PROD]=true" \
-F "variables[USS_SYS_DB_PROD]=true" \
     https://gitlab.geniusee.com/api/v4/projects/482/trigger/pipeline
```