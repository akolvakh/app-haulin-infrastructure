#------------------------------------------------------------------------------
# Platform application
#------------------------------------------------------------------------------
resource "aws_sns_platform_application" "apns_application" {
  name                = var.name
  platform            = var.platform
  platform_credential = var.platform_credential
  platform_principal  = var.platform_principal
}
