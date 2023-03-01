locals {
  # Eventually, we should keep modules tagged in Github by version. Dont enforce any terraform code using thsi moduel to upgrade to it's atest vdrsion.
  # Prematurely for phoenix, given where we are now.

  module_version = "0.0.1"
  common = {
    Product       = var.label["Product"]
    Contact       = var.label["Contact"]
    Environment   = var.label["Environment"]
    Orchestration = var.label["Orchestration"]
  }
  common_tags = {
  }
}

