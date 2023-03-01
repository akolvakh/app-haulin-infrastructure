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

variable "tf_ecs_module_path" {
  type        = string
  description = "Path of the ECS service deployment TF module"
}

variable "poll_source_changes" {
  type        = bool
  default     = true
  description = "Periodically check the location of your source content and run the pipeline if changes are detected"
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS Cluster Name"
}

variable "environment" {
  description = "what environment we deploy service into"
}

variable "product_name" {
  type        = string
  description = "Product name"
}

variable "service_name" {
  type        = string
  description = "ECS Service Name"
}

variable "task_execution_role_arn" {
  type        = string
  description = "The ARN of ECS task execution role"
}

variable "task_role_arn" {
  type        = string
  description = "The ARN of ECS task role"
}

variable "codepipeline_label" {
  type        = string
  description = "Codepipeline label"
}

############################################################################
# CodeBuild
############################################################################

//variable "aws_codebuild_project_name" {
//  type        = string
//  description = "AWS CodeBuild project name"
//}

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
  type    = string
  default = "us-east-1"
}

variable "ecr_account_id" {
  type    = string
  default = "822856406661"
}

variable "buildspec_filename" {
  type        = string
  description = "buildspec file name"
  default     = "buildspec.yaml"
}

variable "dockerfile_name" {
  type        = string
  description = "Dockerfile name"
  default     = "Dockerfile"
}

variable "aws_backend_region" {
  type        = string
  description = "Terraform AWS backend region"
  default     = "us-east-2"
}

variable "appsync_arn" {
  type        = string
  description = "AppSync ARN required to provide permissions to update AppSync from CodeBuild pipelines"
}

variable "appsync_resolvers_list_module_path" {
  type        = string
  description = "Path to the appsync_resolvers module in phoenix-infrastructure repo"
  default     = "deployments/nft-portal/55.appsync_resolvers"
}

variable "appsync_deploy_module_path" {
  type        = string
  description = "Path to the ecs_service_be_appsync_deploy module in phoenix-infrastructure repo"
}

variable "appsync_resolvers_dir" {
  type        = string
  description = "Path to the resolvers dir in phoenix-be repo"
}

############################################################################
# General
############################################################################

variable "tags" {
  type        = map(any)
  description = "Resource tags"
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
