#--------------------------------------------------------------
# LBs HTTP
#--------------------------------------------------------------
#TBD HTTPS
module "alb_public_app" {
  source              = "../../../../../../libft/generic-modules/alb"
  alb_internal_enable = false
  alb_subnets         = data.aws_subnet_ids.public_lb.ids
  alb_vpc_id          = var.outputs_vpc_vpc_id
  alb_security_groups = [var.outputs_sg_sg_alb_public_app_id]
  backends_api        = [
                          "api-gateway",
                          "lesson-management",
                          "import",
                          "message-bus",
                          "program-management",
                          "user",
                          "payment",
                          "tutor-onboarding-application",
                          "interview"
                        ]
  tag_role            = "public-lb"
  tag_description     = "LB for Unprivileged customers requests. Exposed to Internet. DEV/QA and PROD pre launch - only VPNed ip range"
  alb_additional_tags = module.label.tags
  certificate_arn     = var.outputs_acm_loadbalancer_arn
  label               = module.label.tags
}

# module "alb_private" {
#   source              = "../../../../libft/generic-modules/alb"
#   alb_internal_enable = true
#   alb_subnets         = data.aws_subnet_ids.private_lb.ids
#   alb_vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
#   alb_security_groups = [data.terraform_remote_state.sg.outputs.sg_alb_internal_id]
#   # backends_api        = ["early_access"]
#   backends_api        = []
#   tag_role            = "private-lb"
#   tag_description     = "Internal LB. VPC visibile only. To reach microservices. Never exposed to Internet"
#   alb_additional_tags = module.label.tags
#   certificate_arn     = data.terraform_remote_state.acm_private_certificate.outputs.local_cert_arn
# }

# module "alb_nlb_vpn_proxy" {
#   source              = "../../../../libft/generic-modules/nlb"
#   alb_subnets         = data.aws_subnet_ids.public_lb.ids
#   alb_public_ips      = data.terraform_remote_state.static_ips.outputs.env_entrypoint_static_ips_ids
#   alb_vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
#   certificate_arn     = var.public_certificate_arn
#   tag_role            = "vpn-proxy-nlb"
#   tag_description     = "Provides static internet routable ip for product split-vpn. Compensation for AWS lack of static IP for ALB/AppSync. Tp be used by ECS proxies pointing to public and admin lb only"
#   nlb_additional_tags = module.label.tags
# }