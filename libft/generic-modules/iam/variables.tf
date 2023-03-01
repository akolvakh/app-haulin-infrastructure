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

variable "region" {
  description = "(Required) Region."
  type        = string
}

#------------------------------------------------------------------------------
# IAM role variables
#------------------------------------------------------------------------------
variable "inline_policy" {
  description = "(Required) Inline Policy."
  type        = string
  default     = "/"
}

variable "description" {
  description = "(Optional) Description of the role."
  type        = string
  default     = "/"
}

variable "force_detach_policies" {
  description = "(Optional) Whether to force detaching any policies the role has before destroying it. Defaults to false."
  type        = bool
  default     = false
}

variable "managed_policy_arns" {
  description = "(Optional) Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. When configured, Terraform will align the role's managed policy attachments with this set by attaching or detaching managed policies. Configuring an empty set (i.e., managed_policy_arns = []) will cause Terraform to remove all managed policy attachments."
  type        = list(string)
  default     = ["/"]
}

variable "max_session_duration" {
  description = "(Optional) Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  type        = number
  default     = 3600
}

variable "name" {
  description = "(Optional, Forces new resource) Friendly name of the role. If omitted, Terraform will assign a random, unique name. See IAM Identifiers for more information."
  type        = string
}

variable "name_prefix" {
  description = "(Optional, Forces new resource) Creates a unique friendly name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = "/"
}

variable "path" {
  description = "(Optional) Path to the role. See IAM Identifiers for more information."
  type        = string
  default     = "/"
}

variable "permissions_boundary" {
  description = "(Optional) ARN of the policy that is used to set the permissions boundary for the role."
  type        = string
  default     = "/"
}

variable "tags" {
  description = "Key-value mapping of tags for the IAM role."
  type        = map(string)
  default = {
    Environment = "dev",
    App         = "phoenix",
    Name        = "phoenix-iam"
  }
}

#ToDo
variable "assume_role_policy" {
  description = "(Required) Assume role policy."
}
variable "policy_arn" {
  description = "(Required) Policy arn."
}
