#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_caller_identity" "kms" {}

data "aws_default_tags" "default" {}

#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------
locals {
  name_prefix = join(".", [module.label.tags["Product"], module.label.tags["Environment"]])
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
    "Layer"         = "35.ecr",
    "Jira"          = "MYT-1"
  }
}

#--------------------------------------------------------------
# Configs
#--------------------------------------------------------------
module "shared_ecs_services_config" {
  source = "../../../_shared_config/ecs_services"
}

module "shared_accounts_config" {
  source = "../../../_shared_config/accounts"
}

#--------------------------------------------------------------
# ETC
#--------------------------------------------------------------
#module "framework_module_ver" {
#  source         = "../../../../libft/generic-modules/framework/module_ver"
#  module_name    = var.tag_orchestration
#  module_version = var.tf_framework_component_version
#}
