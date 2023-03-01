# Parameters
# Secrets
# Env variables

#--------------------------------------------------------------
# Service API-Gateway Parameters
#--------------------------------------------------------------
# Server
# TODO - GENERAL VARIABLES FOR ALL SERVICES
resource "aws_ssm_parameter" "server_base_url" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/server_base_url"
  type        = "String"
  value       = var.server_base_url
  description = "SERVER_BASE_URL"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "server_domain" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/server_domain"
  type        = "String"
  value       = var.server_domain
  description = "SERVER_DOMAIN"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "server_secret" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/server_secret"
  type        = "String"
  value       = var.server_secret
  description = "SERVER_SECRET"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "region" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/region"
  type        = "String"
  value       = var.label["Region"]
  description = "REGION"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

# spring
resource "aws_ssm_parameter" "spring_datasource_url" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/spring_datasource_url"
  type        = "String"
  value       = var.spring_datasource_url
  description = "SPRING_DATASOURCE_URL"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "spring_datasource_driver_class_name" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/spring_datasource_driver_class_name"
  type        = "String"
  value       = var.spring_datasource_driver_class_name
  description = "SPRING_DATASOURCE_DRIVER_CLASS_NAME"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "spring_profiles_active" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/spring_profiles_active"
  type        = "String"
  value       = var.spring_profiles_active
  description = "SPRING_PROFILES_ACTIVE"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

# kafka
resource "aws_ssm_parameter" "kafka_producer_tx_prefix" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/kafka_producer_tx_prefix"
  type        = "String"
  value       = var.ecs_user_kafka_producer_tx_prefix
  description = "KAFKA_PRODUCER_TX_PREFIX"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

# etc
# resource "aws_ssm_parameter" "spring_profiles_active" {
#   name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/spring_profiles_active"
#   type        = "String"
#                 # var.environment
#   value       = "development"
#   description = "SPRING_PROFILES_ACTIVE"
#   tags        = module.label.tags
# #   lifecycle {
# #      ignore_changes = [
# #       value
# #      ]
# #   }
# }

resource "aws_ssm_parameter" "tutor_onboarding_application_uri" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/tutor_onboarding_application_uri"
  type        = "String"
  value       = "http://tutor-onboarding-application.${var.label["Environment"]}-ecs.${var.label["Product"]}.internal:8080"
  description = "APPLICATION_SERVICE_URL"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "service_user_platform_name" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/platform_name"
  type        = "String"
  value       = var.platform_name
  description = "PLATFORM_NAME"
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
