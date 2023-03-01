resource "aws_iam_policy" "backup_events_write_event" {
  name        = substr(join("_", [local.name_prefix, var.backup_name_prefix, random_id.backup_id.dec]), 0, 128)
  description = "Backup SRC Account allowed trigger events in central Backup Dst account EventBus"
  policy      = data.aws_iam_policy_document.backup_events_write_event.json

}
data "aws_iam_policy_document" "backup_events_write_event" {
  //for_each = module.config_backup_vault.backup_event_bus_name
  statement {
    sid = "AllowSendEvents2BackupAcctEventBus"

    actions = [
      "events:PutEvents",
    ]

    resources = [
      "arn:aws:events:${var.aws_region_central_backup}:${var.backup_acct_id}:event-bus/${var.central_backup_acct_event_bus_name}",
    ]
  }

}
resource "aws_iam_role" "eventbus_write_role" {
  name = substr(join("_", [local.name_prefix, var.backup_name_prefix, random_id.backup_id.dec]), 0, 64)
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "events.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eventbus_write_role_pol_1" {
  role       = aws_iam_role.eventbus_write_role.name
  policy_arn = aws_iam_policy.backup_events_write_event.arn
}

resource "aws_cloudwatch_event_rule" "on_backup_copy_complete" {
  name        = join("_", [local.name_prefix, var.backup_name_prefix, "on_backup_complete"])
  description = "When backup job completed copy into Backup one, trigger event in Backup acct"

  event_pattern = <<EOF
{
            "source": ["aws.backup"],
            "detail-type": ["Copy Job State Change"],
            "detail": {
              "state": ["COMPLETED"],
              "resourceType": ["RDS", "Aurora"],
              "destinationBackupVaultArn": [{
                "prefix": "arn:aws:backup:${var.aws_region_central_backup}:${var.backup_acct_id}"
              }]
            }
          }
EOF
}
resource "aws_cloudwatch_event_target" "backup_acct_notify" {
  rule     = aws_cloudwatch_event_rule.on_backup_copy_complete.name
  role_arn = aws_iam_role.eventbus_write_role.arn
  arn      = "arn:aws:events:${var.aws_region_central_backup}:${var.backup_acct_id}:event-bus/${var.central_backup_acct_event_bus_name}"
}
