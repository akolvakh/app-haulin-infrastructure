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
        "name": "REGION",
        "value": "${aws_region}"
      },
      {
        "name": "KAFKA_BROKER_LIST",
        "value": "${kafka_broker_list}"
      },
      {
        "name": "KAFKA_LESSONS_TOPIC_PARTITIONS",
        "value": "${kafka_lessons_topic_partitions}"
      },
      {
        "name": "KAFKA_LESSONS_TOPIC_REPLICAS",
        "value": "${kafka_lessons_topic_replicas}"
      },
      {
        "name": "LESSON_INTEGRATION_MOCK",
        "value": "${lesson_integration_mock}"
      },
      {
        "name": "LESSON_INTEGRATION_SERVICE",
        "value": "${lesson_integration_service}"
      },
      {
        "name": "LESSONSPACE_API_KEY",
        "value": "${lesson_space_api}"
      },
      {
        "name": "PLATFORM_NAME",
        "value": "${platform_name}"
      }
    ],
    "secrets": [
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/booknook:BOOKNOOK_API_URL::",
        "name": "BOOKNOOK_API_URL"
      },
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/booknook:BOOKNOOK_API-KEY-HEADER-NAME::",
        "name": "BOOKNOOK_API-KEY-HEADER-NAME"
      },
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/booknook:BOOKNOOK_API-KEY::",
        "name": "BOOKNOOK_API-KEY"
      },
      {
        "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/booknook:BOOKNOOK_API_VERSION::",
        "name": "BOOKNOOK_API_VERSION"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/phoenix_master_db_schema",
        "name": "PHOENIX_MASTER_DB_SCHEMA"
      },
      {
        "valueFrom": "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_${service_name}/spring_profiles_active",
        "name": "SPRING_PROFILES_ACTIVE"
      }
    ],
    "image": "${docker_registry_url}:${version}",
    "name": "${service_2_deploy}",
    "essential": true
  }
]
