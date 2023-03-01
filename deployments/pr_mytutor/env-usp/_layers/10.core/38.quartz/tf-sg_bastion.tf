#--------------------------------------------------------------
# Bastion SG
#--------------------------------------------------------------
module "bastion_sg" {
  source = "../../../../../../libft/generic-modules/sg"
  vpc_id = var.outputs_vpc_vpc_id
  ingress = [
    {
      cidr_blocks      = flatten([module.shared_team_ips.offices_external_cidrs])
      description      = "Bastion ingress for QUARTZ"
      from_port        = 22
      to_port          = 22
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
    }
  ]
  egress = [
    {
      cidr_blocks      = [var.outputs_vpc_vpc_cidr_block]
      description      = "Bastion egress for QUARTZ"
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      protocol         = "ALL"
      security_groups  = []
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      protocol         = -1
      security_groups  = []
    }
  ]
  tag_role           = "bastion-quartz-sg"
  tag_description    = "Bastion Host for QUARTZ RDS"
  sg_additional_tags = module.label.tags
  label              = module.label.tags
}