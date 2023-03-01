resource "aws_cognito_user_pool_client" "client" {
  user_pool_id = aws_cognito_user_pool.pool.id

  allowed_oauth_flows = [
    "code",
    "implicit",
  ]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = [
    "aws.cognito.signin.user.admin",
    "email",
    "openid",
    "phone",
    "profile",
  ]
  /**
    ??? HOW a mobile APP can use THIS callback url? And if it is not used-  why Cognito does not enforce it??
    */
  //callback_urls = [
  //  "https://phoenixdev.auth.us-east-1.amazoncognito.com/login/cognito",
  //]
  callback_urls = var.callback_urls
  explicit_auth_flows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]

  logout_urls                   = var.logout_urls
  name                          = join(".", [var.tag_product, var.environment, "cognito_pool_app_client"])
  generate_secret               = false
  prevent_user_existence_errors = var.prevent_user_existence_errors
  read_attributes               = var.read_attributes

  # supported_identity_providers = local.supported_identity_providers
  write_attributes             = var.write_attributes
  /* to revisit tokens expiration*/
  access_token_validity  = var.token_expiration_access
  id_token_validity      = var.token_expiration_identity
  refresh_token_validity = var.token_expiration_refresh
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "minutes"
  }

  lifecycle {
    ignore_changes = [
      generate_secret,
    ]
  }
}

resource "aws_cognito_user_pool_client" "client_with_secret" {
  count        = var.phoenix_app_main_cognito ? 1 : 0
  user_pool_id = aws_cognito_user_pool.pool.id

  allowed_oauth_flows = [
    "code",
    "implicit",
  ]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = [
    "aws.cognito.signin.user.admin",
    "email",
    "openid",
    "phone",
    "profile",
  ]
  /**
    ??? HOW a mobile APP can use THIS callback url? And if it is not used-  why Cognito does not enforce it??
    */
  //callback_urls = [
  //  "https://phoenixdev.auth.us-east-1.amazoncognito.com/login/cognito",
  //]
  callback_urls = var.callback_urls
  explicit_auth_flows = [
    "ALLOW_CUSTOM_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_USER_SRP_AUTH",
  ]

  logout_urls                   = var.logout_urls
  name                          = join(".", [var.tag_product, var.environment, "cognito_pool_app_client_with_secret"])
  generate_secret               = true
  prevent_user_existence_errors = var.prevent_user_existence_errors
  read_attributes               = var.read_attributes

  # supported_identity_providers = local.supported_identity_providers
  write_attributes             = var.write_attributes
  /* to revisit tokens expiration*/
  access_token_validity  = var.token_expiration_access
  id_token_validity      = var.token_expiration_identity
  refresh_token_validity = var.token_expiration_refresh
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "minutes"
  }
}
