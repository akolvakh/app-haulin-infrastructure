resource "aws_cognito_identity_pool" "admin_identity_pool" {
  identity_pool_name               = join(".", [var.label["Product"], var.label["Environment"], "admin_identity_pool"])
  allow_unauthenticated_identities = false
  allow_classic_flow               = false

  cognito_identity_providers {
    client_id               = module.cognito_app_user_pool.cognito_client_id
    provider_name           = "cognito-idp.${var.label["Region"]}.amazonaws.com/${module.cognito_app_user_pool.cognito_pool_id}"
  }
}

resource "aws_cognito_identity_pool_roles_attachment" "admin_identity_pool" {
  identity_pool_id = aws_cognito_identity_pool.admin_identity_pool.id

  roles = {
    "authenticated"   = aws_iam_role.cognito_admin_auth_role.arn,
    "unauthenticated" = aws_iam_role.cognito_admin_unauth_role.arn
  }
}