#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
data "aws_availability_zones" "available" {}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

#------------------------------------------------------------------------------
# AWS ECS Task Definition
#------------------------------------------------------------------------------
resource "aws_ecs_task_definition" "main" {
  family                   = var.td_family
  network_mode             = var.td_network_mode
  execution_role_arn       = var.td_execution_role_arn
  requires_compatibilities = [var.td_requires_compatibilities]
  cpu                      = var.td_cpu
  memory                   = var.td_memory
  container_definitions    = var.td_container_definitions
  task_role_arn            = var.td_task_role_arn

  tags = {
    Name        = "${var.app}-${var.env}-task-definition-${random_string.suffix.result}"
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }

  //  lifecycle {
  //    ignore_changes = [ container_definitions ]
  //  }
}
