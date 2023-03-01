variable "ip_set_name" {
  default = "cloudflare"
}

variable "ip_set_description" {
  default = "Set of Cloudflare IP addresses"
}

variable "ip_addresses" {
  default = null
}

variable "waf_prefix" {
  description = "Prefix to use when naming resources"
  type        = string
}

variable "rule_name" {}

variable "web_acl_description" {
  default = "Managed rule"
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

variable "tag_role" {
  default = ""
}