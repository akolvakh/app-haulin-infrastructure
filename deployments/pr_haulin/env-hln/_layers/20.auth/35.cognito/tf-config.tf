#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_default_tags" "default" {}

#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------
locals {
  name_prefix  = join(".", [module.label.tags["Product"], module.label.tags["Environment"]])
  # idp_list     = jsondecode(file(join("/", [path.module, "saml", "saml-${var.environment}.json"])))
  # metadata_xml = toset([for k, v in local.idp_list : file(join("/", [path.module, "saml", v.metadata_xml]))])
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
    "Layer"         = "35.cognito",
    "Jira"          = "MYT-1"
  }
}

#--------------------------------------------------------------
# Configs
#--------------------------------------------------------------
module "shared_external_dns" {
  source = "../../../_shared_config/external_dns/"
}

#--------------------------------------------------------------
# ETC
#--------------------------------------------------------------
#module "framework_module_ver" {
#  source         = "../../../../libft/generic-modules/framework/module_ver"
#  module_name    = var.tag_orchestration
#  module_version = var.tf_framework_component_version
#}
