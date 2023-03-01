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
        "name": "REGION",
        "value": "${aws_region}"
      },
      {
        "name": "SPRING_DATASOURCE_DRIVER_CLASS_NAME",
        "value": "org.postgresql.Driver"
      },
      {
        "name": "SPRING_DATASOURCE_URL",
        "value": "jdbc:postgresql://${db_main_entrypoint}:5432/${product}_app_${environment}_default?ssl=true&sslmode=require"
      },
      {
        "name": "USER_POOL_ID",
        "value": "${cognito_user_pool}"
      },
      {
        "name": "SPRING_PROFILES_ACTIVE",
        "value": "${spring_profiles_active}"
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
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/shared/ecs/app_certificate_self_signed/p12/cert_b64",
        "name": "SSL_KEYSTORE_B64"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/shared/ecs/app_certificate_self_signed/p12/ssl_key_password",
        "name": "SSL_KEY_PASSWORD"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/shared/ecs/app_certificate_self_signed/p12/springboot_keystore_password",
        "name": "SPRING_BOOT_KEYSTORE_PASSWORD"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/shared/ecs/zytara_local/ca_b64",
        "name": "SSL_CA_BASE64"
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
