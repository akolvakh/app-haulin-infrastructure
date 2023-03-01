#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_caller_identity" "current" {}

data "aws_default_tags" "default" {}

#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------
locals {}

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
    "Layer"         = "55.cloudfront_web",
    "Jira"          = "MYT-1"
  }
}

#--------------------------------------------------------------
# Configs
#--------------------------------------------------------------
module "shared_team_ips" {
  source = "../../../_shared_config/cidr_ranges/team/"
}


# 56.cloudfront_admin

#--------------------------------------------------------------
# ETC
#--------------------------------------------------------------
#module "framework_module_ver" {
#  source         = "../../../../libft/generic-modules/framework/module_ver"
#  module_name    = var.tag_orchestration
#  module_version = var.tf_framework_component_version
#}
