[
  {
    "logConfiguration": {
      "logDriver": "awslogs",
      "secretOptions": null,
      "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "phoenix/ecs/${product}/${name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "phoenix-ecs-${product}-${name}-xray"
      }
    },
    "cpu": 32,
    "memoryReservation": 256,
    "portMappings": [
      {
        "protocol": "udp",
        "containerPort": 2000
      }
    ],
    "image": "amazon/aws-xray-daemon",
    "name": "aws-xray-${environment}"
  },
  {
    "dnsSearchDomains": null,
    "environmentFiles": null,
    "logConfiguration": {
      "logDriver": "awslogs",
      "secretOptions": null,
      "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "${product}/ecs/${product}/${name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "aws-ecs-${product}-${name}"
      }
    },
    "entryPoint": null,
    "portMappings": [
      {
        "protocol": "tcp",
        "containerPort": 8080
      }
    ],
    "command": null,
    "linuxParameters": null,
    "environment": [
      {
        "name": "MANUAL",
        "value": "${manual}"
      },
      {
        "name": "REDIS_HOSTNAME",
        "value": "${cache_entrypoint}"
      },
      {
        "name": "REDIS_PORT",
        "value": "${redis_port}"
      },
      {
        "name": "REDIS_CACHE_EXPIRATION_TIME",
        "value": "${redis_cache_expiration_time}"
      },
      {
        "name": "KAFKA_BROKER_LIST",
        "value": "${kafka_broker_list}"
      },
      {
        "name": "SPRING_DATASOURCE_URL",
        "value": "${spring_datasource_url}"
      },
      {
        "name": "USER_POOL_ID",
        "value": "${cognito_user_pool}"
      },
      {
        "name": "AWS_BUCKET_ID",
        "value": "${aws_bucket_id}"
      },
      {
        "name": "S3-TEACHERS-BUCKET-NAME",
        "value": "${s3_teachers_bucket_name}"
      },
      {
        "name": "PLATFORM_NAME",
        "value": "${platform_name}"
      }
    ],
    "secrets": [
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/db/credentials:host::",
        "name": "PHOENIX_MASTER_HOST"
      },
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/db/credentials:password::",
        "name": "PHOENIX_MASTER_PASSWORD"
      },
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/db/credentials:username::",
        "name": "PHOENIX_MASTER_USERNAME"
      },
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/db/credentials:port::",
        "name": "PHOENIX_MASTER_PORT"
      },
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/db/credentials:db::",
        "name": "PHOENIX_MASTER_DB_NAME"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/server_secret",
        "name": "SERVER_SECRET"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/spring_profiles_active",
        "name": "SPRING_PROFILES_ACTIVE"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/user_service_url",
        "name": "USER_SERVICE_URL"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/kafka_producer_tx_prefix",
        "name": "KAFKA_PRODUCER_TX_PREFIX"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/spring_datasource_driver_class_name",
        "name": "SPRING_DATASOURCE_DRIVER_CLASS_NAME"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/server_domain",
        "name": "SERVER_DOMAIN"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/region",
        "name": "REGION"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/phoenix_master_db_schema",
        "name": "PHOENIX_MASTER_DB_SCHEMA"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/server_base_url",
        "name": "SERVER_BASE_URL"
      }
    ],
    "image": "${docker_registry_url}:${version}",
    "name": "${service_2_deploy}",
    "essential": true
  }
]
