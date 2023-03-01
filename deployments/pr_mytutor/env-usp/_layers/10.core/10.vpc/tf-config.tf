#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_default_tags" "default" {}

data "aws_availability_zones" "available" {
  state = "available"
  filter { //exclude localZones/WaveLength
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------
locals {
  // use 1 AZ in dev, qa, softdelete existing subnets
  is_single_az = contains(["dev", "qa"], var.label["Environment"]) ? true : false
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
    "Layer"         = "10.vpc",
    "Jira"          = "MYT-1"
  }
}

#--------------------------------------------------------------
# Configs
#--------------------------------------------------------------
module "shared_config_cidr_vpn" {
  source = "../../../_shared_config/cidr_ranges/vpn"
}

#--------------------------------------------------------------
# ETC
#--------------------------------------------------------------
#module "framework_module_ver" {
#  source         = "../../../../libft/generic-modules/framework/module_ver"
#  module_name    = var.tag_orchestration
#  module_version = var.tf_framework_component_version
#}
