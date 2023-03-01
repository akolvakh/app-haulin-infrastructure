#------------------------------------------------------------------------------
# WAFv2 variables
#------------------------------------------------------------------------------
variable "waf_name" {
  description = "(Required) Name of the WAF."
  type        = string
}
variable "waf_metric_name" {
  description = "(Required) Metric name of the WAF."
  type        = string
}
variable "waf_elb_arn" {
  description = "(Required) Elb arn for WAF."
  type        = string
}

variable "waf_scope" {
  description = "(Required) WAF Scope."
  type        = string
}

variable "waf_priority" {
  description = "(Required) WAF Rule Priority."
  type        = number
}

variable "waf_aggregate_key_type" {
  description = "(Required) WAF Rule aggregate key type."
  type        = string
}

variable "waf_rate_limit" {
  description = "(Required) WAF Rule rate limit."
  type        = number
}
