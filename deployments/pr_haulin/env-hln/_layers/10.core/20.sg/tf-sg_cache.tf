#--------------------------------------------------------------
# Cache SG
#--------------------------------------------------------------
#module "elasticache_sg" {
#  source = "../../../../../../libft/generic-modules/sg"
#  vpc_id = var.outputs_vpc_vpc_id
#  ingress = [
#    {
#      cidr_blocks      = [local.vpn_vpc_cidr]
#      description      = "Cache serves Microservices, Admin app."
#      from_port        = "6379"
#      to_port          = "6379"
#      ipv6_cidr_blocks = []
#      self             = true
#      prefix_list_ids  = []
#      protocol         = "tcp"
#      security_groups  = []
#    }
#  ]
#  egress             = []
#  tag_role           = "elasticache_sg"
#  tag_description    = "Elastic Cache Sec Group"
#  sg_additional_tags = module.label.tags
#  label              = module.label.tags
#}

resource "aws_security_group" "elasticache_sg" {
  name = join(
    ".",
    [
      module.label.tags["Product"],
      module.label.tags["Environment"],
      "elasticache_sg",
      "sg",
    ],
  )
  description = "DB welcomes main APP (micro)services and Admin App"
  vpc_id      = var.outputs_vpc_vpc_id
  tags        = module.label.tags
}
