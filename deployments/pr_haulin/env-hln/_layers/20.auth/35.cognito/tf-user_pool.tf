#--------------------------------------------------------------
# Cognito
#--------------------------------------------------------------
module "cognito_app_user_pool" {
  source                                   = "../../../../../../libft/generic-modules/cognito2-2"
  environment                              = var.label["Environment"]
  name                                     = "${module.label.id}_app_cognito_pool"
  password_policy                          = {
    minimum_length                         = 12
    require_lowercase                      = true
    require_numbers                        = true
    require_symbols                        = true
    require_uppercase                      = true
    temporary_password_validity_days       = 90
  }
  allow_admin_create_user_only             = false
  mfa_configuration                        = "OPTIONAL"
  prevent_user_existence_errors            = "LEGACY"
  username_attributes                      = ["email"]
  auto_verified_attributes                 = ["email"] 
  software_token_mfa_configuration_enabled = true
  phoenix_app_main_cognito                 = true
  # TODO # app_main_cognito                         = true
  recovery_mechanisms                      = [{ "name" = "verified_email", "priority" = 1 }] //[{ "name" = "verified_email", "priority" = 1 }, { "name" = "verified_phone_number", "priority" = 2 }]
  email_configuration_source_arn           = module.cognito_app_ses.mail_from_arn
  email_configuratino_from_email           = "${var.profile.cogntio_ses_email_subject} <${var.profile.cognito_mail_from_domain}>"
  cognito_invite_email_message             = var.cognito_invite_email_message
  cognito_invite_email_subject             = var.profile.cognito_invite_email_subject
  
  lambda_config = {
    # create_auth_challenge          = "arn:aws:lambda:us-east-1:123456789012:function:create_auth_challenge"
    # custom_message                 = "arn:aws:lambda:us-east-1:123456789012:function:custom_message"
    # define_auth_challenge          = "arn:aws:lambda:us-east-1:123456789012:function:define_auth_challenge"
    # pre_sign_up                    = "arn:aws:lambda:us-east-1:123456789012:function:pre_sign_up"
    # pre_token_generation           = "arn:aws:lambda:us-east-1:123456789012:function:pre_token_generation"
    # user_migration                 = "arn:aws:lambda:us-east-1:123456789012:function:user_migration"
    # verify_auth_challenge_response = "arn:aws:lambda:us-east-1:123456789012:function:verify_auth_challenge_response"
#    post_confirmation                 = var.outputs_lambda_lambda_post_confirmation_arn
#    pre_authentication                = var.outputs_lambda_lambda_pre_authentication_arn
#    post_authentication               = var.outputs_lambda_lambda_post_authentication_arn
#    kms_key_id                        = aws_kms_key.cognito_custom_email_sender_lambda_key.arn
#    lambda_config_custom_email_sender = {
#        lambda_arn                      = var.outputs_lambda_lambda_custom_email_sender_arn
#        lambda_version                  = "V1_0"
#      }
  }
  
  token_expiration_access                  = 1
  token_expiration_identity                = 1
  token_expiration_refresh                 = 1
  callback_urls                            = var.cognito_urls
  logout_urls                              = var.cognito_urls
  
  allowed_oauth_flows                      = ["code", "implicit",]
  
  // ref https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-assign-domain.html
  // Cognito enforces a domain name. Prod one should not suggest to curious attacker, how DEV one may look
  domain                                   = "${var.label["Product"]}-${var.label["Environment"]}"
  #   idp_list     = local.idp_list
  #   metadata_xml = local.metadata_xml
  # kms_key_id                               = aws_kms_key.cognito_custom_email_sender_lambda_key.arn
  supported_identity_providers             = ["COGNITO"]
  cognito_additional_tags                  = module.label.tags
  read_attributes                          = [
    "custom:groups",
    "custom:role",
    "email_verified",
    "name",
    "birthdate",
    "email",
    "family_name",
    "given_name",
    "middle_name",
    "phone_number",
    "phone_number_verified",
    "custom:referral_url",
    "custom:userid",
    "custom:hash",
    "preferred_username",
    "custom:user_type",
    "custom:user_id",
    "custom:multi_role_user_id",
    "custom:given_name",
    "custom:family_name",
    "custom:preferred_username",
    "custom:analytics_attributes",
    "custom:ga_user_id"
  ]
  write_attributes                         = [
    "custom:groups",
    "custom:role",
    "name",
    "birthdate",
    "email",
    "family_name",
    "given_name",
    "middle_name",
    "phone_number",
    "custom:referral_url",
    "custom:userid",
    "custom:hash",
    "preferred_username",
    "custom:user_type",
    "custom:user_id",
    "custom:multi_role_user_id",
    "custom:given_name",
    "custom:family_name",
    "custom:preferred_username",
    "custom:analytics_attributes",
    "custom:ga_user_id"
  ]
  schemas                                  = var.schemas
  user_groups                              = [
    { name        = "tutor"
      description = "tutor"
    },
    { name        = "pupil"
      description = "pupil"
    },
    { name        = "admin"
      description = "admin"
    },
    { name        = "teacher"
      description = "teacher"
    }
  ]
}

#consumer
#shipper
#username
#email - optional
#phonenumber + password

#sqs

#redis - later

#s3

#cognito = notifications to email + phonenumber
#-phonenumber verif
#-email verif



#--------------------------------------------------------------
# SES
#--------------------------------------------------------------
#TODO # We send emails for registration email confirmation/password reset

module "cognito_app_ses" {
  source                   = "../../../../../../libft/generic-modules/ses"
  dns_external_zone_domain = var.profile.cognito_ses_domain //var.external_dns_domain //var.cognito_mail_from_domain //"peerprep.co" //"book-nook-learning.com"  //"peerprep.co" //var.external_dns_domain
  mail_from_domain         = "mail.${var.profile.cognito_ses_domain}"  //"mail.${var.external_dns_domain}" //"mail.book-nook-learning.com" //"mail.${var.external_dns_domain}" //"mail.peerprep.co"
  cogntio_ses_sender       = var.profile.cogntio_ses_sender
  environment              = var.label["Environment"]
  aws_region               = var.label["Region"]
}

#--------------------------------------------------------------
# Lambdas
#--------------------------------------------------------------
#TODO # Allow the app Cognito pool call the lambda

# resource "aws_lambda_permission" "cognito_presignup" {
#   statement_id  = "AllowExecutionFromCognito"
#   action        = "lambda:InvokeFunction"
#   function_name = data.terraform_remote_state.lambda.outputs.lambda_presignup_function_name
#   principal     = "cognito-idp.amazonaws.com"
#   source_arn    = module.cognito_app_user_pool.cognito_pool_arn
# }

# resource "aws_lambda_permission" "cognito_preauthorization" {
#   statement_id  = "AllowExecutionFromCognito"
#   action        = "lambda:InvokeFunction"
#   function_name = data.terraform_remote_state.lambda.outputs.lambda_preauthorization_function_name
#   principal     = "cognito-idp.amazonaws.com"
#   source_arn    = module.cognito_app_user_pool.cognito_pool_arn
# }

#resource "aws_lambda_permission" "cognito_post_confirmation" {
#   statement_id  = "AllowExecutionFromCognito"
#   action        = "lambda:InvokeFunction"
#   function_name = var.outputs_lambda_lambda_post_confirmation_function_name
#   principal     = "cognito-idp.amazonaws.com"
#   source_arn    = module.cognito_app_user_pool.cognito_pool_arn
# }

#resource "aws_lambda_permission" "cognito_post_authentication" {
#  statement_id  = "AllowExecutionFromCognito"
#  action        = "lambda:InvokeFunction"
#  function_name = var.outputs_lambda_lambda_post_authentication_function_name
#  principal     = "cognito-idp.amazonaws.com"
#  source_arn    = module.cognito_app_user_pool.cognito_pool_arn
#}

#resource "aws_lambda_permission" "cognito_pre_authentication" {
#  statement_id  = "AllowExecutionFromCognito"
#  action        = "lambda:InvokeFunction"
#  function_name = var.outputs_lambda_lambda_pre_authentication_function_name
#  principal     = "cognito-idp.amazonaws.com"
#  source_arn    = module.cognito_app_user_pool.cognito_pool_arn
#}

#resource "aws_lambda_permission" "cognito_custom_email_sender" {
#   statement_id  = "AllowExecutionFromCognito"
#   action        = "lambda:InvokeFunction"
#   function_name = var.outputs_lambda_lambda_custom_email_sender_function_name
#   principal     = "cognito-idp.amazonaws.com"
#   source_arn    = module.cognito_app_user_pool.cognito_pool_arn
#}


#resource "aws_kms_key" "cognito_custom_email_sender_lambda_key" {
#  description             = "KMS key for cognito custom sender lambda"
#  deletion_window_in_days = 10
#}
