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
  name                              = local.full_service_name
  cluster                           = var.cluster_name
  task_definition                   = var.td_arn
  launch_type                       = "FARGATE"
  platform_version                  = "1.4.0"
  desired_count                     = var.desired_count
  enable_execute_command            = true
  # depends_on                        = [var.task_execution_role, var.lb_listener_http_forward]
  /*
  we want be able redeploy/rollback even when docker image tag i.e. (micro)service version not changed
  at least to push gears through if any of them stuck. REVERTED to FALSE when moved the responsiblity to AWS CodeDeploy
  */
  force_new_deployment              = true
  wait_for_steady_state             = true
  health_check_grace_period_seconds = var.health_check_grace_seconds
  propagate_tags                    = "SERVICE"
  
  // @TBD tags
  //AWS offers now configurable deployment circuit breaker - but by deafult it is off
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  // FARGATE auto spreads across AZs ref https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-placement.html#:~:text=Task%20placement%20strategies%20and%20constraints%20are%20not%20supported%20for%20tasks,manually%20or%20within%20a%20service.
  network_configuration {
    subnets          = var.network_subnets_ids
    security_groups  = var.network_security_groups
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = var.service_name // to settle naming convention
    # container_port   = 8080             // to have one standard port for services. To change 8080=>443 as we are TLS
    container_port   = 7000             // to have one standard port for services. To change 8080=>443 as we are TLS
  }

  service_registries {
    registry_arn   = var.registry_arn
    container_name = var.service_name
  }
  
  lifecycle {
    // desired_count should be manged by autoscaling
    ignore_changes = [desired_count]
  }
  
  tags = merge(
    {
      "Name"        = local.full_service_name
      "Description" = var.tag_description
    },
    local.common_tags,
    var.service_additional_tags,
  )

}

