#------------------------------------------------------------------------------
# DB subnet group
#------------------------------------------------------------------------------
output "db_subnet_group_name" {
  description = "Subnet group name of the DB."
  value       = aws_db_subnet_group.main.name
}
