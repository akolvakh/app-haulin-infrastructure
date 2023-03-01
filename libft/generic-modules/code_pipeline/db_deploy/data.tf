data "aws_caller_identity" "current" {}
data "aws_default_tags" "default" {}
data "aws_subnet" "db_subnet" {
  for_each = var.db_subnet_ids
  id       = each.value
}
