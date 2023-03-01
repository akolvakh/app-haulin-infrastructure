#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "app" {
  description = "(Required) App name."
  type        = string
  default     = "phoenix"
}

variable "env" {
  description = "(Required) Environment."
  type        = string
  default     = "dev"
}

#------------------------------------------------------------------------------
# VPC variables
#------------------------------------------------------------------------------
variable "vpc_cidr_block" {
  description = "(Required) The CIDR block for the VPC. Default is '10.0.0.0/16'."
  type        = string
}

variable "vpc_block_part" {
  description = "(Required) The block part for the VPC."
  type        = string
}

variable "vpc_instance_tenancy" {
  description = "(Optional) A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr."
  type        = string
  default     = "default"
}

variable "vpc_enable_dns_support" {
  description = "(Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults true."
  type        = bool
  default     = true
}

variable "vpc_enable_dns_hostnames" {
  description = "(Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
  type        = bool
  default     = true
}

variable "vpc_enable_classiclink" {
  description = "(Optional) A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic. See the ClassicLink documentation for more information. Defaults false."
  type        = bool
  default     = false
}

variable "vpc_enable_classiclink_dns_support" {
  description = "(Optional) A boolean flag to enable/disable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
  type        = bool
  default     = false
}

variable "vpc_assign_generated_ipv6_cidr_block" {
  description = "(Optional) Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block. Default is false."
  type        = bool
  default     = false
}

variable "vpc_tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default = {
    Name        = "phoenix-vpc",
    Environment = "dev",
    App         = "phoenix"
  }
}

#------------------------------------------------------------------------------
# Route variables
#------------------------------------------------------------------------------
variable "route_route_table_id" {
  description = "(Required) The ID of the routing table."
  type        = string
  default     = ""
}

variable "route_destination_cidr_block" {
  description = "(Optional) The destination CIDR block."
  type        = string
  //  default     = "0.0.0.0/0"
}

variable "route_destination_ipv6_cidr_block" {
  description = "(Optional) The destination IPv6 CIDR block."
  type        = string
  default     = "/"
}

variable "route_egress_only_gateway_id" {
  description = "(Optional) Identifier of a VPC Egress Only Internet Gateway."
  type        = string
  default     = "/"
}

variable "route_gateway_id" {
  description = "(Optional) Identifier of a VPC internet gateway or a virtual private gateway."
  type        = string
  default     = "/"
}

variable "route_instance_id" {
  description = "(Optional) Identifier of an EC2 instance."
  type        = string
  default     = "/"
}

variable "route_nat_gateway_id" {
  description = "(Optional) Identifier of a VPC NAT gateway."
  type        = string
  default     = "/"
}

variable "route_local_gateway_id" {
  description = "(Optional) Identifier of a Outpost local gateway."
  type        = string
  default     = "/"
}

variable "route_network_interface_id" {
  description = "(Optional) Identifier of an EC2 network interface."
  type        = string
  default     = "/"
}

variable "route_transit_gateway_id" {
  description = "(Optional) Identifier of an EC2 Transit Gateway."
  type        = string
  default     = "/"
}

variable "route_vpc_endpoint_id" {
  description = "(Optional) Identifier of a VPC Endpoint."
  type        = string
  default     = "/"
}

variable "route_vpc_peering_connection_id" {
  description = "(Optional) Identifier of a VPC peering connection."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Internet gateway variables
#------------------------------------------------------------------------------
variable "ig_vpc_id" {
  description = "(Required) The VPC ID to create in."
  type        = string
  default     = ""
}

variable "ig_tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default = {
    Name        = "phoenix-ig",
    Environment = "dev",
    App         = "phoenix"
  }
}
