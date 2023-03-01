#--------------------------------------------------------------
# DB SG
#--------------------------------------------------------------
#module "db_default_sg" {
#  source = "../../../../libft/generic-modules/sg"
#  vpc_id = var.outputs_vpc_vpc_id
#  ingress = [
#    {
#      cidr_blocks      = [local.vpn_vpc_cidr]
#      description      = "Allow connections all (for now) services to DB"
#      from_port        = 5432
#      to_port          = 5432
#      ipv6_cidr_blocks = []
#      self             = false
#      prefix_list_ids  = []
#      protocol         = "tcp"
#      security_groups  = flatten(concat([module.bastion_sg.sg_id], [module.rds_lambda_sg.sg_id]))
#    }
#  ]
#  egress             = []
#  tag_role           = "db-sg"
#  tag_description    = "DB welcomes main APP (micro)services and Admin App"
#  sg_additional_tags = module.label.tags
#}

resource "aws_security_group" "sg" {
  name = join(
    ".",
    [
      module.label.tags["Product"],
      module.label.tags["Environment"],
      "db-sg",
      "sg",
    ],
  )
  description = "DB welcomes main APP (micro)services and Admin App"
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

resource "aws_security_group_rule" "rds_lambda" {
  type                      = "ingress"
  from_port                 = 5432
  to_port                   = 5432
  protocol                  = "tcp"
  security_group_id         = aws_security_group.sg.id
  source_security_group_id  = module.rds_lambda_sg.sg_id
}