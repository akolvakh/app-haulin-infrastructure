#--------------------------------------------------------------
# Notes
#--------------------------------------------------------------
/**
* @TBD - have sec group per service. Only valuable after we materially progressed on our way to Microservices
*
*/

# import пингает user-mgt
# program-mgt пингает user-mgt, lesson-mgt


#--------------------------------------------------------------
# ECS SG
#--------------------------------------------------------------
module "sg" {
  vpc_id = var.outputs_vpc_vpc_id
  source = "../../../../../../libft/generic-modules/sg"
  ingress = [
    {
      cidr_blocks      = []
      description      = "Welcomed private ALB, public ALB, Admin ALB, product VPN, VPN Proxy NLB for vpn_proxy service"
      from_port        = "8080"
      to_port          = "8080"
      ipv6_cidr_blocks = []
      self             = true
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = [var.outputs_sg_sg_alb_public_app_id, var.outputs_ecs_service_api_gateway_sg_id, var.outputs_sg_sg_ecs_user_id]
    }
  ]
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "Should be conenct to AWS services over internet. TBD - use VPC endpoints and/or known AWS  APIip ranges"
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = []
      self             = true
      prefix_list_ids  = []
      protocol         = -1
      security_groups  = []
    }
  ]
  tag_role           = "ecs_service_${var.service_name}_sg"
  tag_description    = "ECS service ${var.service_name} sec group"
  sg_additional_tags = module.label.tags
  label                          = module.label.tags
}

# resource "aws_security_group_rule" "allow_https" {
#   count = var.environment == "prod" ? 0 : 1
#   depends_on = [
#     module.ecs_per_service_sg
#   ]
#   description       = "Allow access from the nix office"
#   type              = "ingress"
#   to_port           = 443
#   from_port         = 443
#   protocol          = "tcp"
#   cidr_blocks       = module.nix_ips.offices_external_cidrs
#   security_group_id = module.ecs_per_service_sg[index(module.top_level_config_ecs.service_names, "vpn_proxy")].sg_id
# }

#--------------------------------------------------------------
# ECS SG
#--------------------------------------------------------------
resource "aws_security_group_rule" "db" {
  type                      = "ingress"
  from_port                 = 5432
  to_port                   = 5432
  protocol                  = "tcp"
  security_group_id         = var.outputs_sg_sg_default_db_id
  source_security_group_id  = module.sg.sg_id
}

resource "aws_security_group_rule" "cache" {
  type                      = "ingress"
  from_port                 = 6379
  to_port                   = 6379
  protocol                  = "tcp"
  security_group_id         = var.outputs_sg_sg_cache_id
  source_security_group_id  = module.sg.sg_id
}