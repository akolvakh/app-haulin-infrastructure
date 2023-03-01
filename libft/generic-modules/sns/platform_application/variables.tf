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
# Platform application variables
#------------------------------------------------------------------------------
variable "name" {
  description = "(Required) The friendly name for the SNS platform application."
  type        = string
}

variable "platform" {
  description = "(Required) The platform that the app is registered with. See Platform for supported platforms."
  type        = string
}

variable "platform_credential" {
  description = "(Required) Application Platform credential. See Credential for type of credential required for platform. The value of this attribute when stored into the Terraform state is only a hash of the real value, so therefore it is not practical to use this as an attribute for other resources."
  type        = string
}

variable "event_delivery_failure_topic_arn" {
  description = "(Optional) SNS Topic triggered when a delivery to any of the platform endpoints associated with your platform application encounters a permanent failure."
  type        = string
  default     = ""
}

variable "event_endpoint_created_topic_arn" {
  description = "(Optional) SNS Topic triggered when a new platform endpoint is added to your platform application."
  type        = string
  default     = ""
}

variable "event_endpoint_deleted_topic_arn" {
  description = "(Optional) SNS Topic triggered when an existing platform endpoint is deleted from your platform application."
  type        = string
  default     = ""
}

variable "event_endpoint_updated_topic_arn" {
  description = "(Optional) SNS Topic triggered when an existing platform endpoint is changed from your platform application."
  type        = string
  default     = ""
}

variable "failure_feedback_role_arn" {
  description = "(Optional) The IAM role permitted to receive failure feedback for this application."
  type        = string
  default     = ""
}

variable "platform_principal" {
  description = "(Optional) Application Platform principal. See Principal for type of principal required for platform. The value of this attribute when stored into the Terraform state is only a hash of the real value, so therefore it is not practical to use this as an attribute for other resources."
  type        = string
  default     = ""
}

variable "success_feedback_role_arn" {
  description = "(Optional) The IAM role permitted to receive success feedback for this application."
  type        = string
  default     = ""
}

variable "success_feedback_sample_rate" {
  description = "(Optional) The percentage of success to sample (0-100)."
  type        = number
  default     = ""
}
