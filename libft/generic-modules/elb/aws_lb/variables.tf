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
# Subnet variables
#------------------------------------------------------------------------------
variable "subnet_ids" {
  description = "(Required) IDs of the subnet."
  type        = list(any)
}

#------------------------------------------------------------------------------
# ALB variables
#------------------------------------------------------------------------------
variable "elb_name" {
  description = "(Optional) The name of the LB. This name must be unique within your AWS account, can have a maximum of 32 characters, must contain only alphanumeric characters or hyphens, and must not begin or end with a hyphen. If not specified, Terraform will autogenerate a name beginning with tf-lb."
  type        = string
  default     = "/"
}

variable "elb_name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = ""
}

variable "elb_internal" {
  description = "(Optional) If true, the LB will be internal."
  type        = bool
  default     = false
}

variable "elb_load_balancer_type" {
  description = "(Optional) The type of load balancer to create. Possible values are application, gateway, or network. The default value is application."
  type        = string
  default     = "application"
}

#ToDo
variable "elb_security_groups" {
  description = "(Required) A list of security group IDs to assign to the LB. Only valid for Load Balancers of type application."
  //  type        = list(string)
  //  default     = []
}


variable "elb_drop_invalid_header_fields" {
  description = "(Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). The default is false. Elastic Load Balancing requires that message header names contain only alphanumeric characters and hyphens. Only valid for Load Balancers of type application."
  type        = bool
  default     = true
}

variable "elb_subnets" {
  description = "(Optional) A list of subnet IDs to attach to the LB. Subnets cannot be updated for Load Balancers of type network. Changing this value for load balancers of type network will force a recreation of the resource."
  type        = list(any)
  default     = []
}

variable "elb_idle_timeout" {
  description = "(Optional) The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application. Default: 60."
  type        = number
  default     = 60
}

variable "elb_enable_deletion_protection" {
  description = "(Optional) If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  type        = bool
  default     = false
}

variable "elb_enable_cross_zone_load_balancing" {
  description = "(Optional) If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false."
  type        = bool
  default     = false
}

variable "elb_enable_http2" {
  description = "(Optional) Indicates whether HTTP/2 is enabled in application load balancers. Defaults to true."
  type        = bool
  default     = true
}

variable "elb_customer_owned_ipv4_pool" {
  description = "(Optional) The ID of the customer owned ipv4 pool to use for this load balancer."
  type        = string
  default     = "/"
}

variable "elb_ip_address_type" {
  description = "(Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack."
  type        = string
  default     = "ipv4"
}

variable "elb_tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-elb"
  }
}

#------------------------------------------------------------------------------
# Access Logs variables
#------------------------------------------------------------------------------
variable "access_logs_bucket" {
  description = "(Required) The S3 bucket name to store the logs in."
  type        = string
}

variable "access_logs_prefix" {
  description = "(Optional) The S3 bucket prefix. Logs are stored in the root if not configured."
  type        = string
  default     = ""
}

#ToDo Check: CKV_AWS_91: "Ensure the ELBv2 (Application/Network) has access logging enabled"
variable "access_logs_enabled" {
  description = "(Optional) Boolean to enable / disable access_logs. Defaults to false, even when bucket is specified."
  type        = bool
  default     = true
}

#------------------------------------------------------------------------------
# Subnet Mapping variables
#------------------------------------------------------------------------------
variable "sm_subnet_id" {
  description = "(Required) The id of the subnet of which to attach to the load balancer. You can specify only one subnet per Availability Zone."
  type        = string
}

variable "sm_allocation_id" {
  description = "(Optional) The allocation ID of the Elastic IP address."
  type        = string
  default     = "/"
}

variable "sm_private_ipv4_address" {
  description = "(Optional) A private ipv4 address within the subnet to assign to the internal-facing load balancer."
  type        = string
  default     = "/"
}

variable "sm_ipv6_address" {
  description = "(Optional) An ipv6 address within the subnet to assign to the internet-facing load balancer."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# ETC variables
#------------------------------------------------------------------------------
variable "elb_ecr_sg_name" {
  description = "(Required) Elb ECR security group name."
  type        = string
}

variable "elb_sg_name" {
  description = "(Required) Elb security group name."
  type        = string
}
