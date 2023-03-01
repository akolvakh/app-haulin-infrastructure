variable "role_arn" {
  type        = string
  description = "anr of role to impersoante by this lambda"
}

variable "env_variables" {
  type        = map(string)
  description = "key value pairs to be exposed to lambda code at runtime as OS env variables"
}
variable "image_config" {
  type        = map(any)
  description = "Docker configuratino for iamge being launched inside Lambda, overriding defaults from the image"
  default     = {}
}
variable "image_url" {
  type        = string
  description = "full path to docker iamge to be deployed as lambda. Sample = 123412341234.dkr.ecr.sa-east-1.amazonaws.com/superl-code-in-docker:123"
}

variable "runtime_timeout" {
  type        = number
  description = "Amount of time your Lambda Function has to run in seconds"
  default     = 10
}
variable "memory_size" {
  type        = number
  description = "RAM cap for the Lambda, MBs"
  default     = 128
}
variable "lambda_at_edge" {
  type        = bool
  description = "Set this to true if using Lambda@Edge, to enable publishing, limit the timeout, and allow edgelambda.amazonaws.com to invoke the function"
  default     = false
}
#######################
#tagging variables
#######################

variable "tag_role" {
  description = "Sample: zyz_lambda"
  type        = string
}


variable "tag_description" {
  description = "Few meaningful words, to describe what this resource does"
  type        = string
}

variable "lambda_additional_tags" {
  description = "A map of additional tags, just tag/value pairs, to add to the VPC."
  type        = map(string)
  default     = {}
}


#######################
#vpc variables
#######################
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
