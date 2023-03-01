variable "name" {}

variable "size" {
  default = "Small"
}

variable "vpc_id" {}

variable "subnets" {
  type = list(string)
}

variable "tags" {
  type = map(any)
}

variable "password_arn" {
  description = "AWS Secret Manager ARN"
}