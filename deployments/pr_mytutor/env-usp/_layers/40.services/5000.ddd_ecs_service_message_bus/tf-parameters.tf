# Parameters
# Secrets
# Env variables

#--------------------------------------------------------------
# Service message bus Parameters
#--------------------------------------------------------------
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

# kafka
resource "aws_ssm_parameter" "kafka_lessons_topic_replicas" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/kafka_lessons_topic_replicas"
  type        = "String"
  value       = var.ecs_message_bus_kafka_lessons_topic_replicas
  description = "KAFKA_LESSONS_TOPIC_REPLICAS"
  tags        = module.label.tags
  #   lifecycle {
  #      ignore_changes = [
  #       value
  #      ]
  #   }
}

resource "aws_ssm_parameter" "kafka_lessons_topic_partitions" {
  name        = "/${var.label["Product"]}/${var.label["Environment"]}/service_${var.service_name}/kafka_lessons_topic_partitions"
  type        = "String"
  value       = var.ecs_message_bus_kafka_lessons_topic_partitions
  description = "KAFKA_LESSONS_TOPIC_PARTITIONS"
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
