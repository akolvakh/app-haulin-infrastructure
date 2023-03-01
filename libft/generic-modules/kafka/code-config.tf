#--------------------------------------------------------------
# Data
#--------------------------------------------------------------
data "aws_caller_identity" "kms" {}

data "aws_default_tags" "default" {}

#--------------------------------------------------------------
# Locals
#--------------------------------------------------------------
locals {
  # kms_master_key_arn  = var.bucket_kms_generated ? aws_kms_key.kms-key.arn : var.bucket_kms_master_key_arn
  kms_master_key_arn = aws_kms_key.kms_key.arn
  # kms_enabled         = var.kms_enabled || var.bucket_kms_generated ? true : false
  kms_enabled = var.kms_enabled ? true : false
  common = {
    Product       = data.aws_default_tags.default.tags["Product"]
    Contact       = data.aws_default_tags.default.tags["Contact"]
    Environment   = data.aws_default_tags.default.tags["Environment"]
    Orchestration = data.aws_default_tags.default.tags["Orchestration"]
  }
  common_tags = {
    Description = "Repository with infrastructure code for Lambdas. See ticket - 5078."
  }
}

#--------------------------------------------------------------
# Configs
#--------------------------------------------------------------

#--------------------------------------------------------------
# ETC
#--------------------------------------------------------------
module "framework_module_ver" {
  source         = "../../../generic-modules/framework/module_ver"
  module_name    = var.tag_orchestration
  module_version = var.tf_framework_component_version
}
