#------------------------------------------------------------------------------
# APPAutoscaling target
#------------------------------------------------------------------------------
resource "aws_appautoscaling_target" "dev_to_target" {
  max_capacity       = var.as_max_capacity
  min_capacity       = var.as_min_capacity
  resource_id        = "service/${var.ecs_cluster}/${var.ecs_service}"
  scalable_dimension = var.scalable_dimension
  service_namespace  = var.service_namespace
}

#------------------------------------------------------------------------------
# APPAutoscaling policies
#------------------------------------------------------------------------------
resource "aws_appautoscaling_policy" "dev_to_memory" {
  name               = "dev-to-memory"
  policy_type        = var.policy_type
  resource_id        = aws_appautoscaling_target.dev_to_target.resource_id
  scalable_dimension = aws_appautoscaling_target.dev_to_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.dev_to_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type_memory
    }

    target_value = var.target_value_memory
  }
}

resource "aws_appautoscaling_policy" "dev_to_cpu" {
  name               = "dev-to-cpu"
  policy_type        = var.policy_type
  resource_id        = aws_appautoscaling_target.dev_to_target.resource_id
  scalable_dimension = aws_appautoscaling_target.dev_to_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.dev_to_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type_cpu
    }

    target_value = var.target_value_cpu
  }
}
