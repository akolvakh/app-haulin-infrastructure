#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------
variable "app" {
  description = "(Required) App name."
  type        = string
}

variable "env" {
  description = "(Required) Environment."
  type        = string
}

#------------------------------------------------------------------------------
# NAT Gateway variables
#------------------------------------------------------------------------------

variable "subnet_id" {
  description = "(Required) The Subnet ID of the subnet in which to place the gateway."
  type        = string
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default = {
    Name        = "phoenix-nat-gateway",
    Environment = "dev",
    App         = "phoenix"
  }
}

variable "route_table_id" {
  description = "(Required) The ID of the private route table."
  type        = string
}