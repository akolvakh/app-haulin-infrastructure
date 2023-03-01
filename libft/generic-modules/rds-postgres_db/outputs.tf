output "db_name" {
  value = postgresql_database.this.name
}

output "db_username" {
  value = postgresql_role.user.name
}

output "db_password" {
  value     = random_password.user.result
  sensitive = true
}

output "db_schema" {
  value = postgresql_schema.this.name
}

output "db_secret_arn" {
  value = aws_secretsmanager_secret_version.db_creds.arn
}