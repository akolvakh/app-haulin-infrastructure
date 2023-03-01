//repo level template
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
     environment = var.environment
     contact       = "a.kolvakh@geniusee.com"
     //product    = var.product
   }
 }
}
