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
variable "lambda_post_authentication_arn" {
  type    = string
  default = ""
}
variable "lambda_custom_email_sender_arn" {
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
variable "supported_identity_providers" {}
variable "allowed_oauth_flows" {
  description = "Allowed OAuth Flows"
  type        = list(string)
  default     = []
}
variable "cognito_invite_email_subject" {}
variable "cognito_invite_email_message" {}

# lambda_config
variable "lambda_config" {
  description = "A container for the AWS Lambda triggers associated with the user pool"
  type        = any
  default     = {}
}

variable "lambda_config_create_auth_challenge" {
  description = "The ARN of the lambda creating an authentication challenge."
  type        = string
  default     = null
}

variable "lambda_config_custom_message" {
  description = "A custom Message AWS Lambda trigger."
  type        = string
  default     = null
}

variable "lambda_config_define_auth_challenge" {
  description = "Defines the authentication challenge."
  type        = string
  default     = null
}

variable "lambda_config_post_authentication" {
  description = "A post-authentication AWS Lambda trigger"
  type        = string
  default     = null
}

variable "lambda_config_post_confirmation" {
  description = "A post-confirmation AWS Lambda trigger"
  type        = string
  default     = null
}

variable "lambda_config_pre_authentication" {
  description = "A pre-authentication AWS Lambda trigger"
  type        = string
  default     = null
}
variable "lambda_config_pre_sign_up" {
  description = "A pre-registration AWS Lambda trigger"
  type        = string
  default     = null
}

variable "lambda_config_pre_token_generation" {
  description = "Allow to customize identity token claims before token generation"
  type        = string
  default     = null
}

variable "lambda_config_user_migration" {
  description = "The user migration Lambda config type"
  type        = string
  default     = null
}

variable "lambda_config_verify_auth_challenge_response" {
  description = "Verifies the authentication challenge response"
  type        = string
  default     = null
}

variable "lambda_config_kms_key_id" {
  description = "The Amazon Resource Name of Key Management Service Customer master keys. Amazon Cognito uses the key to encrypt codes and temporary passwords sent to CustomEmailSender and CustomSMSSender."
  type        = string
  default     = null
}

variable "lambda_config_custom_email_sender" {
  description = "A custom email sender AWS Lambda trigger."
  type        = any
  default     = {}
}

variable "lambda_config_custom_sms_sender" {
  description = "A custom SMS sender AWS Lambda trigger."
  type        = any
  default     = {}
}
