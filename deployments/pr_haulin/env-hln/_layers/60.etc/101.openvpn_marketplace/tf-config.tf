#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_default_tags" "default" {}

data "aws_caller_identity" "current" {}

#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------
locals {
  images = {
    us-east-1      = "ami-099aae505e404f737" //"ami-037ff6453f0855c46"
    eu-central-1   = "ami-0764964fdfe99bc31"
    ap-northeast-1 = "ami-04f47c2ec43830d77"
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
    "Layer"         = "101.openvpn_marketplace",
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
