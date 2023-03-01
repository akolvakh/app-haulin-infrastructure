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

resource "aws_ssm_parameter" "csrf_enabled" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/csrf_enabled"
  type        = "String"
  value       = var.csrf_enabled
  description = "CSRF_ENABLED"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "allowed_origin_patterns" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/allowed_origin_patterns"
  type        = "String"
  value       = var.allowed_origin_patterns
  description = "ALLOWED_ORIGIN_PATTERNS"
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

# uri
resource "aws_ssm_parameter" "program_management_uri" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/program_management_uri"
  type        = "String"
  value       = "http://program-management.${var.label["Environment"]}-ecs.${var.label["Product"]}.internal:8080"
  description = "PROGRAM_MANAGEMENT_URI"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "payment_management_uri" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/payment_management_uri"
  type        = "String"
  value       = "http://payment.${var.label["Environment"]}-ecs.${var.label["Product"]}.internal:8080"
  description = "PAYMENT_MANAGEMENT_URI"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "import_management_uri" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/import_management_uri"
  type        = "String"
  value       = "http://import.${var.label["Environment"]}-ecs.${var.label["Product"]}.internal:8080"
  description = "IMPORT_MANAGEMENT_URI"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "user_management_uri" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/user_management_uri"
  type        = "String"
  value       = "http://user.${var.label["Environment"]}-ecs.${var.label["Product"]}.internal:8080"
  description = "USER_MANAGEMENT_URI"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "lesson_management_uri" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/lesson_management_uri"
  type        = "String"
  value       = "http://lesson-management.${var.label["Environment"]}-ecs.${var.label["Product"]}.internal:8080"
  description = "LESSON_MANAGEMENT_URI"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "tutor_application_uri" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/tutor_application_uri"
  type        = "String"
  value       = "http://tutor-onboarding-application.${var.label["Environment"]}-ecs.${var.label["Product"]}.internal:8080"
  description = "TUTOR_APPLICATION_URI"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "tutor_interview_uri" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/tutor_interview_uri"
  type        = "String"
  value       = "http://interview.${var.label["Environment"]}-ecs.${var.label["Product"]}.internal:8080"
  description = "TUTOR_INTERVIEW_URI"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

# etc
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
