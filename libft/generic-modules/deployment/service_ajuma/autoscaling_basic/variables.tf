variable "policy_type" {
  description = "(Required) Policy type."
  default     = "TargetTrackingScaling"
}
variable "service_namespace" {
  description = "(Required) Service namespace."
  default     = "ecs"
}

variable "scalable_dimension" {
  description = "(Required) Scalable dimension."
  default     = "ecs:service:DesiredCount"
}
variable "resource_id" {
  description = "App Autoscaling target"
  // Example "service/${data.terraform_remote_state.ecs.outputs.ecs_main_cluster_name}/${local.common_tags.Product}-${local.common_tags.Environment}-ecs-service-${var.service_name}"
}
variable "autoscaling_config" {
  description = "Map of app sutosclaing config key value items"
  // example local.autoscaling[local.common_tags.Environment]
}
variable "predefined_metric_type_memory" {
  description = "(Required) Predefined metric type for Memory."
  default     = "ECSServiceAverageMemoryUtilization"
}

variable "predefined_metric_type_cpu" {
  description = "(Required) Predefined metric type for CPU."
  default     = "ECSServiceAverageCPUUtilization"
}
