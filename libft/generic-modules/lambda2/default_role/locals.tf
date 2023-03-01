
locals {
  common = {
    Product       = data.aws_default_tags.default.tags["Product"]
    Contact       = data.aws_default_tags.default.tags["Contact"]
    Environment   = data.aws_default_tags.default.tags["Environment"]
    Orchestration = data.aws_default_tags.default.tags["Orchestration"]

  }
  common_tags = {
    Description = var.tag_description
  }
  name_prefix = join("-", [local.common.Product, local.common.Environment, var.tag_role])
}

