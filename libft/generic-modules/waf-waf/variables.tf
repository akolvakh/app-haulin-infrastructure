#------------------------------------------------------------------------------
# General variables
#------------------------------------------------------------------------------

#------------------------------------------------------------------------------
# WAF variables
#------------------------------------------------------------------------------
variable "waf_prefix" {
  description = "Prefix to use when naming resources"
  type        = string
}

variable "blacklisted_ips" {
  description = "List of IPs to blacklist, eg ['1.1.1.1/32', '2.2.2.2/32', '3.3.3.3/32']"
  type        = list(string)
  default     = []
}

variable "admin_remote_ipset" {
  description = "List of IPs allowed to access admin pages, ['1.1.1.1/32', '2.2.2.2/32', '3.3.3.3/32']"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

#------------------------------------------------------------------------------
# WAF Rules variables
#------------------------------------------------------------------------------
variable "rule_sqli_action" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  type        = string
  default     = "COUNT"
}

variable "rule_auth_tokens_action" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  type        = string
  default     = "COUNT"
}

variable "rule_xss_action" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  type        = string
  default     = "COUNT"
}

variable "rule_lfi_rfi_action" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  type        = string
  default     = "COUNT"
}

variable "rule_admin_access_action_type" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  type        = string
  default     = "COUNT"
}

variable "rule_php_insecurities_action_type" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  type        = string
  default     = "COUNT"
}

variable "rule_size_restriction_action_type" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  type        = string
  default     = "COUNT"
}

variable "rule_csrf_action_type" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  type        = string
  default     = "COUNT"
}

variable "rule_csrf_header" {
  description = "The name of your CSRF token header."
  type        = string
  default     = "x-csrf-token"
}

variable "rule_ssi_action_type" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  type        = string
  default     = "COUNT"
}

variable "rule_blacklisted_ips_action_type" {
  description = "Rule action type. Either BLOCK, ALLOW, or COUNT (useful for testing)"
  type        = string
  default     = "COUNT"
}
