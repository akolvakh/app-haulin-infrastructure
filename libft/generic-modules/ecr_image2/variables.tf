variable "dockerfile_name" {
  type        = string
  description = "Dockerfile name"
}

variable "build_context" {
  type        = string
  description = "Docker build context name"
  default     = ""
}

variable "ecr_repository_url" {
  type        = string
  description = "Full url for the ecr repository"
}

variable "docker_image_tag" {
  type        = string
  description = "This is the tag which will be used for the image that you created"
  default     = "latest"
}

variable "aws_region" {
  type        = string
  description = "AWS region for ECR"
  default     = ""
}
