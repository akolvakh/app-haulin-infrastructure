##--------------------------------------------------------------
## Notes
##--------------------------------------------------------------
#/**
#* @TBD - have sec group per service. Only valuable after we materially progressed on our way to Microservices
#*
#*/
#
## import пингает user-mgt
## program-mgt пингает user-mgt, lesson-mgt
#
#
##--------------------------------------------------------------
## ECS SG
##--------------------------------------------------------------
#module "ecs_per_service_sg" {
#  # count  = length(module.shared_top_level_config_ecs.service_names)
#  count  = length(module.shared_top_level_config_ecs.service_names["${module.label.tags["Environment"]}"])
#  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
#  source = "../../../../libft/generic-modules/sg"
#  ingress = [
#    {
#      # cidr_blocks      = concat([local.vpn_vpc_eip_route], [local.vpn_vpc_cidr], "vpn_proxy" == module.shared_top_level_config_ecs.service_names[count.index] ? [for s in data.aws_subnet.public_lb : s.cidr_block] : [])
#      cidr_blocks      = []
#      description      = "Welcomed private ALB, public ALB, Admin ALB, product VPN, VPN Proxy NLB for vpn_proxy service"
#      from_port        = "8080"
#      to_port          = "8080"
#      ipv6_cidr_blocks = []
#      self             = true
#      prefix_list_ids  = []
#      protocol         = "tcp"
#      # security_groups  = [module.alb_public_app_sg.sg_id, module.ecs_api_gateway_service_sg.sg_id]
#      # security_groups  = [module.ecs_api_gateway_service_sg.sg_id]
#      security_groups  = [module.alb_public_app_sg.sg_id, module.api_gateway.sg_id]
#      # security_groups  = flatten(concat(tolist(module.ecs_per_service_sg.*.sg_id), [module.alb_public_app_sg.sg_id], [module.api_gateway.sg_id]))
#    }
#  ]
#  egress = [
#    {
#      cidr_blocks      = ["0.0.0.0/0"]
#      description      = "Should be conenct to AWS services over internet. TBD - use VPC endpoints and/or known AWS  APIip ranges"
#      from_port        = 0
#      to_port          = 0
#      ipv6_cidr_blocks = []   //unused
#      self             = true //need?
#      prefix_list_ids  = []
#      protocol         = -1
#      security_groups  = []
#    }
#  ]
#  tag_role           = "ecs_service_${element(module.shared_top_level_config_ecs.service_names["${module.label.tags["Environment"]}"], count.index)}_sg"
#  tag_description    = "ECS service ${element(module.shared_top_level_config_ecs.service_names["${module.label.tags["Environment"]}"], count.index)} sec group"
#  sg_additional_tags = module.label.tags
#}
#
## resource "aws_security_group_rule" "allow_https" {
##   count = var.environment == "prod" ? 0 : 1
##   depends_on = [
##     module.ecs_per_service_sg
##   ]
##   description       = "Allow access from the nix office"
##   type              = "ingress"
##   to_port           = 443
##   from_port         = 443
##   protocol          = "tcp"
##   cidr_blocks       = module.nix_ips.offices_external_cidrs
##   security_group_id = module.ecs_per_service_sg[index(module.top_level_config_ecs.service_names, "vpn_proxy")].sg_id
## }
