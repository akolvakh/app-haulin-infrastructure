variable "private" {
  type        = bool
  description = "create Private DNS hosted zone?"
  default     = true
}

variable "vpc_ids" {
  type        = list(string)
  description = "IDs of VPC to expose this DNS hosted zone to. Makes sense only when the zone is private"
  default     = []
}

variable "domain" {
  type        = string
  description = "DNS domain to create"
}

#--------------------------------------------------------------
# VPC Tag Variables
#--------------------------------------------------------------
variable "tag_product" {
  description = "Sample: Zytaa baning-app."
  type        = string
}

variable "tag_contact" {
  description = "Who to reach with questions and requests for this resource? Should be valid email address"
  type        = string
}

variable "tag_environment" {
  description = "Environment. Sample : dev,staging,prod"
  type        = string
}

variable "tag_orchestration" {
  description = "Where in git we find TF code controlling/instantiating this module?"
  type        = string
}

variable "tag_description" {
  description = "Few meaningful words, to describe what this resource does"
  type        = string
}

variable "dns_additional_tags" {
  description = "A map of additional tags, just tag/value pairs, to add to the VPC."
  type        = map(string)
  default     = {}
}