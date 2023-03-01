#------------------------------------------------------------------------------
# Route table association
#------------------------------------------------------------------------------
output "rta_id" {
  description = "The ID of the association."
  value       = aws_route_table_association.rta.*.id
}
