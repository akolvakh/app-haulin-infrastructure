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

variable "is_public" {
  description = "(Required) Boolean variable that decides which resource is public."
  type        = bool
}

variable "length" {
  description = "(Required) Count of rtas."
  type        = string
}

#------------------------------------------------------------------------------
# Route table association variables
#------------------------------------------------------------------------------
variable "rta_route_table_id" {
  description = "(Required) The ID of the routing table to associate with."
  type        = string
}

variable "rta_subnet_id" {
  description = "(Optional) The subnet ID to create an association. Conflicts with gateway_id."
  type        = list(string)
  default     = ["/"]
}

variable "rta_gateway_id" {
  description = "(Optional) The gateway ID to create an association. Conflicts with subnet_id."
  type        = string
  default     = "/"
}
