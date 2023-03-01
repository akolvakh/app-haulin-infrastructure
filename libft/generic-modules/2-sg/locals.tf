locals {
  # Eventually, we should keep modules tagged in Github by version. Dont enforce any terraform code using thsi moduel to upgrade to it's atest vdrsion.
  # Prematurely for phoenix, given where we are now.

  module_version = "0.0.1"
  common = {
    Product       = data.aws_default_tags.default.tags["Product"]
    Contact       = data.aws_default_tags.default.tags["Contact"]
    Environment   = data.aws_default_tags.default.tags["Environment"]
    Orchestration = data.aws_default_tags.default.tags["Orchestration"]
  }
  common_tags = {
  }
}

