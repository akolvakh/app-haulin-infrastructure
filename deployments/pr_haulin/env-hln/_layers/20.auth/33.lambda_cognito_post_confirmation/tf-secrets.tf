resource "aws_secretsmanager_secret" "this" {
  name                    = "/${local.name_prefix}/${var.lambda_name}"
  recovery_window_in_days = 0
  tags                    = module.label.tags
  description             = <<-EOT
      {
        "username":"root",
        "bootstrap_servers":"b-1.stagingstagingredmskc.bhjp1y.c25.kafka.us-east-1.amazonaws.com:9092,b-2.stagingstagingredmskc.bhjp1y.c25.kafka.us-east-1.amazonaws.com:9092",
        "users_topic":"USERS"
      }
    EOT
  lifecycle {
    ignore_changes = [
      id,
      arn
    ]
  }
}