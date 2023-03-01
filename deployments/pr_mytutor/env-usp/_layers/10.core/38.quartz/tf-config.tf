#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_caller_identity" "current" {}

data "aws_iam_session_context" "ctx" {
  arn = data.aws_caller_identity.current.arn
}

data "aws_default_tags" "default" {}

data "aws_subnet_ids" "db_subnet" {
  vpc_id = var.outputs_vpc_vpc_id
  tags = {
    type = "db"
  }
}

# data "aws_iam_role" "backup_service" {
#   name = "AWSServiceRoleForBackup"
# }

# data "aws_iam_role" "rds_service" {
#   name = "AWSServiceRoleForRDS"
# }

#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------
locals {
  name_prefix = join(".", [module.label.tags["Product"], module.label.tags["Environment"]])
  db_scaling = {
    dev = {
      rds_db_scaling_min_capacity = 2
      rds_db_scaling_max_capacity = 2
    }
    usp-dev = {
      rds_db_scaling_min_capacity = 2
      rds_db_scaling_max_capacity = 2
    }
    experimental = {
      rds_db_scaling_min_capacity = 2
      rds_db_scaling_max_capacity = 2
    }
    qa      = local.db_scaling_default
    staging = local.db_scaling_default
    prod    = local.db_scaling_default
  }
  db_scaling_default = {
    rds_db_scaling_min_capacity = 2
    rds_db_scaling_max_capacity = 4
  }
}

module "label" {
  source = "../../../../../../libft/generic-modules/null_label"

  # name   = module.label.id
  # tags   = module.label.tags
  # module.label.tags["Product"]

  # namespace  = "eg"
  # environment = ""
  # attributes = [data.aws_default_tags.default.tags["Product"]]
  name       = var.label["Product"]
  stage      = var.label["Environment"]
  delimiter  = "-"

  tags = {
    "Product"       = var.label["Product"],
    "Contact"       = var.label["Contact"],
    "Environment"   = var.label["Environment"],
    "Orchestration" = var.label["Orchestration"],
    "Region"        = var.label["Region"],
    "Layer"         = "38.quartz",
    "Jira"          = "MYT-1"
  }
}

#--------------------------------------------------------------
# Configs
#--------------------------------------------------------------
# module "shared_config_backup_vault" {

#   source = "../shared_config/backup"
# }
# module "shared_config_backup_acct" {

#   source = "../shared_config/accounts"
# }

module "shared_team_ips" {
  source = "../../../_shared_config/cidr_ranges/team"
}

#--------------------------------------------------------------
# ETC
#--------------------------------------------------------------
#module "framework_module_ver" {
#  source         = "../../../../libft/generic-modules/framework/module_ver"
#  module_name    = var.tag_orchestration
#  module_version = var.tf_framework_component_version
#}
