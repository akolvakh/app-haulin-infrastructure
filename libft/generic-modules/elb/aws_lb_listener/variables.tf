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
# LB target group
#------------------------------------------------------------------------------
variable "elb_arn" {
  description = "(Required, Forces New Resource) The ARN of the load balancer."
  type        = string
}

#------------------------------------------------------------------------------
# Default action
#------------------------------------------------------------------------------
variable "aws_lb_target_group_main_arn" {
  description = "(Optional) The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Etc
#------------------------------------------------------------------------------
variable "port" {
  description = "(Required) Lb listener port."
  type        = string
}

#ToDo Check: CKV_AWS_2: "Ensure ALB protocol is HTTPS"
variable "protocol" {
  description = "(Required) Lb protocol."
  type        = string
  //  default     = "HTTP"
  default = "HTTPS"
}
variable "da_type" {
  description = "(Required) Default action type."
  type        = string
}

#ToDo Check: CKV_AWS_103: "Ensure that load balancer is using TLS 1.2"
variable "ssl_policy" {
  description = "(Policy) The name of the SSL Policy for the listener. Required if protocol is HTTPS or TLS."
  type        = string
  //  default     = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
  default = ""
}
