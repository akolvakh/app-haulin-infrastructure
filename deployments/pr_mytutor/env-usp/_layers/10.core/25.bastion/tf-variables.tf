#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#vpc
variable "outputs_sg_sg_bastion_id" {}
variable "outputs_vpc_public_subnets" {}
#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}
variable "ami" {
  default = "ami-0fcda042dd8ae41c7"
}