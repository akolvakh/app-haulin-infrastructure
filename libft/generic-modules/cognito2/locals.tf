
locals {
  common_tags = {
    Product       = var.tag_product
    Contact       = replace(var.tag_contact, "<env>", var.environment)
    Environment   = var.environment
    Orchestration = var.tag_orchestration
  }
  name_prefix                  = join(".", [var.tag_product, var.environment])
  # supported_identity_providers = concat([for k, v in aws_cognito_identity_provider.saml : v.provider_name], ["COGNITO"])
}

