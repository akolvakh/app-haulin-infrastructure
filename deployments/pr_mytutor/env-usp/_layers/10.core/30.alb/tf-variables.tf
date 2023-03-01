#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#vpc
variable "outputs_vpc_vpc_id" {}
#alb
variable "outputs_sg_sg_alb_public_app_id" {}
#acm
variable "outputs_acm_loadbalancer_arn" {}
#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}

#--------------------------------------------------------------
# Networking
#--------------------------------------------------------------
variable "vpc_cidr" {}

#--------------------------------------------------------------
# Certificates
#--------------------------------------------------------------
variable "certificate_arn" {
  type        = string
  description = "(Optional) ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS. For adding additional SSL certificates, see the aws_lb_listener_certificate resource"
  default     = null
}
#TODO
variable "public_certificate_arn" {
  type        = string
  description = "The ARN of AWS ACM certificate"
  default = "arn:aws:acm:us-east-1:776131206689:certificate/d73ab1c6-bf66-49e3-9df6-ceb2b20f2656"
}
variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}