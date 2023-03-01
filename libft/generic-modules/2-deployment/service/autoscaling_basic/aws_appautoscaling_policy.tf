#------------------------------------------------------------------------------
# APPAutoscaling policies
#------------------------------------------------------------------------------
resource "aws_appautoscaling_policy" "memory" {
  name               = "memory"
  policy_type        = var.policy_type
  resource_id        = aws_appautoscaling_target.target.resource_id
  scalable_dimension = aws_appautoscaling_target.target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type_memory
    }

    target_value = var.autoscaling_config.target_value_memory
  }
}

resource "aws_appautoscaling_policy" "cpu" {
  name               = "cpu"
  policy_type        = var.policy_type
  resource_id        = aws_appautoscaling_target.target.resource_id
  scalable_dimension = aws_appautoscaling_target.target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_metric_type_cpu
    }

    target_value = var.autoscaling_config.target_value_cpu
  }
}