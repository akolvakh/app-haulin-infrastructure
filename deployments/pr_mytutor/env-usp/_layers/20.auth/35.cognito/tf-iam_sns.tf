resource "random_id" "sns_pol_id" {
  byte_length = 3
}

data "aws_iam_policy_document" "sns_log" {
  statement {
    sid       = "AllowSNSWriteSentLog"
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents", "logs:PutMetricFilter", "logs:PutRetentionPolicy"]
    resources = ["arn:aws:logs:${var.label["Region"]}:${data.aws_caller_identity.current.account_id}:log-group:sns/${var.label["Region"]}/*"]
  }
}

data "aws_iam_policy_document" "sns_role_assume" {
  statement {
    sid     = "AllowSNSServiceLogSentTexts"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "sns_log" {
  name               = substr("${module.label.id}-sns-log-${random_id.ses_role_id.dec}", 0, 64)
  assume_role_policy = data.aws_iam_policy_document.sns_role_assume.json
  tags               = merge(module.label.tags, { "role" = "sns_log" })
}

resource "aws_iam_policy" "sns_log" {
  name        = substr("${module.label.id}_sns_log_policy_${random_id.sns_pol_id.dec}", 0, 64)
  description = "Allow SNS log sent messages for audit trail and troubleshooting"
  policy      = data.aws_iam_policy_document.sns_log.json
  tags        = merge(module.label.tags, { "role" = "sns_log" })
}

resource "aws_iam_role_policy_attachment" "sns_log_policy_attachment" {
  role       = aws_iam_role.sns_log.name
  policy_arn = aws_iam_policy.sns_log.arn
}