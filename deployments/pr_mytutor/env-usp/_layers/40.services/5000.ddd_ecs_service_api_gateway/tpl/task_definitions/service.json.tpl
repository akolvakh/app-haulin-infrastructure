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
    "image": "public.ecr.aws/xray/aws-xray-daemon",
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
        "name": "LOGGING_LEVEL_OR_SPRINGFRAMEWORK_SECURITY",
        "value": "${logging_level_or_springframework_security}"
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
        "name": "USER_POOL_ID",
        "value": "${cognito_user_pool}"
      },
      {
        "name": "PLATFORM_NAME",
        "value": "${platform_name}"
      }
    ],
    "secrets": [
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/allowed_origin_patterns",
        "name": "ALLOWED_ORIGIN_PATTERNS"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/csrf_enabled",
        "name": "CSRF_ENABLED"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/import_management_uri",
        "name": "IMPORT_MANAGEMENT_URI"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/tutor_application_uri",
        "name": "TUTOR_APPLICATION_URI"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/user_management_uri",
        "name": "USER_MANAGEMENT_URI"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/program_management_uri",
        "name": "PROGRAM_MANAGEMENT_URI"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/payment_management_uri",
        "name": "PAYMENT_MANAGEMENT_URI"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/lesson_management_uri",
        "name": "LESSON_MANAGEMENT_URI"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/tutor_interview_uri",
        "name": "TUTOR_INTERVIEW_URI"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/spring_profiles_active",
        "name": "SPRING_PROFILES_ACTIVE"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/server_secret",
        "name": "SERVER_SECRET"
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
