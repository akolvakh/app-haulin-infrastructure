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

resource "aws_ssm_parameter" "tutor_lesson_hour_cost" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/tutor_lesson_hour_cost"
  type        = "String"
  value       = var.ecs_payment_tutor_lesson_hour_cost
  description = "TUTOR_LESSON_HOUR_COST"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "wm_url" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/wm_url"
  type        = "String"
  value       = var.ecs_payment_wm_url
  description = "WM_URL"
  tags        = module.label.tags
}

resource "aws_ssm_parameter" "wm_sign_up_url" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/wm_sign_up_url"
  type        = "String"
  value       = var.ecs_payment_wm_sign_up_url
  description = "WM_SIGN_UP_URL"
  tags        = module.label.tags
}

resource "aws_ssm_parameter" "wm_sign_in_url" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/wm_sign_in_url"
  type        = "String"
  value       = var.ecs_payment_wm_sign_in_url
  description = "WM_SIGN_IN_URL"
  tags        = module.label.tags
}

resource "aws_ssm_parameter" "wm_relay_id" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/wm_relay_id"
  type        = "String"
  value       = var.ecs_payment_wm_relay_id
  description = "WM_RELAY_ID"
  tags        = module.label.tags
}

resource "aws_ssm_parameter" "wm_relay_access_token" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/wm_relay_access_token"
  type        = "String"
  value       = var.ecs_payment_wm_relay_access_token
  description = "WM_RELAY_ACCESS_TOKEN"
  tags        = module.label.tags
}

resource "aws_ssm_parameter" "wm_add_update_action" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/wm_add_update_action"
  type        = "String"
  value       = var.ecs_payment_wm_add_update_action
  description = "WM_ADD_UPDATE_ACTION"
  tags        = module.label.tags
}

resource "aws_ssm_parameter" "wm_rule_meta_group" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/wm_rule_meta_group"
  type        = "String"
  value       = var.ecs_payment_wm_rule_meta_group
  description = "WM_RULE_META_GROUP"
  tags        = module.label.tags
}

resource "aws_ssm_parameter" "wm_delete_action" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/wm_delete_action"
  type        = "String"
  value       = var.ecs_payment_wm_delete_action
  description = "WM_DELETE_ACTION"
  tags        = module.label.tags
}

resource "aws_ssm_parameter" "user_service_url" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/user_service_url"
  type        = "String"
  value       = "http://user.${var.label["Environment"]}-ecs.${var.label["Product"]}.internal:8080"
  description = "USER_SERVICE_URL"
  tags        = module.label.tags
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
