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

variable "availability_zones" {
  description = "(Required) List of availability zones to be used by subnets."
  type        = list(any)
}

variable "is_public" {
  description = "(Required) Boolean variable that decides which resource is public."
  type        = bool
}

variable "vpc_block_part" {
  description = "(Required) The VPC block part for the subnet. Default is '10.0.0.0/16'."
  type        = string // list(string)
  default     = ""
}

#------------------------------------------------------------------------------
# Subnet variables
#------------------------------------------------------------------------------
variable "subnet_vpc_id" {
  description = "(Required) The ID of the VPC."
  type        = string
}

variable "subnet_cidr_block" {
  description = "(Required) The CIDR block for the subnet. Default is '10.0.0.0/16'."
  type        = string //list(string)
  default     = ""
}

variable "subnet_availability_zones" {
  description = "(Optional) The AZ for the subnet."
  type        = list(any)
  default     = ["use1-az1", "use1-az2", "use1-az3", "use1-az4", "use1-az5", "use1-az6"]
}

variable "subnet_availability_zones_id" {
  description = "(Optional) The AZ for the subnet."
  type        = list(any)
  default     = ["use1-az1", "use1-az2", "use1-az3", "use1-az4", "use1-az5", "use1-az6"]
}

variable "subnet_customer_owned_ipv4_pool" {
  description = "(Optional) The customer owned IPv4 address pool. Typically used with the map_customer_owned_ip_on_launch argument. The outpost_arn argument must be specified when configured."
  type        = string
  default     = "/"
}

variable "subnet_ipv6_cidr_block" {
  description = "(Optional) The IPv6 network range for the subnet, in CIDR notation. The subnet size must use a /64 prefix length."
  type        = string
  default     = "2001:db8:1234:1a00::/64"
}

variable "subnet_map_customer_owned_ip_on_launch" {
  description = "(Optional) Specify true to indicate that network interfaces created in the subnet should be assigned a customer owned IP address. The customer_owned_ipv4_pool and outpost_arn arguments must be specified when set to true. Default is false."
  type        = bool
  default     = false
}

variable "subnet_map_public_ip_on_launch" {
  description = "(Optional) Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false."
  type        = bool
  default     = false
}

variable "subnet_outpost_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the Outpost."
  type        = string
  default     = "/" //"arn:aws:iam::774178897063:user/name"
}

variable "subnet_assign_ipv6_address_on_creation" {
  description = "(Optional) Specify true to indicate that network interfaces created in the specified subnet should be assigned an IPv6 address. Default is false."
  type        = bool
  default     = false
}

variable "subnet_tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default = {
    Name        = "phoenix-subnet",
    Environment = "dev",
    App         = "phoenix"
  }
}
