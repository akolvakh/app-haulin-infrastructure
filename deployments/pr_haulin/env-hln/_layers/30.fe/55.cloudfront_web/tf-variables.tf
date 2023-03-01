#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#vpc
variable "outputs_vpc_vpc_nat_eips_cidr" {}
#vpc
variable "outputs_acm_cloudfront_arn" {}
#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "tf_framework_component_version" {}
variable "tag_role" {
  default = "admin-fe"
}
variable "alias" {}