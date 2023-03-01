variable "ecr_enable" {
  description = "create this ecr?"
  type        = bool
}
#--------------------------------------------------------------
# ECR Tag Variables
#--------------------------------------------------------------
variable "tag_product" {
  description = "RETIRED. set by provider.defaultTags. Sample: phoenix baning-app."
  type        = string
  default     = ""
}
variable "tag_role" {
  description = "Sample: xyz_service_ecr"
  type        = string
}


variable "tag_contact" {
  description = "RETIRED. Set by Provider.DefaultTags instead. Who to reach with questions and requests for this resource? Should be valid email address"
  type        = string
  default     = ""
}

variable "tag_environment" {
  description = "RETIRED. set by Provider.defaultTags instead. Environment. Sample : dev,staging,prod"
  type        = string
  default     = ""
}

variable "tag_orchestration" {
  description = "RETIRED in modules. Set by Provider.defaulTags instead. Link to AWS SSP parameter holding version of the module being deployed"
  type        = string
  default     = ""
}

variable "tag_description" {
  description = "Few meaningful words, to describe what this resource does"
  type        = string
}

variable "ecr_additional_tags" {
  description = "A map of additional tags, just tag/value pairs, to add to the VPC."
  type        = map(string)
  default     = {}
}
