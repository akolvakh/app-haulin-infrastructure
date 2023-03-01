locals {
  moduleName  = path.module
  common_tags = merge({ "moduleName" = local.moduleName })
  common = {
#    Product       = data.aws_default_tags.default.tags["Product"]
#    Contact       = data.aws_default_tags.default.tags["Contact"]
#    Environment   = data.aws_default_tags.default.tags["Environment"]
#    Orchestration = data.aws_default_tags.default.tags["Orchestration"]

    Product       = var.label["Product"]
    Contact       = var.label["Contact"]
    Environment   = var.label["Environment"]
    Orchestration = var.label["Orchestration"]
  }
  full_service_name = "${local.common.Product}-${local.common.Environment}-ecs-service-${var.service_name}"
}