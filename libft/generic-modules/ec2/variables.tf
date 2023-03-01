#------------------------------------------------------------------------------
# Instance variables
#------------------------------------------------------------------------------
variable "instance_name" {
  description = "(Required) Name of the instance."
  type        = string
}

variable "instance_type" {
  description = "(Required) Type of the instance."
  type        = string
  default     = "t2.micro"
}

#------------------------------------------------------------------------------
# Networking variables
#------------------------------------------------------------------------------
variable "subnet_id" {
  description = "(Required) IDs of the subnets."
}

variable "security_group_id" {
  description = "(Required) ID of the security group."
  type        = string
}

# needs a default of empty
variable "private_ip" {
  description = "(Required) Private IP."
  type        = string
}
