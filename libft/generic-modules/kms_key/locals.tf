locals {
  common = {
    Product     = data.aws_default_tags.default.tags["Product"]
    Environment = data.aws_default_tags.default.tags["Environment"]
  }
  common_tags = merge(var.key_additional_tags, { "moduleName" = "${path.module}", "Description" = var.description })
  name_prefix = join("_", [local.common.Product, local.common.Environment])
}
