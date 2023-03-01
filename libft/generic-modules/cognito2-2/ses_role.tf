resource "random_id" "uniq" {
  byte_length = 8
}
resource "random_id" "cognito_ex_id" {
  byte_length = 16
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
    // TBD narrow perms - what is SNS topic for cognito SMS output?
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_role" "cognito_send_sms" {
  name               = "${var.tag_product}_${var.environment}_cognito_sms_send_${random_id.uniq.dec}"
  assume_role_policy = data.aws_iam_policy_document.cognito_sms_send.json
  tags               = merge(local.common_tags, { "role" = "role_cognito_sms_send" })
}

resource "aws_iam_policy" "cognito_send_sms_policy" {
  name        = "cognito-send-sms-${random_id.uniq.dec}"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.cognito_sms_send_polcy.json
}
resource "aws_iam_role_policy_attachment" "cognito_send_sms_policy_attachment" {
  role       = aws_iam_role.cognito_send_sms.name
  policy_arn = aws_iam_policy.cognito_send_sms_policy.arn
}
