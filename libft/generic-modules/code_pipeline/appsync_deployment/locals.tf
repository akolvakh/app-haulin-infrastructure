locals {
  common = {
    Product       = data.aws_default_tags.default.tags["Product"]
    Contact       = data.aws_default_tags.default.tags["Contact"]
    Environment   = data.aws_default_tags.default.tags["Environment"]
    Orchestration = data.aws_default_tags.default.tags["Orchestration"]
    Description   = "TBD"
  }
  common_tags = {}
  name_prefix = join("-", [local.common.Product, local.common.Environment, "role"])
}
