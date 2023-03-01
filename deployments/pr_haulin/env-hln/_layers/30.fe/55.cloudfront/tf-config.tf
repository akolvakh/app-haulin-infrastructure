#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_default_tags" "default" {}

data "aws_caller_identity" "current" {}

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
  name       = var.product
  stage      = var.environment
  delimiter  = "-"

  tags = {
    "Product"       = var.product,
    "Contact"       = var.contact,
    "Environment"   = var.environment,
    "Orchestration" = var.tag_orchestration,
    "Layer"         = "55.cloudfront",
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
