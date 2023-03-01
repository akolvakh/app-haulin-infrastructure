#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_subnet_ids" "services_subnets" {
  vpc_id = var.outputs_vpc_vpc_id
  tags = {
    type = "service"
  }
}

data "aws_caller_identity" "current" {}

data "aws_default_tags" "default" {}

#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------
locals {
  autoscaling = {
    experimental = {
      limits_task_cpu                = 1024
      limits_task_memory             = 2048
      autoscaling_desired_task_count = 1
      autoscaling_max_task_count     = 1
      autoscaling_min_task_count     = 1
      target_value_memory            = 90
      target_value_cpu               = 90
    }

    dev = {
      limits_task_cpu                = 1024
      limits_task_memory             = 2048
      autoscaling_desired_task_count = 2
      autoscaling_max_task_count     = 4
      autoscaling_min_task_count     = 1
      target_value_memory            = 90
      target_value_cpu               = 90

    }
    
    usp-dev = {
      limits_task_cpu                = 1024
      limits_task_memory             = 2048
      autoscaling_desired_task_count = 1
      autoscaling_max_task_count     = 1
      autoscaling_min_task_count     = 1
      target_value_memory            = 90
      target_value_cpu               = 90

    }

    qa = {
      limits_task_cpu                = 1024
      limits_task_memory             = 2048
      autoscaling_desired_task_count = 1
      autoscaling_max_task_count     = 1
      autoscaling_min_task_count     = 1
      target_value_memory            = 90
      target_value_cpu               = 90

    }

    staging = {
      limits_task_cpu                = 1024
      limits_task_memory             = 2048
      autoscaling_desired_task_count = 1
      autoscaling_max_task_count     = 1
      autoscaling_min_task_count     = 1
      target_value_memory            = 90
      target_value_cpu               = 90

    }
    prod = {
      limits_task_cpu                = 1024
      limits_task_memory             = 2048
      autoscaling_desired_task_count = 2
      autoscaling_max_task_count     = 4
      autoscaling_min_task_count     = 2
      target_value_memory            = 90
      target_value_cpu               = 90
    }
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
  delimiter  = "_"

  tags = {
    "Product"       = var.label["Product"],
    "Contact"       = var.label["Contact"],
    "Environment"   = var.label["Environment"],
    "Orchestration" = var.label["Orchestration"],
    "Region"        = var.label["Region"],
    "Layer"         = "5000.ddd_ecs_service_lesson_management",
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
