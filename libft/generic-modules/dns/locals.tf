
locals {
  module_version = "0.0.1"

  common_tags = {
    Product         = var.tag_product
    Contact         = var.tag_contact
    Environment     = var.tag_environment
    Orchestration   = var.tag_orchestration
    "moduleVersion" = "phoenix-infrastructure/generic-modules/dns:${local.module_version}"
  }
}

