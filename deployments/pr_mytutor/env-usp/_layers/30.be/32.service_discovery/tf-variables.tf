#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#vpc
variable "outputs_vpc_vpc_id" {}
#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}
variable "parameter_additional_tags" {
  type        = map(any)
  description = "add here any additional tags you want assign to parameters created"
  default     = {}
}
variable "label" {}
