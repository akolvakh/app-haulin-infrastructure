#--------------------------------------------------------------
# SES
#--------------------------------------------------------------
resource "random_id" "cognito_ex_id" {
  byte_length = 16
}

resource "random_id" "ses_role_id" {
  byte_length = 8
}

resource "random_id" "ses_pol_id" {
  byte_length = 8
}

data "aws_iam_policy_document" "cognito_ses" {
  statement {
    sid     = "AllowCognitoSendMails"
    actions = ["SES:SendEmail", "SES:SendRawEmail"]
    #TODO
    //I can not grant Cognito permission send email using SES from another region??? But Cognito consol lets me assignt hat. AAWS support suggested that.. WTH? trying dumb * resource
    resources = [module.cognito_app_ses.mail_from_arn]
    principals {
      identifiers = ["cognito-idp.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_ses_identity_policy" "cognito_ses" {
  identity = module.cognito_app_ses.mail_from_arn
  name     = "cognito_ses_${random_id.ses_pol_id.dec}"
  policy   = data.aws_iam_policy_document.cognito_ses.json
}

data "aws_iam_policy_document" "cognito_sms_send" {
  statement {
    sid     = "AllowCognitoSendSMS"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["cognito-idp.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [random_id.cognito_ex_id.id]
    }
  }
}

data "aws_iam_policy_document" "cognito_sms_send_polcy" {
  statement {
    sid = "AllowCognitoSendSMS"
    actions = [
      "sns:publish"
    ]
    #TODO
    // TBD narrow perms - what is SNS topic for cognito SMS output?
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role" "cognito_send_sms" {
  name               = "${module.label.id}_cognito_sms_send_${random_id.ses_role_id.dec}"
  assume_role_policy = data.aws_iam_policy_document.cognito_sms_send.json
  tags               = merge(module.label.tags, { "role" = "role_cognito_sms_send" })
}

resource "aws_iam_policy" "cognito_send_sms_policy" {
  name        = "${module.label.id}_cognito_sms_send_policy_${random_id.ses_pol_id.dec}"
  description = "Allow Cognito send SMS"
  policy      = data.aws_iam_policy_document.cognito_sms_send_polcy.json
}

resource "aws_iam_role_policy_attachment" "cognito_send_sms_policy_attachment" {
  role       = aws_iam_role.cognito_send_sms.name
  policy_arn = aws_iam_policy.cognito_send_sms_policy.arn
}
