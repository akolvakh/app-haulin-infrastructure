############################################################################
# CodePipeline
############################################################################

variable "gh_connection_arn" {
  type        = string
  description = "AWS Github connection ARN (you should create it manually)"
}

variable "app_code_repo_owner" {
  type        = string
  description = "GitHub Organization or Username"
  default     = "phoenix"
}

variable "app_code_repo_name" {
  type        = string
  description = "GitHub repository name of the application to be built and deployed to ECS"
}

variable "app_code_branch" {
  type        = string
  description = "Branch of the GitHub repository with app code, _e.g._ `develop`"
  default     = "develop"
}

variable "tf_code_repo_owner" {
  type        = string
  description = "GitHub Organization or Username"
  default     = "phoenix"
}

variable "tf_code_repo_name" {
  type        = string
  description = "GitHub repository name of the application to be built and deployed to ECS"
}

variable "tf_code_branch" {
  type        = string
  description = "Branch of the GitHub repository tf code, _e.g._ `develop`"
  default     = "develop"
}

variable "appsync_module_path" {
  type        = string
  description = "Path of the appsync deployment TF module"
}

variable "poll_source_changes" {
  type        = bool
  default     = true
  description = "Periodically check the location of your source content and run the pipeline if changes are detected"
}

variable "environment" {
  description = "what environment we deploy service into"
}

variable "product_name" {
  type        = string
  description = "Product name"
}

variable "codepipeline_label" {
  type        = string
  description = "Codepipeline label"
}

############################################################################
# CodeBuild
############################################################################

variable "aws_codebuild_project_description" {
  type        = string
  description = "AWS CodeBuild project description"
}

variable "aws_codebuild_environment_image" {
  type        = string
  description = "AWS CodeBuild environment image"
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}

variable "aws_backend_region" {
  type        = string
  description = "Terraform AWS backend region"
  default     = "us-east-1"
}

variable "service_version" {
  type        = string
  description = "Version tag to build from"
  default     = "HEAD"

  validation {
    condition     = can(regex("^(HEAD|v\\d+(\\.\\d+(\\.\\d+)?)?|latest)$", var.service_version))
    error_message = "The service version should be version tag (e. g v1, v1.0, v1.0.0) or \"latest\"."
  }
}

variable "infrastructure_version" {
  type        = string
  description = "Version tag to build from"
  default     = "HEAD"

  validation {
    condition     = can(regex("^(HEAD|v\\d+(\\.\\d+(\\.\\d+)?)?|latest)$", var.infrastructure_version))
    error_message = "The infrastructure version should be version tag (e. g v1, v1.0, v1.0.0) or \"latest\"."
  }
}

############################################################################
# General
############################################################################

variable "tags" {
  type        = map(any)
  description = "Resource tags"
}

variable "appsync_be_schema" {
  type        = string
  description = "Path to the appsync be schema in be repo"
}

variable "appsync_admin_schema" {
  type        = string
  description = "Path to the appsync admin schema in be repo"
}

### Resolvers
variable "be_resolvers_dir" {
  description = "Path to be resolvers dir"
}

variable "config_resolvers_dir" {
  description = "Path to config resolvers dir"
}

variable "admin_resolvers_dir" {
  description = "Path to admin resolvers dir"
}

variable "i2c_resolvers_dir" {
  description = "Path to i2c resolvers dir"
}

variable "notification_resolvers_dir" {
  description = "Path to notification resolvers dir"
}