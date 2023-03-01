#--------------------------------------------------------------
# DB SG
#--------------------------------------------------------------
resource "aws_security_group" "sg" {
  name = join(
    ".",
    [
      module.label.tags["Product"],
      module.label.tags["Environment"],
      "db-quartz-sg",
      "sg",
    ],
  )
  description = "DB QUARTZ"
  vpc_id      = var.outputs_vpc_vpc_id
  tags        = module.label.tags
}

#--------------------------------------------------------------
# SG rules
#--------------------------------------------------------------
resource "aws_security_group_rule" "bastion" {
  type                      = "ingress"
  from_port                 = 5432
  to_port                   = 5432
  protocol                  = "tcp"
  security_group_id         = aws_security_group.sg.id
  source_security_group_id  = module.bastion_sg.sg_id
}