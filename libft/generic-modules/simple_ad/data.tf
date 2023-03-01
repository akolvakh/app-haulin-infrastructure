data "aws_secretsmanager_secret" "ldap_password" {
  arn = var.password_arn
}

data "aws_secretsmanager_secret_version" "ldap_password" {
  secret_id = data.aws_secretsmanager_secret.ldap_password.id
}