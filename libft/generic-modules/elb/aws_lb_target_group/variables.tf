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

#------------------------------------------------------------------------------
# VPC variables
#------------------------------------------------------------------------------
variable "vpc_id" {
  description = "(Required) ID of the VPC."
  type        = string
}

#------------------------------------------------------------------------------
# LB target group
#------------------------------------------------------------------------------
variable "name" {
  description = "(Required) Lb target group name."
  type        = string
}

variable "port" {
  description = "(Required) Lb target group port."
  type        = string
}

variable "protocol" {
  description = "(Required) Lb target group protocol."
  type        = string
}

variable "target_type" {
  description = "(Required) Lb target group target type."
  type        = string
}

variable "target_deregistration_delay" {
  description = "(Required) Target deregistration delay."
  type        = string
}

variable "hc_healthcheck_path" {
  description = "(Required) Path of the healthcheck."
  type        = string
}

variable "hc_healthy_threshold" {
  description = "(Required) Health check healthy threshold."
  type        = string
}

variable "hc_interval" {
  description = "(Required) Health check interval."
  type        = string
}

variable "hc_protocol" {
  description = "(Required) Health check protocol."
  type        = string
}

variable "hc_matcher" {
  description = "(Required) Health check matcher."
  type        = string
}

variable "hc_timeout" {
  description = "(Required) Health check timeout."
  type        = string
}

variable "hc_unhealthy_threshold" {
  description = "(Required) Health check unhealthy threshold."
  type        = string
}
