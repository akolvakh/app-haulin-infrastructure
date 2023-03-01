#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_default_tags" "default" {}

data "aws_caller_identity" "current" {}

#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------
locals {
  name_prefix = join("/", [module.label.tags["Product"], module.label.tags["Environment"]])
  role_name = "${module.label.id}-${var.lambda_name}"
  func_name = "${module.label.id}_${var.lambda_name}"
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
    "Layer"         = "33.lambda_cognito_post_confirmation",
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

resource "random_id" "policy" {
  byte_length = 8
}
