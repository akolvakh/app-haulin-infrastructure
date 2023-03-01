#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_string" "suffix" {
  length  = 8
  special = false
}

#ToDo Check: CKV_AWS_65: "Ensure container insights are enabled on ECS cluster"
#------------------------------------------------------------------------------
# ECS
#------------------------------------------------------------------------------
resource "aws_ecs_cluster" "main" {
  name               = var.ecs_name
  capacity_providers = [var.ecs_capacity_providers]

  tags = {
    Name        = "${var.app}-${var.env}-ecs-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}-test"
  }

  default_capacity_provider_strategy {
    capacity_provider = var.dcps_capacity_provider
    weight            = var.dcps_weight
    base              = var.dcps_base
  }

  setting {
    name  = var.setting_name
    value = var.setting_value
  }
}
