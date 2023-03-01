#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#sg
variable "outputs_sg_sg_rds_lambda_id" {}
#vpc
variable "outputs_vpc_private_subnets" {}
#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "lambda_name" {
    default = "clever"
}
variable "clever_url" {}
variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}