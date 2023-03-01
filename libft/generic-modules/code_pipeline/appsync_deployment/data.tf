resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

data "aws_caller_identity" "current" {}
data "aws_default_tags" "default" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "ssm" {
  statement {
    sid = "AllowResourceChangeManagmentTracking"

    actions = [
      "ssm:PutParameter",
      "ssm:AddTagsToResource",
      "ssm:GetParameters",
      "ssm:GetParameter",
      "ssm:DescribeParameters",
      "ssm:ListTagsForResource",
      "ssm:DeleteParameter"
    ]
    resources = ["arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }
}
