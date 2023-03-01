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
      email_message = var.cognito_invite_email_message //"Your username is {username} and temporary password is {####}"
      email_subject = var.cognito_invite_email_subject //"Your temporary password"
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
  
  # lambda_config
  dynamic "lambda_config" {
    for_each = var.lambda_config == null || length(var.lambda_config) == 0 ? [] : [1]
    content {
      create_auth_challenge          = lookup(var.lambda_config, "create_auth_challenge", var.lambda_config_create_auth_challenge)
      custom_message                 = lookup(var.lambda_config, "custom_message", var.lambda_config_custom_message)
      define_auth_challenge          = lookup(var.lambda_config, "define_auth_challenge", var.lambda_config_define_auth_challenge)
      
      post_authentication            = lookup(var.lambda_config, "post_authentication", var.lambda_post_authentication_arn)
      post_confirmation              = lookup(var.lambda_config, "post_confirmation", var.lambda_postconfirmation_arn)
      pre_authentication             = lookup(var.lambda_config, "pre_authentication", var.lambda_preauthorization_arn)
      pre_sign_up                    = lookup(var.lambda_config, "pre_sign_up", var.lambda_presignup_arn)
      
      pre_token_generation           = lookup(var.lambda_config, "pre_token_generation", var.lambda_config_pre_token_generation)
      user_migration                 = lookup(var.lambda_config, "user_migration", var.lambda_config_user_migration)
      verify_auth_challenge_response = lookup(var.lambda_config, "verify_auth_challenge_response", var.lambda_config_verify_auth_challenge_response)
      kms_key_id                     = lookup(var.lambda_config, "kms_key_id", var.lambda_config_kms_key_id)
      
      dynamic "custom_email_sender" {
        for_each = lookup(var.lambda_config, "custom_email_sender", var.lambda_config_custom_email_sender) == {} ? [] : [1]
        content {
          lambda_arn     = lookup(lookup(var.lambda_config, "custom_email_sender", var.lambda_config_custom_email_sender), "lambda_arn", null)
          lambda_version = lookup(lookup(var.lambda_config, "custom_email_sender", var.lambda_config_custom_email_sender), "lambda_version", null)
        }
      }
      dynamic "custom_sms_sender" {
        for_each = lookup(var.lambda_config, "custom_sms_sender", var.lambda_config_custom_sms_sender) == {} ? [] : [1]
        content {
          lambda_arn     = lookup(lookup(var.lambda_config, "custom_sms_sender", var.lambda_config_custom_sms_sender), "lambda_arn", null)
          lambda_version = lookup(lookup(var.lambda_config, "custom_sms_sender", var.lambda_config_custom_sms_sender), "lambda_version", null)
        }
      }
    }
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
