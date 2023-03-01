// stack level template
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Environment     = var.environment
      Contact         = var.contact
      Product         = var.product
      Orchestration   = var.tag_orchestration
      Stage           = "1"
      Name            = "1"
      Layer           = "1"
      Jira            = "1"
      Description     = "1"
      moduleVersion   = "1"
    }
  }
 }


// stack level template
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.aws_region
 }
