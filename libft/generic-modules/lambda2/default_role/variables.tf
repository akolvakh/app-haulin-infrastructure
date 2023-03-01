variable "trusted_entities" {
  description = "Lambda Function additional trusted entities for assuming roles (trust relationship)"
  type        = list(string)
  default     = []
}
variable "lambda_at_edge" {
  type        = bool
  description = "Set this to true if using Lambda@Edge, to enable publishing, limit the timeout, and allow edgelambda.amazonaws.com to invoke the function"
  default     = false
}

#######################
#tagging variables
#######################

variable "tag_product" {
  description = "RETIRED. repalced by Provider.defaultTAgs. Sample: phoenix-phoenix-app."
  type        = string
  default     = ""
}

variable "tag_role" {
  description = "Sample: zyz_lambda"
  type        = string
}


variable "tag_contact" {
  description = "RETIRED. Repalced by provider.defaultTags. Who to reach with questions and requests for this resource? Should be valid email address"
  type        = string
  default     = ""
}

variable "tag_environment" {
  description = "RETIRED. Repalced by Provider.defaultTag. Environment. Sample : dev,staging,prod"
  type        = string
  default     = ""
}

variable "tag_orchestration" {
  description = "RETIRED. Repalced by Provider.defaultTags. Where in git we find TF code controlling/instantiating this module?"
  type        = string
  default     = ""
}

variable "tag_description" {
  description = "Few meaningful words, to describe what this resource does"
  type        = string
}

variable "lambda_additional_tags" {
  description = "A map of additional tags, just tag/value pairs, to add to the VPC."
  type        = map(string)
  default     = {}
}
