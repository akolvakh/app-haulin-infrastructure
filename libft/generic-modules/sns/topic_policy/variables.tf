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

variable "account_id" {
  description = "(Optional) The ID of the account."
  type        = string
  default     = ""
}

#------------------------------------------------------------------------------
# Topic policy variables
#------------------------------------------------------------------------------
variable "arn" {
  description = "(Required) The ARN of the SNS topic."
  type        = string
}

variable "policy" {
  description = "(Required) The fully-formed AWS policy as JSON. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
}
