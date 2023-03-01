#------------------------------------------------------------------------------
# APPAutoscaling target
#------------------------------------------------------------------------------
resource "aws_appautoscaling_target" "target" {
  max_capacity       = var.autoscaling_config.autoscaling_max_task_count
  min_capacity       = var.autoscaling_config.autoscaling_min_task_count
  resource_id        = var.resource_id
  scalable_dimension = var.scalable_dimension
  service_namespace  = var.service_namespace
}