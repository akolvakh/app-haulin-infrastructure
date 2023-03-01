resource "aws_directory_service_directory" "main" {
  name     = var.name
  password = data.aws_secretsmanager_secret_version.ldap_password.secret_string
  size     = var.size

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnets
  }

  tags = var.tags
}