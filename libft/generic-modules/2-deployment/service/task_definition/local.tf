locals {
  common = {
    Product       = data.aws_default_tags.default.tags["Product"]
    Contact       = data.aws_default_tags.default.tags["Contact"]
    Environment   = data.aws_default_tags.default.tags["Environment"]
    Orchestration = data.aws_default_tags.default.tags["Orchestration"]
  }
  moduleName  = path.module
  common_tags = merge({ "moduleName" = local.moduleName })
  name_prefix = join("-", [local.common.Product, local.common.Environment])
}