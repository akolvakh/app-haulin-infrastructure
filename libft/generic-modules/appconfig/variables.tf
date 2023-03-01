
variable "appconfig_app_label" {
  type        = string
  description = "The name for the Appconfig application. Must be between 1 and 64 characters in length"
}

variable "appconfig_profile_location" {
  type        = string
  description = "A URI to locate the configuration. You can specify the AWS AppConfig hosted configuration store, Systems Manager (SSM) document, an SSM Parameter Store parameter, or an Amazon S3 object"
}

variable "content_type" {
  type        = string
  description = "A standard MIME type describing the format of the configuration content"
}

variable "configuration_content" {
  type        = string
  description = "The content of the configuration or the configuration data"
}
