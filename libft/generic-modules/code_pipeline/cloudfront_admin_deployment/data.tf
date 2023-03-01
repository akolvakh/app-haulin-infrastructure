resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

data "aws_caller_identity" "current" {}
data "aws_default_tags" "default" {}
data "aws_region" "current" {}