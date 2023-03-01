#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}