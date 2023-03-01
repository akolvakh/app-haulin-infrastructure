variable "aws_region" {
  description = "what region we deploy into"
}

variable "vpc_id" {
  type        = string
  description = "ID of VPC hosting RDS to be managed"
}
variable "security_group_ids" {
  type        = list(string)
  description = "security group ids to be assigned to e temp codeBuild instance that connects to RDS"
}

variable "db_subnet_ids" {
  type        = set(string)
  description = "ids of subnet hosting RDS DB. The module launches codebuild tep instance there to connect to RDS"
}
variable "db_entrypoint" {
  type        = string
  description = "RDS url to connect to"
}
variable "db_pswd_secret_arn" {
  type        = string
  description = "ARN of secret holding DB password in Secret Manager"
}
variable "gh_connection_arn" {
  type        = string
  description = "code star GitHub connection arn, to get access to Git"
}
variable "app_code_repo_owner" {
  type        = string
  description = "GitHub Organization or Username"
  default     = "phoenix"
}

variable "app_code_repo_name" {
  type        = string
  description = "GitHub repository name of the application to be built and deployed to ECS"
  default     = "phoenix-be"
}

variable "app_code_branch" {
  type        = string
  description = "Branch of the GitHub repository with app code, _e.g._ `develop`"
  default     = "develop"
}
variable "aws_codebuild_environment_image" {
  type        = string
  description = "AWS CodeBuild environment image"
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
}
variable "pipeline_additional_tags" {
  type        = map(any)
  description = "map of tags to be added to all resources created by this module. Say for cost tracking, Jira issue refernce, etc"
  default     = {}
}

variable "migrations_version" {
  type        = string
  description = "Version tag to build from"
  default     = "HEAD"

  validation {
    condition     = can(regex("^(HEAD|v\\d+(\\.\\d+(\\.\\d+)?)?|latest)$", var.migrations_version))
    error_message = "The migration version should be version tag (e. g v1, v1.0, v1.0.0) or \"latest\"."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "codepipeline_label" {
  type    = string
  default = "codepipeline_db_deployment"
}
