variable "vpc_id" {
  type        = string
  description = "ID of VPC  the secreutiy group being created in"
}
variable "ingress" {
  description = "list of objects, every object is precisely what you put into 'ingress' block in an aws_security_group. Ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group"
}
variable "egress" {
  description = "list of objects, every object is precisely what you put into 'egress' block in an aws_security_group. Ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group"
}

##########################################
#  SecGroup tags variables
##########################################

variable "tag_product" {
  description = "RETIRED. Set by Provider.DefaultTags instead. Sample: phoenix_phoenix_ppp"
  type        = string
  default     = ""
}

variable "tag_role" {
  description = "Sample: private_lb"
  type        = string
}


variable "tag_contact" {
  description = "RETIRED. Set by Provider.defaultTags instead Who to reach with questions and requests for this resource? Should be valid email address"
  type        = string
  default     = ""
}

variable "tag_environment" {
  description = "RETIRED. Set by Provider.defaultTags instead. Environment. Sample : dev,staging,prod"
  type        = string
  default     = ""
}

variable "tag_orchestration" {
  description = "RETIRED> Set by Provider. defaultTags instead Where in git we find TF code controlling/instantiating this module?"
  type        = string
  default     = ""
}

variable "tag_description" {
  description = "Few meaningful words, to describe what this resource does"
  type        = string
}

variable "sg_additional_tags" {
  description = "A map of additional tags, just tag/value pairs, to add to the SG."
  type        = map(string)
  default     = {}
}


variable "label" {}