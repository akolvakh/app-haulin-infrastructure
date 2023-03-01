# resource "aws_cognito_identity_provider" "saml" {
#   for_each = var.idp_list

#   user_pool_id  = aws_cognito_user_pool.pool.id
#   provider_name = each.value.provider_name
#   provider_type = "SAML"

#   provider_details = {
#     MetadataFile = var.metadata_xml[index([for k, v in var.idp_list : v], each.value)]
#     // AWS actually computes this value automatically from the MetadataFile,
#     // but if we don't specify it, terraform always thinks this resource has
#     // changed:
#     // https://github.com/terraform-providers/terraform-provider-aws/issues/4831
#     SSORedirectBindingURI = each.value.saml_metadata_sso_redirect_binding_uri
#   }

#   attribute_mapping = each.value.attribute_mapping
# }
