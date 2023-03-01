#------------------------------------------------------------------------------
# Route table association
#------------------------------------------------------------------------------
resource "aws_route_table_association" "rta" {
  count          = var.length
  subnet_id      = element(var.rta_subnet_id, count.index)
  route_table_id = var.rta_route_table_id
}
