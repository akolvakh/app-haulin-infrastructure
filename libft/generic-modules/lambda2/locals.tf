

locals {
  module_version = "0.0.1"
  common = {
    Product       = data.aws_default_tags.default.tags["Product"]
    Contact       = data.aws_default_tags.default.tags["Contact"]
    Environment   = data.aws_default_tags.default.tags["Environment"]
    Orchestration = data.aws_default_tags.default.tags["Orchestration"]
    Description   = "Primary APP DB/Aurora cluster"
  }







  common_tags = {
    "moduleVersion" = "phoenix-infrastructure/generic-modules/lambda2:${local.module_version}"
  }
  func_name = join(
    "-",
    [
      local.common.Product,
      local.common.Environment,
      var.tag_role
    ],
  )
}

