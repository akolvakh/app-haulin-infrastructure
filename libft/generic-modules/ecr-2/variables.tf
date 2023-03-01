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

#------------------------------------------------------------------------------
# ECR variables
#------------------------------------------------------------------------------
variable "ecr_name" {
  description = "(Optional) Name of the repository."
  type        = string
  default     = "ecr-phoenix"
}

#ToDo Check: CKV_AWS_51: "Ensure ECR Image Tags are immutable"
variable "ecr_image_tag_mutability" {
  description = "(Optional) The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE."
  type        = string
  //    default     = "MUTABLE"
  default = "IMMUTABLE"
}

variable "ecr_tags" {
  description = "(Optional) A map of tags to assign to the resource."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-ecr"
  }
}

#------------------------------------------------------------------------------
# Image scanning configuration variables
#------------------------------------------------------------------------------
#ToDo Check: CKV_AWS_33: "Ensure ECR image scanning on push is enabled"
variable "isc_scan_on_push" {
  description = "(Optional) Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  type        = bool
  //    default     = false
  default = true
}

#------------------------------------------------------------------------------
# Encryption configuration variables
#------------------------------------------------------------------------------
variable "ecr_encryption_type" {
  description = "(Optional) The encryption type to use for the repository. Valid values are AES256 or KMS. Defaults to AES256."
  type        = string
  default     = "KMS"
}

variable "ecr_kms_key" {
  description = "(Required) The ARN of the KMS key to use when encryption_type is KMS. If not specified, uses the default AWS managed key for ECR."
  type        = string
}
