resource "aws_cognito_user_pool" "pool" {
  name = var.name

  dynamic "password_policy" {
    for_each = length(keys(var.password_policy)) == 0 ? [] : [true]
    content {
      minimum_length    = var.password_policy["minimum_length"]
      require_lowercase = var.password_policy["require_lowercase"]

      require_numbers = var.password_policy["require_numbers"]
      require_symbols = var.password_policy["require_symbols"]

      require_uppercase = var.password_policy["require_uppercase"]

      temporary_password_validity_days = var.password_policy["temporary_password_validity_days"]

    }
  }
  admin_create_user_config {
    allow_admin_create_user_only = var.allow_admin_create_user_only
    invite_message_template {
      email_message = "Your username is {username} and temporary password is {####}"
      email_subject = "Your temporary password"
      sms_message   = "Your username is {username} and temporary password is {####}"
    }
  }
  mfa_configuration   = var.mfa_configuration
  sms_authentication_message = "Your authentication code is {####}"
  username_attributes = var.username_attributes
  alias_attributes    = var.alias_attributes

  auto_verified_attributes = var.auto_verified_attributes
  software_token_mfa_configuration {
    enabled = var.software_token_mfa_configuration_enabled
  }

  dynamic "account_recovery_setting" {
    for_each = length(var.recovery_mechanisms) == 0 ? [] : [1]
    content {
      dynamic "recovery_mechanism" {
        for_each = var.recovery_mechanisms
        content {
          name     = lookup(recovery_mechanism.value, "name")
          priority = lookup(recovery_mechanism.value, "priority")
        }
      }
    }
  }
  email_configuration {
    reply_to_email_address = ""
    source_arn             = var.email_configuration_source_arn //module.cognito_app_ses.mail_from_arn
    email_sending_account  = var.email_sending_account
    from_email_address     = var.email_configuratino_from_email //module.cognito_app_ses.mail_from_email

  }
  sms_configuration {
    external_id    = random_id.cognito_ex_id.id
    sns_caller_arn = aws_iam_role.cognito_send_sms.arn
  }

  dynamic "schema" {
    for_each = var.schemas
    content {
      attribute_data_type      = schema.value["attribute_data_type"]
      developer_only_attribute = schema.value["developer_only_attribute"]
      mutable                  = schema.value["mutable"]
      name                     = schema.value["name"]
      required                 = schema.value["required"]

      dynamic "string_attribute_constraints" {
        for_each = [1]
        content {
          max_length = schema.value["string_attribute_constraints"]["max_length"]
          min_length = schema.value["string_attribute_constraints"]["min_length"]
        }
      }

    }
  }


  lambda_config {
    pre_sign_up             = var.lambda_presignup_arn
    pre_authentication      = var.lambda_preauthorization_arn
    post_confirmation       = var.lambda_postconfirmation_arn
    post_authentication     = var.lambda_post_authenticationn_arn
  }

  tags = merge(
    {
      "Name" = join(
        ".",
        [
          var.tag_product,
          var.environment,
          "cognito_client_mobile",
        ],
      )
      "Description" = "phoenix main APP Cognito main user  pool"
    },
    local.common_tags,
    var.cognito_additional_tags,
  )

}
resource "aws_cognito_user_pool_domain" "main" {
  domain       = var.domain
  user_pool_id = aws_cognito_user_pool.pool.id
}
