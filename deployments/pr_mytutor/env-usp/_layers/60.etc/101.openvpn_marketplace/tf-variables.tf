#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "tf_framework_component_version" {}

variable "server_region" {
  description = "Region to deploy server"
  type        = string
  default     = "us-east-1"
}

variable "server_username" {
  description = "Admin Username to access server"
  type        = string
  default     = "openvpn"
}

variable "server_password" {
  description = "Admin Password to access server"
  type        = string
  default     = "password"
}

variable "vpc_id" {}
variable "public_subnet_ids" {}