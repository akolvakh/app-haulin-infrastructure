#--------------------------------------------------------------
#ALB public app sg
#--------------------------------------------------------------
module "alb_public_app_sg" {
  source = "../../../../../../libft/generic-modules/sg"
  vpc_id = var.outputs_vpc_vpc_id
  ingress = [
    {
#      cidr_blocks      = flatten([var.outputs_vpc_vpc_nat_eips_cidr])
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "HTTP public ALB - has to be wide opened bc AppSync! To add HTTPS ASAP"
      from_port        = "8080"
      to_port          = "8080"
      ipv6_cidr_blocks = []
      self             = true
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = "HTTP public ALB - has to be wide opened bc AppSync! To add HTTPS ASAP"
      from_port        = "443"
      to_port          = "443"
      ipv6_cidr_blocks = []
      self             = true
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
    },
    {
      cidr_blocks      = ["0.0.0.0/0"]
      description      = ""
      from_port        = "80"
      to_port          = "80"
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
      description      = "ALB initiates connections to backends only/Microservices subnets. Allow all VPC until we teach Fargate launch services in single AZ in DEV/QA. Individual Microservies control IN access per their SecGroup"
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = []
      self             = true
      prefix_list_ids  = []
      protocol         = "ALL"
      security_groups  = []
    }
  ]
  tag_role           = "public-lb"
  tag_description    = "Access from Internet for regular users. VPNonly in DEV/qa as also in prod pre launch period"
  sg_additional_tags = module.label.tags
  label              = module.label.tags
}

#--------------------------------------------------------------
# ALB admin web app
#--------------------------------------------------------------
# For phoenix phoenix-app  Admin web app
# module "alb_public_admin_sg" {
#   source = "../../../../libft/generic-modules/sg"
#   vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
#   ingress = [{
#     cidr_blocks      = flatten([data.terraform_remote_state.vpc.outputs.vpc_cidr_block, local.vpn_vpc_cidr, data.terraform_remote_state.vpc.outputs.vpc_nat_eips_cidr, var.appsync_ip_range]) // use VPNed range. 
#     description      = "HTTP public admin ALB opened only to VPNed range, any environment"
#     # from_port        = "443" //  @TBD - add HTTPS certificates. We enforce HTTPS for any internet communications unconditionally
#     # to_port          = "443" // 
#     # from_port        = "443"
#     # to_port          = "443"
#     from_port        = "8080"
#     to_port          = "8080"
#     ipv6_cidr_blocks = []
#     self             = false
#     prefix_list_ids  = []
#     protocol         = "tcp"
#     //TECHGEN-5442. temporarely let Admn Portal have two entry points, go via VPn Proxy to ALB for REST, not jst to AppSync
#     security_groups = []
#   }]

#   egress = [{ # egress  -for healthchecks only, only to services subnets
#     cidr_blocks      = [data.terraform_remote_state.vpc.outputs.vpc_cidr_block]
#     description      = "ALB initiates connections to backends only.Allow OUT to full VPC until we teach Fargate launch services in single AZ in DEV/QA envs. Individual microsefvices control IN access per their Sec Goups"
#     from_port        = 0 # changed from "-1" to "0" (under the hood have same effect, but terraform understand it better. With "-1" you will newer get "no changes to apply" from terraform)
#     to_port          = 0
#     ipv6_cidr_blocks = [] //unused
#     self             = false
#     prefix_list_ids  = []
#     protocol         = "ALL"
#     security_groups  = []

#   }]
#   tag_role           = "admin-lb"
#   tag_description    = "Access from Internet for Admin users. VPNonly in DEV/qa/prod"
#   sg_additional_tags = module.label.tags
# }

#--------------------------------------------------------------
# ALB internal sg
#--------------------------------------------------------------
# module "alb_internal_sg" {
#   source = "../../../../libft/generic-modules/sg"
#   vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
#   ingress = [{
#     cidr_blocks      = [data.terraform_remote_state.vpc.outputs.vpc_cidr_block, local.vpn_vpc_cidr]
#     description      = "Private ALB got to accept  connections from anything in the VPC leveraging microservices"
#     # from_port        = "443"
#     # to_port          = "443"
#     from_port        = "8080"
#     to_port          = "8080"
#     ipv6_cidr_blocks = []
#     self             = true
#     prefix_list_ids  = []
#     protocol         = "tcp"
#     security_groups  = []

#   }]

#   egress = [{
#     # connect to backends 
#     cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr_block]
#     description = "Private ALB got to connect to any microservice backend to proxy it. Allow OUT to all VPC, until we teach Fargate launch services in single AZ in DEV/QA. Individual Microserivces seg group ito control IN"
#     # TBD should be standard 443 port for all services
#     # allow all ports for now
#     from_port        = 0 # changed from "-1" to "0" (under the hood have same effect, but terraform understand it better. With "-1" you will newer get "no changes to apply" from terraform)
#     to_port          = 0
#     ipv6_cidr_blocks = []   //unused
#     self             = true //need?
#     prefix_list_ids  = []
#     protocol         = "ALL"
#     security_groups  = []

#   }]
#   tag_role           = "private-lb"
#   tag_description    = "Internal LB. VPC visibile only. To reach microservices. Never exposed to Internet"
#   sg_additional_tags = module.label.tags

# }
