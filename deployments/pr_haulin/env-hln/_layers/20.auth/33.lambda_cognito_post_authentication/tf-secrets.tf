resource "aws_secretsmanager_secret" "this" {
  name                    = "/${local.name_prefix}/${var.lambda_name}"
  recovery_window_in_days = 0
  tags                    = module.label.tags
  description             = <<-EOT
      {
        "userPoolId":"us-east-1_w97omrslQ",
        "username":"root",
        "password":"zQjbgXpPRtoyhshzcdI3",
        "engine":"postgres",
        "host":"dev-dev-red.cluster-cpewhy546lbt.us-east-1.rds.amazonaws.com",
        "port":5432,
        "dbClusterIdentifier":"phoenix-app-dev-new",
        "db":"dev"
      }
    EOT
  lifecycle {
    ignore_changes = [
      id,
      arn
    ]
  }
}