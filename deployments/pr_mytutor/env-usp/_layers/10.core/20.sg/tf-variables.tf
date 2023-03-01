#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#vpc
variable "outputs_vpc_vpc_cidr_block" {}
variable "outputs_vpc_vpc_nat_eips_cidr" {}
variable "outputs_vpc_vpc_id" {}

#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "tf_framework_component_version" {
  description = "current git tag or branch if tag unset. Set by framework"
}

#--------------------------------------------------------------
# Networking
#--------------------------------------------------------------
variable "appsync_ip_range" {
  description = "AppSync demands all backends be internet visible! We have to reshape our Arch. This variable is a temp workaround, given release schedule, sadly"
  // sadly TF does not let us substitute a variable inside a variable
  default = "0.0.0.0/0"
}
variable "vpc_cidr" {}