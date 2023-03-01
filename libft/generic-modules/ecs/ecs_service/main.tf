#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_string" "suffix" {
  length  = 8
  special = false
}

#------------------------------------------------------------------------------
# AWS ECS service Service
#------------------------------------------------------------------------------
resource "aws_ecs_service" "service" {
  name                              = var.name
  cluster                           = var.ecs_cluster_id
  task_definition                   = var.td_arn
  desired_count                     = var.desired_count
  launch_type                       = var.launch_type
  enable_execute_command            = true
  # platform_version                = "1.4.0"
  health_check_grace_period_seconds = var.health_check_grace_seconds
  propagate_tags                    = "SERVICE"
  force_new_deployment              = true
  depends_on                        = [var.task_execution_role, var.lb_listener_http_forward]

  network_configuration {
    security_groups  = [var.ecs_sg]
    subnets          = var.subnet_ids
    assign_public_ip = var.assign_public_ip
  }

  dynamic "load_balancer" {
    for_each = var.associate_alb || var.associate_nlb ? var.lb_target_groups : []
    content {
      container_name   = var.container_name
      target_group_arn = var.lb_target_group_arn
      container_port   = var.container_port
    }
  }

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
  
  service_registries {
    registry_arn   = var.registry_arn
    container_name = var.service_name
  }
  
  tags = {
    Environment = "${var.app}-${var.env}"
    Terraform   = true
  }
  
}
