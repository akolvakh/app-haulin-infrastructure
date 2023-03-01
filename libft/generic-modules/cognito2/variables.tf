
variable "environment" {}
variable "tag_product" {
  default = "phoenix-app"
}
variable "name" {
  type        = string
  description = "name for user pool being created"
}

variable "password_policy" {
  type        = map(string)
  description = ""
}

# We will need this later
#
# variable "client_generate_secret" {
#   type        = bool
#   default     = false
#   description = "Should an application secret be generated"
# }

variable "phoenix_app_main_cognito" {
  type        = bool
  default     = false
  description = "Checker for an additional app client creation (with secret enabled)"
}

variable "mfa_configuration" {
  type    = string
  default = "OPTIONAL"
}
variable "allow_admin_create_user_only" {
  type    = bool
  default = true
}
variable "username_attributes" {
  type        = list(string)
  description = "Example [\"email\", \"phone_number\"]"
  default     = null
}
variable "alias_attributes" {
  type        = list(string)
  description = "Example [\"email\", \"phone_number\"]"
  default     = null
}

variable "read_attributes" {
  default = [
    "birthdate",
    "custom:role",
    "email",
    "family_name",
    "given_name",
    "middle_name",
    "phone_number",
    "phone_number_verified",
  ]
}

variable "write_attributes" {
  default = [
    "birthdate",
    "custom:role",
    "email",
    "family_name",
    "given_name",
    "middle_name",
    "phone_number",
  ]
}

variable "auto_verified_attributes" {
  type        = list(string)
  description = "Example [\"email\", \"phone_number\"]"
}

variable "software_token_mfa_configuration_enabled" {
  type    = bool
  default = false
}
variable "email_configuration_source_arn" {
  type        = string
  description = "arn of SES verified email"
}
variable "email_configuratino_from_email" {
  type        = string
  description = "FROM email"
}
variable "email_sending_account" {
  default = "DEVELOPER"
}
variable "lambda_presignup_arn" {
  type    = string
  default = ""
}
variable "lambda_preauthorization_arn" {
  type    = string
  default = ""
}
variable "lambda_postconfirmation_arn" {
  type    = string
  default = ""
}
variable "lambda_post_authenticationn_arn" {
  type    = string
  default = ""
}
variable "recovery_mechanisms" {
  type        = list(any)
  description = "how a user can recover lost ascess"
  default     = []

}
variable "token_expiration_access" {
  default     = 30
  type        = number
  description = "cognito ccess Token lifetme in minutes"
}
variable "token_expiration_identity" {
  default     = 30
  type        = number
  description = "cognito Identity Token lifetme in minutes"
}
variable "token_expiration_refresh" {
  default     = 1440
  type        = number
  description = "cognito Refresh Token lifetme in minutes"
}
variable "logout_urls" {
  type        = list(string)
  default     = []
  description = "array of Cognito logout urls, ref https://docs.aws.amazon.com/cognito/latest/developerguide/logout-endpoint.html"
}
variable "callback_urls" {
  type    = list(string)
  default = []
}
variable "domain" {
  type        = string
  description = "custom domain prefix for Cognito"

}
variable "schemas" {

}

variable "tag_contact" {
  description = "valid mail address to reach for questions and issues. <env> repalced by current environment name"
  // sadly TF does not let us substitute a variable inside a variable
  default = "devops-team+<env>@phoenix.com"
}
variable "tag_orchestration" {
  default = "https://github.com/phoenix/phoenix-infrastructure/blob/develop/deployments/phoenix-app-modularized/30.cognito"
}

variable "cognito_additional_tags" {
  type        = map(string)
  description = "map of tags to be added to all resources created by this module"
  default     = {}
}

variable "user_groups" {
  description = "A container with the user_groups definitions"
  type        = list(any)
  default     = []
}

variable "user_group_name" {
  description = "The name of the user group"
  type        = string
  default     = null
}

variable "user_group_description" {
  description = "The description of the user group"
  type        = string
  default     = null
}

variable "user_group_precedence" {
  description = "The precedence of the user group"
  type        = number
  default     = null
}

variable "user_group_role_arn" {
  description = "The ARN of the IAM role to be associated with the user group"
  type        = string
  default     = null
}

variable "prevent_user_existence_errors" {
  description = "ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cognito_user_pool_client#prevent_user_existence_errors. Allowed values LEGACY|ENABLED"
  type        = string
  default     = "ENABLED"
}

variable "idp_list" {
  description = "List of Identity Providers (SAML). ref /deployments/phoenix-app-modularized/35.cognito/saml-dev.json"
  default     = {}
}

variable "metadata_xml" {
  description = "Array of xml metadata"
  type        = list(string)
  default     = []
}
