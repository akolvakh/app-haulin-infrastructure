#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "app" {
  description = "(Required) App name."
  type        = string
}

variable "env" {
  description = "(Required) Environment."
  type        = string
}

variable "region" {
  description = "(Required) Region."
  type        = string
}

variable "healthcheck_path" {
  description = "(Required) Path of the healthcheck."
  type        = string
}

#------------------------------------------------------------------------------
# ECS service variables
#------------------------------------------------------------------------------
variable "ecs_cluster_id" {
  description = "(Required) ID of the ECS cluster."
  type        = string
}

variable "ecs_sg" {
  description = "(Required) Security group of the ECS."
  type        = string
}

variable "td_arn" {
  description = "(Optional) The family and revision (family:revision) or full ARN of the task definition that you want to run in your service. Required unless using the EXTERNAL deployment controller. If a revision is not specified, the latest ACTIVE revision is used."
  type        = string
  default     = "/"
}

variable "associate_alb" {
  description = "Whether to associate an Application Load Balancer (ALB) with the ECS service."
  default     = true
  type        = bool
}

variable "associate_nlb" {
  description = "Whether to associate a Network Load Balancer (NLB) with the ECS service."
  default     = false
  type        = bool
}

variable "lb_target_groups" {
  description = "List of load balancer target group objects containing the lb_target_group_arn, container_port and container_health_check_port. The container_port is the port on which the container will receive traffic. The container_health_check_port is an additional port on which the container can receive a health check. The lb_target_group_arn is either Application Load Balancer (ALB) or Network Load Balancer (NLB) target group ARN tasks will register with."
  default     = []
  type = list(
    object({
      container_port              = number
      container_health_check_port = number
      lb_target_group_arn         = string
      }
    )
  )
}

#------------------------------------------------------------------------------
# Subnet variables
#------------------------------------------------------------------------------
variable "subnet_ids" {
  description = "(Required) IDs of the subnets."
  type        = list(any)
}

#------------------------------------------------------------------------------
# Load balancer variables
#------------------------------------------------------------------------------
variable "lb_target_group_arn" {
  description = "(Required for ALB/NLB) The ARN of the Load Balancer target group to associate with the service."
  type        = string
}

#------------------------------------------------------------------------------
# Additional variables
#------------------------------------------------------------------------------
variable "lb_listener_http_forward" {
  description = "(Required) AWS load balancer listener."
  //  type        = string
}

#ToDo
variable "task_execution_role" {
  description = "(Required) AWS IAM role policy attachment for ecs task execution role (aws_iam_role_policy_attachment_ecs_task_execution_role)."
  //  type        = string
}

variable "name" {
  description = "(Required) Name."
  type        = string
}

variable "desired_count" {
  description = "(Required) Desired count."
  type        = string
}

variable "launch_type" {
  description = "(Required) Launch type."
  type        = string
}

variable "assign_public_ip" {
  description = "(Required) Assign public ip."
  type        = string
}

variable "container_name" {
  description = "(Required) Container's name."
  type        = string
}

variable "container_port" {
  description = "(Required) Container's port."
  type        = string
}

variable "health_check_grace_seconds" {}
variable "registry_arn" {}
variable "service_name" {}