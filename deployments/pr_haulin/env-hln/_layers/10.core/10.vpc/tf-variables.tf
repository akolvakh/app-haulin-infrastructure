#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}

#--------------------------------------------------------------
# VPC
#--------------------------------------------------------------
variable "vpc_cidr" {}

#--------------------------------------------------------------
# VPC peering
#--------------------------------------------------------------
variable "peer_account" {
  description = "we establish VPC peering VPN=>DEV env only. Account of the VPN vpcc"
  default     = "037564237295"
}
variable "peer_region" {
  description = "we establish VPC peering VPN=>DEV env only. Region of the VPN vpcc"
  default     = "us-east-2"
}
variable "peer_vpc_id" {
  description = "we establish VPC peering VPN=>DEV env only. VPC id of the vpn vpc"
  default     = "vpc-0b7be28cf8e307311"
}
variable "external_dns_domain" {
  type        = string
  description = "DNS domain to expose APP to external  (privileged networks in DEV/QA, WORLD for prod)"
}