variable "vpc_cidr_block" {
  description = "CIDR block range for this VPC"
  type        = string
}


variable "vpc_name" {
  description = "The name of the VPC being created"
  type        = string
}

variable "ip_whitelist_cidr_blocks" {
  description = "cidr blocks allowed in public NACLS. In DEV/Staging supposed by VPNed ip range, in PROD - world"
  type        = list(string)
  default     = []
}

variable "private_hosted_domain" {
  description = "The private hosted zone domain name"
  type        = string
  default     = "phoenix.vpc.local"
}

variable "availability_zones" {
  description = "The AZs that the VPC will be using"
  type        = list(string)
}
/**
variable "public_subnets" {
  description = "The CIDR blocks to be used for the public subnets"
  type = list(object({
    cidr = string,
    tags = map(string)
  }))
  #EXAMPLE . 
  #public_subnets = [  
  # {"cidr"="10.1.21.0/24","tags"={"type"="public_loadbalancer"}},
  # {"cidr"="10.1.22.0/24","tags"={"type"="public_loadbalancer"}} 
  #]
}

variable "private_subnets" {
  description = "The CIDR blocks and tags to be used for the private subnets"
  type = list(object({
    cidr = string,
    tags = map(string)
  }))
  #EXAMPLE . 
  #private_subnets = [  
  # {"cidr"="10.1.1.0/24","tags"={"type"="db"}},
  # {"cidr"="10.1.2.0/24","tags"={"type"="service"}} 
  #]
}
*/
variable "networks" {

}
#----------------------------------
# VPC peering variables. One oiptional peer supported
#----------------------------------

variable "peer_vpc_enable" {
  type    = bool
  default = false
}

variable "peer_account" {
  type        = string
  description = "account where VPC to peer with lives, Set equal to current account when no cross account peering"
  default     = ""
}
variable "peer_region" {
  type        = string
  description = "what region VPC to eastblish peering with hosted in?"
  default     = ""
}
variable "peer_vpc_id" {
  type        = string
  description = "ID of VPC to eastblish peering"
  default     = ""
}

variable "peer_vpc_cidr" {
  type        = string
  description = "to set routing, what CIDR the peered VPC has?"
  default     = ""
}

#--------------------------------------------------------------
# VPC Tag Variables
#--------------------------------------------------------------
variable "tag_product" {
  description = "RETIRED. Set by Prpvider.DefaultTags. Sample: Zytaa baning-app."
  type        = string
  default     = ""
}

variable "tag_contact" {
  description = "RETIRED. Set by Proivder.DefaultTagsWho to reach with questions and requests for this resource? Should be valid email address"
  type        = string
  default     = ""
}

variable "tag_environment" {
  description = "RETIRED. Set by Provider.DefaultTags. Environment. Sample : dev,staging,prod"
  type        = string
  default     = ""
}

variable "tag_orchestration" {
  description = "RETIRED. Set by Provider.DefaultTags.Where in git we find TF code controlling/instantiating this module?"
  type        = string
  default     = ""
}

variable "tag_description" {
  description = "Few meaningful words, to describe what this resource does"
  type        = string
}

variable "vpc_additional_tags" {
  description = "A map of additional tags, just tag/value pairs, to add to the VPC."
  type        = map(string)
  default     = {}
}
variable "create_nat" {
  description = "Want have NAT from private subnets?"
  type        = bool
  default     = true
}
variable "nat_gateways_redundancy" {
  description = <<EOF
  How many NAT Gateways create? 
  Those will be placed in public subnet(s) tagged by  tag for_nat=true
  No more than specified number of gateways per VPC will be created
  EOF
  type        = number
  default     = 1
}
