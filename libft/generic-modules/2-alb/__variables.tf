variable "alb_vpc_id" {
  type        = string
  description = "VPC where the ALB being created to live in"
}
variable "alb_subnets" {
  type        = list(string)
  description = "subnets where the ALB being created to live in"
}
variable "alb_security_groups" {
  type        = list(string)
  description = "what security groups to assign to the ALB, list of ID"
}

variable "alb_type" {
  type        = string
  description = "allowed values = application|network"
  default     = "application"
}

variable "alb_internal_enable" {
  type        = bool
  description = "shall ALB be accessible from VPC only/have private IP only?"
}

variable "http_port" {
  type        = string
  description = "What port listen on HTTP protocol if any."
  default     = 80
}
variable "https_port" {
  type        = string
  description = "What port listen on HTTPS protocol if any."
  default     = 443
}
variable "ssl_policy" {
  type        = string
  description = "https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies"
  default     = "ELBSecurityPolicy-FS-1-2-Res-2020-10"
#  default     = "ELBSecurityPolicy-2016-08"
}
variable "certificate_arn" {
  type        = string
  description = "(Optional) ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS. For adding additional SSL certificates, see the aws_lb_listener_certificate resource"
  default     = null
}
variable "prefix_api" {
  type        = string
  description = "URI prefix for api(s)"
  default     = "/service"
}
variable "prefix_web" {
  type        = string
  description = "URI prefix for web applications."
  default     = ""
}
variable "backends_api" {
  type        = list(string)
  description = "names of backends to be exposed via ALB. prefix_api will be prepended to matching rules. Can be '/'. Listner rules and target groups will be auto created. Sample: backend_name = /auth, prefix_api=api, requests for <DNS>/api/auth to be routed to tgt grp 'arn:...auth'"
  default     = []
}
variable "backends_web" {
  type        = list(string)
  description = "names of backends to be exposed via ALB. prefix_web will be prepended to matching rules. Can be '/'. Listner rules and target groups will be auto created. Sample: backend_name = /experimnent, prefix_web=/web, requests for <DNS>/web/experiment to be routed to tgt grp 'arn:...:experiment'"
  default     = []
}

variable "alb_access_log_enable" {
  type        = bool
  description = "enable access logging into S3 bucket?"
  default     = false
}
variable "alb_access_log_bucket" {
  type        = string
  description = "s3 bucket name to store  access logs in"
  default     = ""
}
variable "alb_access_log_prefix" {
  type        = string
  description = "prefix where to store access lgos in the S3 bucket"
  default     = ""
}

variable "alb_http2_enable" {
  type        = bool
  default     = false // We want http2, but how well Android/IOS supports it?
  description = "enable HTTP/2 support in load balancer"

}

#--------------------------------------------------------------
# ALB Tag Variables
#--------------------------------------------------------------


variable "tag_role" {
  description = "Sample: admin-lb"
  type        = string
}


variable "tag_description" {
  description = "Few meaningful words, to describe what this resource does"
  type        = string
}

variable "alb_additional_tags" {
  description = "A map of additional tags, just tag/value pairs, to add to the VPC."
  type        = map(string)
  default     = {}
}
