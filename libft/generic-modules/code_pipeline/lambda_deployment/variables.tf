############################################################################
# CodePipeline
############################################################################

variable "gh_connection_arn" {
  type        = string
  description = "AWS Github connection ARN (you should create it manually)"
}

variable "tf_code_repo_owner" {
  type        = string
  description = "GitHub Organization or Username"
  default     = "phoenix"
}

variable "tf_code_repo_name" {
  type        = string
  description = "GitHub repository name of the tf infrastructure code"
}

variable "tf_code_branch" {
  type        = string
  description = "Branch of the GitHub repository with tf code, _e.g._ `develop`"
}

variable "lambda_code_repo_owner" {
  type        = string
  description = "GitHub Organization or Username"
  default     = "phoenix"
}

variable "lambda_code_repo_name" {
  type        = string
  description = "GitHub repository name of the application to be built and deployed to ECS"
}

variable "lambda_code_branch" {
  type        = string
  description = "Branch of the GitHub repository lambda code, _e.g._ `develop`"
  default     = "develop"
}

variable "lambda_module_path" {
  type        = string
  description = "Path of the Lambda deployment TF module"
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

variable "aws_codebuild_project_name" {
  type        = string
  description = "AWS CodeBuild project name"

}

variable "aws_codebuild_project_description" {
  type        = string
  description = "AWS CodeBuild project description"
}

variable "aws_codebuild_environment_image" {
  type        = string
  description = "AWS CodeBuild environment image"
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}

variable "ecr_region" {
  type        = string
  description = "ECR region"
}

variable "ecr_account_id" {
  type        = string
  description = "ECR account id"
}

variable "dockerfile_name" {
  type        = string
  description = "Dockerfile name"
}

variable "aws_backend_region" {
  type        = string
  description = "Terraform AWS backend region"
}

variable "aws_region" {
  description = "what region we depoy service into"
}

variable "lambda_version" {
  type        = string
  description = "Version tag to build from"
  default     = "HEAD"

  validation {
    condition     = can(regex("^(HEAD|v\\d+(\\.\\d+(\\.\\d+)?)?|latest)$", var.lambda_version))
    error_message = "The lambda version should be version tag (e. g v1, v1.0, v1.0.0) or \"latest\"."
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

variable "lambda_names" {
  description = "List of Lambdas` names"
}

variable "lambda_ecr_arns" {
  description = "List of ecr arns for Lambdas"
}

variable "build_timeout" {
  description = "Build timeout."
  type        = string
  default     = "5"
}

variable "pipeline_additional_tags" {
  type        = map(any)
  description = "map of tags to be added to all resources created by this module. Say for cost tracking, Jira issue refernce, etc"
  default     = {}
}