#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#vpc
variable "outputs_vpc_r53_private_zone_id" {}
#alb
variable "outputs_alb_alb_public_dns_name" {}
variable "outputs_alb_alb_apl_private_hosted_zone_id" {}
#cloudfront
variable "outputs_cloudfront_domain_name" {}
variable "outputs_cloudfront_hosted_zone" {}
#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "tf_framework_component_version" {}
variable "external_dns_domain" {}