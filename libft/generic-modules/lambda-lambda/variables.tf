variable "tracing_mode" {
  description = "Tracing mode of the Lambda Function. Valid value can be either PassThrough or Active."
  type        = string
  default     = "Active"
}

variable "function_name" {
  description = "Name of the lambda function"
  type        = string
}

variable "function_role_path" {
  description = "Function role path"
  type        = string
}

variable "function_archive" {
  description = "Name of the path to the lambda function archive"
  type        = string
}

variable "function_handler" {
  description = "Name of the lambda function"
  type        = string
}

variable "function_runtime" {
  description = "Name of the lambda runtime with version (node, python)"
  type        = string
}

variable "create_role" {
  description = "Controls whether IAM role for Lambda Function should be created"
  type        = bool
  default     = true
}

variable "lambda_role" {
  description = " IAM role ARN attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. See Lambda Permission Model for more details."
  type        = string
  default     = ""
}

variable "function_sha256" {
  description = "Sha256 of the function archive"
  type        = string
}

variable "function_timeout" {
  description = "The amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 3
}

variable "vpc_subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = null
}

variable "vpc_security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "trusted_entities" {
  description = "Lambda Function additional trusted entities for assuming roles (trust relationship)"
  type        = list(string)
  default     = []
}

variable "lambda_at_edge" {
  type        = bool
  description = "Set this to true if using Lambda@Edge, to enable publishing"
  default     = false
}

# Layer Variables
variable "create_layer" {
  description = "Controls whether Lambda Layer resource should be created"
  type        = bool
  default     = true
}

variable "layer_name" {
  description = "Name of lambda layer to create"
  type        = string
  default     = ""
}

variable "layer_archive" {
  description = "Path to the layer archive file (.zip)"
  type        = string
  default     = ""
}

variable "layer_sha256" {
  description = "Unique sha256 of the layer archive file"
  type        = string
  default     = ""
}

variable "layer_version" {
  description = "Version of the lambda layer"
  type        = string
  default     = ""
}

variable "environment_variables" {
  description = "Environment variables passed to the lambda"
  type        = map(string)
  default     = {}
}

variable "file_system_arn" {
  description = "ARN of the EFS Access Point that provides access to the file system."
  type        = string
  default     = null
}

variable "file_system_local_mount_path" {
  description = "The path where the function can access the file system, starting with /mnt/."
  type        = string
  default     = null
}

variable "memory_size" {
  default = 128
}