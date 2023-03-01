#--------------------------------------------------------------
# Kafka SG
#--------------------------------------------------------------
module "rds_lambda_sg" {
  source = "../../../../../../libft/generic-modules/sg"
  vpc_id = var.outputs_vpc_vpc_id
  ingress = [
    {
      cidr_blocks      = [local.vpn_vpc_cidr]
      description      = "Allow connections lambda to db."
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = []
      self             = false
      prefix_list_ids  = []
      protocol         = -1
      security_groups  = []
#      security_groups  = flatten(concat(tolist(module.ecs_per_service_sg.*.sg_id)))
    }
  ]
  egress = [
    {
      cidr_blocks = [var.outputs_vpc_vpc_cidr_block, "0.0.0.0/0"]
      description = "To RDS."
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = []
      self             = true
      prefix_list_ids  = []
      protocol         = "ALL"
      security_groups  = []
    }
  ]
  tag_role           = "rds_lambda-sg"
  tag_description    = "Allow access from lambda to rds."
  sg_additional_tags = module.label.tags
  label              = module.label.tags
}