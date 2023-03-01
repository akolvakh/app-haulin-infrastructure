
resource "random_id" "backup_id" {
  byte_length = 4
}

/**
* cross account and cross regional backup for RDS 
* currently AWS does not support both in one, when use AWS Backup tooling
* we backup into another acct, and than trigger lambda in anoter account to copy cross regional
*/
// IAM service role to be impersoanted by AWs Backup tooling 
resource "aws_iam_role" "backup2" {
  name               = substr(join("_", [local.name_prefix, "backup2_role", random_id.backup_id.dec]), 0, 64)
  tags               = merge(local.common_tags, { Description = "default backup role for AWS backup" })
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": ["sts:AssumeRole"],
      "Effect": "allow",
      "Principal": {
        "Service": ["backup.amazonaws.com"]
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "backup_pol_1" {
  role       = aws_iam_role.backup2.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}
resource "aws_backup_vault" "vault2" {
  name        = join("_", [local.name_prefix, "default_backup2", random_id.backup_id.dec])
  tags        = merge(local.common_tags, { Description = var.description })
  kms_key_arn = var.backup_vault_kms_key_arn
}
resource "aws_backup_vault_policy" "backup2" {
  backup_vault_name = aws_backup_vault.vault2.name
  policy            = data.aws_iam_policy_document.vault2_policy.json

}
data "aws_iam_policy_document" "vault2_policy" {
  override_json = var.backup_vault_policy_override_json
  statement {
    sid     = "AllowRestoreFromCentralBackupAcct"
    actions = ["backup:CopyIntoBackupVault"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.backup_acct_id}:root"]
    }
    resources = ["arn:aws:backup:${var.aws_region}:${data.aws_caller_identity.current.account_id}:backup-vault:${aws_backup_vault.vault2.name}"]

  }
}

resource "aws_backup_plan" "plan2" {
  name = substr(join("_", [local.name_prefix, var.backup_name_prefix, random_id.backup_id.dec]), 0, 50)
  tags = merge(local.common_tags, { Description = var.description })

  rule {
    completion_window        = 480
    recovery_point_tags      = {}
    rule_name                = "backups"
    schedule                 = var.backup_schedule
    start_window             = 380
    target_vault_name        = aws_backup_vault.vault2.name
    enable_continuous_backup = var.enable_rds_continuous_backup
    copy_action {
      destination_vault_arn = "arn:aws:backup:${var.aws_region_central_backup}:${var.backup_acct_id}:backup-vault:${var.central_backup_acct_destination_vault_name}"
      lifecycle {
        delete_after = var.backup_delete_after
      }
    }

    lifecycle {
      delete_after = var.backup_delete_after
    }
  }

}
resource "aws_backup_selection" "resources2" {
  iam_role_arn = aws_iam_role.backup2.arn
  name         = substr(join("_", [local.name_prefix, var.backup_name_prefix, random_id.backup_id.dec]), 0, 50)
  plan_id      = aws_backup_plan.plan2.id
  selection_tag {
    type  = "STRINGEQUALS"
    key   = "backup_type"
    value = var.backup_by_tag_value
  }
}

