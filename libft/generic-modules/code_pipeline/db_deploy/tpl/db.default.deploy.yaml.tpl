version: 0.2

phases:
  install:
    commands:
      - env
      - yum update -y
      - yum install -y netcat
  build:
    commands:
      - |
        docker run --net=host --rm -v `pwd`/database/changelog:/liquibase/changelog liquibase/liquibase \
        --url="jdbc:postgresql://$DB_ENTRYPOINT:5432/phoenix_app_${ENV_TYPE}_default?currentSchema=public" \
        --username=root --password="$DB_PWD" \
        --driver=org.postgresql.Driver \
        --changeLogFile=db.changelog-master.yaml \
        --contexts=${ENV_TYPE} \
        update