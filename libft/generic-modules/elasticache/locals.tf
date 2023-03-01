locals {
  module_version = "0.0.1"
  # name_prefix    = join("-", [var.tag_product, var.tag_environment])
  # common_tags = {
  #   Product         = var.tag_product
  #   Contact         = replace(var.tag_contact, "<env>", var.tag_environment)
  #   Environment     = var.tag_environment
  #   Orchestration   = var.tag_orchestration
  #   "moduleVersion" = "phoenix-infrastructure/generic-modules/cache:tag=${local.module_version}"
  # }
}

