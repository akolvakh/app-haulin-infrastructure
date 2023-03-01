/**
* # intro
* - generic KMS key module.
* - wraps together CMK KMS key and KMS Alias (why AWS sepeated key per se and a friendly name for it into two separated resources?)
* - adds KMS access policy by default, allowing IAM usage for KMS and admin perms for org admins. Externable.
* # TODOS
* - multi regional keys/key replication support
*/

resource "aws_kms_alias" "alias" {
  name          = "alias/${var.key_name}"
  target_key_id = aws_kms_key.key.key_id
}

resource "aws_kms_key" "key" {

  bypass_policy_lockout_safety_check = var.bypass_policy_lockout_safety_check
  customer_master_key_spec           = var.customer_master_key_spec
  description                        = var.description
  enable_key_rotation                = var.enable_key_rotation
  key_usage                          = var.key_usage
  multi_region                       = var.multi_region
  tags                               = local.common_tags
  policy                             = data.aws_iam_policy_document.base.json
}

