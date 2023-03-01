#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_default_tags" "default" {}

data "aws_subnet_ids" "cache_subnet" {
  vpc_id = var.outputs_vpc_vpc_id
  tags = {
    cache = "true"
  }
}

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
  delimiter  = "_"

  tags = {
    "Product"       = var.label["Product"],
    "Contact"       = var.label["Contact"],
    "Environment"   = var.label["Environment"],
    "Orchestration" = var.label["Orchestration"],
    "Region"        = var.label["Region"],
    "Layer"         = "30.cache",
    "Jira"          = "MYT-1"
  }
}

#--------------------------------------------------------------
# Configs
#--------------------------------------------------------------

#--------------------------------------------------------------
# ETC
#--------------------------------------------------------------
#module "framework_module_ver" {
#  source         = "../../../../libft/generic-modules/framework/module_ver"
#  module_name    = var.tag_orchestration
#  module_version = var.tf_framework_component_version
#}
