data "aws_iam_policy_document" "base" {
  override_json = var.policy_override_json
  statement {
    sid = "AllowLocalAccountIAMManageAccess"
    //AWS by default does not let us use IAM for managing KMS key policy, but only by inline poliy attached to key itself
    principals {
      type = "AWS"
      //it means local admins Can use IAM to grant/deny access to this key. It does not mean only root can do that
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions = [
      "kms:*"
    ]
    // to keep AWS API happy. Star is meaningless here
    resources = [
      "*"
    ]
  }
  statement {
    sid = "AllowOrgAdminsManageKey"
    principals {
      type = "AWS"
      //it means local admins Can use IAM to grant/deny access to this key. It does not mean only root can do that
      identifiers = [
        "${data.aws_iam_session_context.ctx.issuer_arn}",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AWSControlTowerExecution",
      ]
    }
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:TagResource",
      "kms:UntagResource",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion",
    ]

    resources = [
      "*"
    ]
  }


}
