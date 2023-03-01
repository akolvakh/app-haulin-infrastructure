[
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
        "name": "REDIS_HOSTNAME",
        "value": "${cache_entrypoint}"
      },
      {
        "name": "REDIS_PORT",
        "value": "6379"
      },
      {
        "name": "REDIS_CACHE_EXPIRATION_TIME",
        "value": "600"
      },
      {
        "name": "SPRING_DATASOURCE_URL",
        "value": "jdbc:postgresql://${db_main_entrypoint}:5432/${product}_app_${environment}_default?ssl=true&sslmode=require"
      },
      {
        "name": "USER_POOL_ID",
        "value": "${cognito_user_pool}"
      }
    ],
    "secrets": [
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}-app/${environment}/db/service_be/credentials:API_ID::",
        "name": "SPRING_DATASOURCE_USERNAME"
      },
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}-app/${environment}/db/service_be/credentials:API_SECRET::",
        "name": "SPRING_DATASOURCE_PASSWORD"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_message_bus/spring_profiles_active",
        "name": "SPRING_PROFILES_ACTIVE"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_message_bus/spring_datasource_driver_class_name",
        "name": "SPRING_DATASOURCE_DRIVER_CLASS_NAME"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_message_bus/region",
        "name": "REGION"
      }
    ],
    "image": "${docker_registry_url}:${version}",
    "name": "${service_2_deploy}",
    "essential": true
  },
  {
    "logConfiguration": {
      "logDriver": "awslogs",
      "secretOptions": null,
      "options": {
        "awslogs-create-group": "true",
        "awslogs-group": "${product}/ecs/${product}/${name}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "${product}-ecs-${product}-${name}-xray"
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
  }
]
