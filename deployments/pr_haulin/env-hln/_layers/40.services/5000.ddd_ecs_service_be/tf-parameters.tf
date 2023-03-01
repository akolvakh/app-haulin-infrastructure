# Parameters
# Secrets
# Env variables

#--------------------------------------------------------------
# Service API-Gateway Parameters
#--------------------------------------------------------------
# Server
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

# spring
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


# uri
#resource "aws_ssm_parameter" "lesson_management_service_url" {
#  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/lesson_management_service_url"
#  type        = "String"
#  value       = "http://lesson-management.${var.label["Environment"]}-ecs.${var.label["Product"]}.internal:8080"
#  description = "LESSON_MANAGEMENT_SERVICE_URL"
#  tags        = module.label.tags
#  #   lifecycle {
#  #      ignore_changes = [
#  #       value
#  #      ]
#  #   }
#}

# etc
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

resource "aws_ssm_parameter" "phoenix_master_db_schema" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/phoenix_master_db_schema"
  type        = "String"
  value       = var.phoenix_master_db_schema
  description = "DB_SCHEMA"
  tags        = module.label.tags
#   lifecycle {
#      ignore_changes = [
#       value
#      ]
#   }
}
