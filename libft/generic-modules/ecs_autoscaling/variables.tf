#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "env" {
  description = "(Required) Environment."
  type        = string
}

variable "name" {
  description = "(Required) Name."
  type        = string
}

variable "app" {
  description = "(Required) App name."
  type        = string
}

variable "region" {
  description = "(Required) Region."
  type        = string
}

#------------------------------------------------------------------------------
# ECS variables
#------------------------------------------------------------------------------
variable "ecs_cluster" {
  description = "(Required) ECS cluster name."
  type        = string
}

variable "ecs_service" {
  description = "(Required) ECS service name."
  type        = string
}

#------------------------------------------------------------------------------
# Autoscaling variables
#------------------------------------------------------------------------------
variable "as_min_capacity" {
  description = "(Required) Autoscaling minimum capacity."
  type        = string
}

variable "as_max_capacity" {
  description = "(Required) Autoscaling maximum capacity."
  type        = string
}

variable "as_desired_capacity" {
  description = "(Required) Autoscaling desired capacity."
  type        = string
}

variable "as_instance_type" {
  description = "(Required) Autoscaling instance type."
  type        = string
}

variable "as_health_check_type" {
  description = "(Required) Autoscaling health check type."
  type        = string
}

variable "target_value_memory" {
  description = "(Required) Autoscaling target memory value."
  type        = number
}

variable "target_value_cpu" {
  description = "(Required) Autoscaling target cpu value."
  type        = number
}

variable "service_namespace" {
  description = "(Required) Service namespace."
  default     = "ecs"
}

variable "scalable_dimension" {
  description = "(Required) Scalable dimension."
  default     = "ecs:service:DesiredCount"
}

variable "predefined_metric_type_memory" {
  description = "(Required) Predefined metric type for Memory."
  default     = "ECSServiceAverageMemoryUtilization"
}

variable "predefined_metric_type_cpu" {
  description = "(Required) Predefined metric type for CPU."
  default     = "ECSServiceAverageCPUUtilization"
}

variable "policy_type" {
  description = "(Required) Policy type."
  default     = "TargetTrackingScaling"
}
