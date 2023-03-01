# Parameters
# Secrets
# Env variables
#--------------------------------------------------------------
# Service Interview Parameters
#--------------------------------------------------------------
resource "aws_ssm_parameter" "sparkhire_webhook_uuid" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/sparkhire_webhook_uuid"
  type        = "String"
  value       = var.ecs_interview_sparkhire_webhook_uuid
  description = "SPARKHIRE_WEBHOOK_UUID"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "sparkhire_basic_auth_password" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/sparkhire_basic_auth_password"
  type        = "String"
  value       = var.ecs_interview_sparkhire_basic_auth_password
  description = "SPARKHIRE_BASIC_AUTH_PASSWORD"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "sparkhire_basic_auth_username" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/sparkhire_basic_auth_username"
  type        = "String"
  value       = var.ecs_interview_sparkhire_basic_auth_username
  description = "SPARKHIRE_BASIC_AUTH_USERNAME"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "sparkhire_timezone" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/sparkhire_timezone"
  type        = "String"
  value       = var.ecs_interview_sparkhire_timezone
  description = "SPARK_HIRE_TIMEZONE"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "sparkhire_interview_expiration_days" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/sparkhire_interview_expiration_days"
  type        = "String"
  value       = var.ecs_interview_sparkhire_interview_expiration_days
  description = "SPARK_HIRE_INTERVIEW_EXPIRATION_DAYS"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "sparkhire_question_set_uuid" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/sparkhire_question_set_uuid"
  type        = "String"
  value       = var.ecs_interview_sparkhire_question_set_uuid
  description = "SPARK_HIRE_QUESTION_SET_UUID"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "sparkhire_basic_api_token" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/sparkhire_basic_api_token"
  type        = "String"
  value       = var.ecs_interview_sparkhire_basic_api_token
  description = "SPARK_HIRE_BASIC_API_TOKEN"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "sparkhire_basic_api_url" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/sparkhire_basic_api_url"
  type        = "String"
  value       = var.ecs_interview_sparkhire_basic_api_url
  description = "SPARK_HIRE_API_URL"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "sparkhire_basic_www_url" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/sparkhire_basic_www_url"
  type        = "String"
  value       = var.ecs_interview_sparkhire_basic_www_url
  description = "SPARK_HIRE_WWW_URL"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "sparkhire_job_uuid" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/sparkhire_job_uuid"
  type        = "String"
  value       = var.ecs_interview_sparkhire_job_uuid
  description = "SPARK_HIRE_JOB_UUID"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "kafka_interview_update_topic_replicas" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/kafka_interview_update_topic_replicas"
  type        = "String"
  value       = var.ecs_interview_kafka_interview_update_topic_replicas
  description = "KAFKA_INTERVIEW_UPDATE_TOPIC_REPLICAS"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "kafka_interview_update_topic_partitions" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/kafka_interview_update_topic_partitions"
  type        = "String"
  value       = var.ecs_interview_kafka_interview_update_topic_partitions
  description = "KAFKA_INTERVIEW_UPDATE_TOPIC_PARTITIONS"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "kafka_interview_update_topic_name" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/kafka_interview_update_topic_name"
  type        = "String"
  value       = var.ecs_interview_kafka_interview_update_topic_name
  description = "KAFKA_INTERVIEW_UPDATE_TOPIC_NAME"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "db_schema" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/db_schema"
  type        = "String"
  value       = var.ecs_interview_db_schema
  description = "DB_SCHEMA"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "phoenix_master_db_schema" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/phoenix_master_db_schema"
  type        = "String"
  value       = var.phoenix_master_db_schema
  description = "PHOENIX_MASTER_DB_SCHEMA"
  tags        = module.label.tags
#   lifecycle {
#      ignore_changes = [
#       value
#      ]
#   }
}
