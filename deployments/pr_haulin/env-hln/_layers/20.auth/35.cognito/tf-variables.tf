#--------------------------------------------------------------
# Connections
#--------------------------------------------------------------
#lambdas
#variable "outputs_lambda_lambda_pre_authentication_arn" {}
#variable "outputs_lambda_lambda_pre_authentication_function_name" {}
#variable "outputs_lambda_lambda_post_authentication_arn" {}
#variable "outputs_lambda_lambda_post_authentication_function_name" {}
#variable "outputs_lambda_lambda_post_confirmation_arn" {}
#variable "outputs_lambda_lambda_post_confirmation_function_name" {}
#variable "outputs_lambda_lambda_custom_email_sender_arn" {}
#variable "outputs_lambda_lambda_custom_email_sender_function_name" {}

#--------------------------------------------------------------
# General
#--------------------------------------------------------------
variable "label" {}
variable "profile" {}
variable "cognito_urls" {}
variable "cognito_invite_email_message" {}
variable "vpc_cidr" {}
variable "schemas" {}


variable "tf_framework_component_version" {
  description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
}
variable "cognito_additional_tags" {
  type        = map(string)
  description = "map of tags to be added to all resources created by this module"
  default     = {}
}

#--------------------------------------------------------------
# SES
#--------------------------------------------------------------
variable "external_dns_domain" {
  description = "visible in internet DNS name of current environment. non-prod-PRODUCT.com/PRODUCT.com"
}

#--------------------------------------------------------------
# Lambdas
#--------------------------------------------------------------
variable "lambda_pre_signup_version" {
  description = "version of pre signup lambda to deploy. To be set by CD autamation"
  default     = "latest"
}
