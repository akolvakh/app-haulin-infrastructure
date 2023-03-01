#------------------------------------------------------------------------------
# DB subnet group
#------------------------------------------------------------------------------
resource "aws_db_subnet_group" "main" {
  name        = "${var.db_subnet_group_name}-subnet-group"
  description = var.description
  subnet_ids  = var.subnet_ids
  tags        = var.tags
}
