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

variable "is_egress" {
  description = "(Required) Boolean variable that decides switch egress on or off."
  type        = bool
}

variable "is_ingress" {
  description = "(Required) Boolean variable that decides switch ingress on or off."
  type        = bool
}

variable "availability_zones" {
  description = "(Required) List of availability zones to be used by subnets."
  type        = list(any)
}

#------------------------------------------------------------------------------
# Security group variables
#------------------------------------------------------------------------------
variable "security_group_tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default = {
    Name        = "phoenix-security-group",
    Environment = "dev",
    App         = "phoenix"
  }
}

variable "security_group_vpc_id" {
  description = "(Required) The ID of the VPC."
  type        = string
}

variable "security_group_name" {
  description = "(Optional, Forces new resource) The name of the security group. If omitted, Terraform will assign a random, unique name."
  type        = string
}

variable "security_group_name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = "/"
}

variable "security_group_description" {
  description = "(Optional, Forces new resource) The security group description. Defaults to 'Managed by Terraform'. Cannot be empty. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags."
  type        = string
  default     = "/"
}

variable "security_group_revoke_rules_on_delete" {
  description = "(Optional) Instruct Terraform to revoke all of the Security Groups attached ingress and egress rules before deleting the rule itself. This is normally not needed, however certain AWS services such as Elastic Map Reduce may automatically add required rules to security groups used with the service, and those rules may contain a cyclic dependency that prevent the security groups from being destroyed without removing the dependency first. Default false."
  type        = bool
  default     = false
}

#------------------------------------------------------------------------------
# Security group - ingress - variables
#------------------------------------------------------------------------------
variable "ingress_rules" {
  description = "(Required) Ingress rules."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
    sg_source   = string
  }))
  //  default     = [
  //    {
  //      from_port   = 22
  //      to_port     = 22
  //      protocol    = "tcp"
  //      cidr_block  = "1.2.3.4/32"
  //      description = "test"
  //    },
  //    {
  //      from_port   = 23
  //      to_port     = 23
  //      protocol    = "tcp"
  //      cidr_block  = "1.2.3.4/32"
  //      description = "test"
  //    },
  //  ]
}

variable "ingress_from_port" {
  description = "(Optional) The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')."
  type        = number
  default     = 443
}

variable "ingress_to_port" {
  description = "(Optional) The end range port (or ICMP code if protocol is 'icmp')."
  type        = number
  default     = 443
}

variable "ingress_protocol" {
  description = "(Optional) The protocol. If you select a protocol of '-1' (semantically equivalent to 'all', which is not a valid value here), you must specify a 'from_port' and 'to_port' equal to 0. The supported values are defined in the 'IpProtocol' argument on the IpPermission API reference. This argument is normalized to a lowercase value to match the AWS API requirement when using with Terraform 0.12.x and above, please make sure that the value of the protocol is specified as lowercase when using with older version of Terraform to avoid an issue during upgrade."
  type        = string
  default     = "tcp"
}

variable "ingress_cidr_block" {
  description = "(Optional) List of CIDR blocks."
  type        = list(any)
  default     = ["10.0.0.0/16", "10.0.0.0/24"]
}

variable "ingress_ipv6_cidr_blocks" {
  description = "(Optional) List of IPv6 CIDR blocks."
  type        = list(any)
  default     = ["2001:db8:1234:1a00::/64"]
}

variable "ingress_prefix_list_ids" {
  description = "(Optional) List of Prefix List IDs."
  type        = list(any)
  default     = ["10.0.0.0/16", "10.0.0.0/24"]
}

variable "ingress_security_groups" {
  description = "(Optional) List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC."
  type        = list(any)
  default     = ["sg-1", "sg-2"]
}

variable "ingress_self" {
  description = "(Optional) If true, the security group itself will be added as a source to this ingress rule."
  type        = bool
  default     = false
}

variable "ingress_description" {
  description = "(Optional) Description of this ingress rule."
  type        = string
  default     = "/"
}

#------------------------------------------------------------------------------
# Security group - egress - variables
#------------------------------------------------------------------------------
variable "egress_rules" {
  description = "(Required) Egress rules."
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = string
    description = string
    sg_source   = string
  }))
}

variable "egress_from_port" {
  description = "(Optional) The start port (or ICMP type number if protocol is 'icmp' or 'icmpv6')."
  type        = number
  default     = 0
}

variable "egress_to_port" {
  description = "(Optional) The end range port (or ICMP code if protocol is 'icmp')."
  type        = number
  default     = 0
}

#ToDo
//variable "egress_protocol" {
//  description = "(Optional) The protocol. If you select a protocol of '-1' (semantically equivalent to 'all', which is not a valid value here), you must specify a 'from_port' and 'to_port' equal to 0. The supported values are defined in the 'IpProtocol' argument on the IpPermission API reference. This argument is normalized to a lowercase value to match the AWS API requirement when using with Terraform 0.12.x and above, please make sure that the value of the protocol is specified as lowercase when using with older version of Terraform to avoid an issue during upgrade."
//  type        = string
//  default     = '-1'
//}

variable "egress_cidr_block" {
  description = "(Optional) List of CIDR blocks."
  type        = list(any)
  default     = ["10.0.0.0/16", "10.0.0.0/24"]
}

variable "egress_ipv6_cidr_blocks" {
  description = "(Optional) List of IPv6 CIDR blocks."
  type        = list(any)
  default     = ["2001:db8:1234:1a00::/64"]
}

variable "egress_prefix_list_ids" {
  description = "(Optional) List of Prefix List IDs."
  type        = list(any)
  default     = ["sg-1", "sg-2"]
}

variable "egress_security_groups" {
  description = "(Optional) List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC."
  type        = list(any)
  default     = ["sg-1", "sg-2"]
}

variable "egress_self" {
  description = "(Optional) If true, the security group itself will be added as a source to this egress rule."
  type        = bool
  default     = false
}

variable "egress_description" {
  description = "(Optional) Description of this egress rule."
  type        = string
  default     = "/"
}
