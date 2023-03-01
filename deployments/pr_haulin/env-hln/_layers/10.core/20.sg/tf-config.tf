#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_subnet_ids" "public_lb" {
  vpc_id = var.outputs_vpc_vpc_id
  tags = {
    type = "public_loadbalancer"
  }
}

data "aws_subnet_ids" "private_lb" {
  vpc_id = var.outputs_vpc_vpc_id
  tags = {
    type = "private_loadbalancer"
  }
}

data "aws_subnet" "public_lb" {
  for_each = data.aws_subnet_ids.public_lb.ids
  id       = each.value
}

data "aws_subnet_ids" "service" {
  vpc_id = var.outputs_vpc_vpc_id
  tags = {
    type = "service"
  }
}

data "aws_subnet" "service" {
  for_each = data.aws_subnet_ids.service.ids
  id       = each.value
}

data "aws_default_tags" "default" {}

data "aws_route_tables" "rt_svc" {
  vpc_id = var.outputs_vpc_vpc_id
  tags = {
    type = "service"
  }
}

data "aws_route_tables" "rt_pub_lb" {
  vpc_id = var.outputs_vpc_vpc_id
  tags = {
    type = "public_loadbalancer"
  }
}

data "aws_route_tables" "rt_pvt_lb" {
  vpc_id = var.outputs_vpc_vpc_id
  tags = {
    type = "private_loadbalancer"
  }
}

#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------
locals {
  vpn_vpc_cidr                = module.shared_cidr_ranges_config.vpn_vpc_cidr["primary"]
  vpc_endpoints_aws_svc_names = ["ecr.dkr", "ecr.api", "ecs-agent", "ecs-telemetry", "ecs", "logs", "config"]
  vpn_vpc_eip                 = module.shared_cidr_ranges_config.vpn_vpc_eip["primary"]
  vpn_vpc_eip_route           = "${local.vpn_vpc_eip}/32" # route to a single eip
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
    "Layer"         = "20.sg",
    "Jira"          = "MYT-1"
  }
}

#--------------------------------------------------------------
# Configs
#--------------------------------------------------------------
module "shared_cidr_ranges_config" {
  source = "../../../_shared_config/cidr_ranges/vpn"
}

module "shared_top_level_config_ecs" {
  source = "../../../_shared_config/ecs_services"
}

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
