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
      Environment = var.environment
      Contact     = "devops-team+${var.environment}@${var.product}.com"
      Product     = "${var.product}-app" //to automate this one - derive from stack source code folder name
      Orchestration = var.tag_orchestration	
    }
  }
}
provider "aws" {
  alias  = "backup_acct"
  region = var.aws_backup_region
  default_tags {
    tags = {
      Environment = var.environment
      Contact     = "devops-team+${var.environment}@${var.product}.com"
      Product     = "${var.product}-app" //to automate this one - derive from stack source code folder name
      Orchestration = var.tag_orchestration	
    }
  }
}
