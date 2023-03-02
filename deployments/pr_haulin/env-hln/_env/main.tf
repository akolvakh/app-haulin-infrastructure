
################################################################################
################################################################################
# Variables
################################################################################
################################################################################

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "haulin"

    workspaces {
      name = "hln-dev"
    }
  }
}

provider "aws" {
  region = var.profile.general.aws_region
 }

variable "profile" {}
variable "doc_link_base" {
  type        = string
  description = "base url for wiki page holding documentation for the secret(s)"
  default     = ""
}
variable "first_run" {
  default = false
}

################################################################################
################################################################################
# Notes
################################################################################
################################################################################





/*
{
  variables
    first_run - we use for the first run of environment, when no services exist. We need it to create dummy ecr to deploy services with plug.
    
  first run - vpc
  second run - sg - lambda_clever (core)
  third run - other
}
*/





################################################################################
################################################################################
# 0.Data
################################################################################
################################################################################





data "aws_default_tags" "default" {}


  ################################################################################
  ################################################################################
  # 0.Locals
  ################################################################################
  ################################################################################





  locals {
    name_prefix = join(".", [module.label.tags["Product"], module.label.tags["Environment"]])

    locals_acm_cloudfront = {
      dev     = ""
      staging = ""
      prod    = ""
    }

    locals_acm_alb = {
      dev     = ""
      staging = ""
      prod    = ""
    }

    locals_cognito_schemas = {
      dev = [
        #                {
        #                  attribute_data_type          = "String"
        #                  developer_only_attribute     = false
        #                  mutable                      = true
        #                  name                         = "analytics_attributes"
        #                  required                     = false
        #                  string_attribute_constraints = {
        #                    max_length = "2048"
        #                    min_length = "1"
        #                  }
        #                },
      ]
      staging = [
      ]
      prod = []
    }

    locals_cloudfront_alias = {
      dev     = ["hln.dev.haulindev.com"]
      staging = []
      prod    = []
    }

    locals_acm_cloudfront_name = {
      dev     = "hln.dev.haulindev.com"
      staging = ""
      prod    = ""
    }

    locals_acm_alb_name = {
      dev     = "${module.label.tags["Product"]}.api.${module.label.tags["Environment"]}.haulin.com"
      staging = "${module.label.tags["Product"]}.api.${module.label.tags["Environment"]}.haulin.com"
      prod    = ""
    }
  }


  ################################################################################
  ################################################################################
  # 0.Configs
  ################################################################################
  ################################################################################





  ################################################################################
  ################################################################################
  # 0.ETC
  ################################################################################
  ################################################################################





  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "label" {
    source = "../../../../libft/generic-modules/null_label"

    # name   = module.label.id
    # tags   = module.label.tags
    # module.label.tags["Product"]

    # namespace  = "eg"
    # environment = ""
    # attributes = [data.aws_default_tags.default.tags["Product"]]
    name      = var.profile.general.product
    stage     = var.profile.general.environment
    delimiter = "_"
    tags      = {
      "Product"       = var.profile.general.product,
      "Contact"       = var.profile.general.contact,
      "Environment"   = var.profile.general.environment,
      "Orchestration" = var.profile.general.tag_orchestration,
      "Region"        = var.profile.general.aws_region
      "Layer"         = "hln-env",
      "Jira"          = "CD-34"
    }
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "framework_module_ver" {
    source         = "../../../../libft/generic-modules/framework/module_ver"
    module_name    = var.profile.general.tag_orchestration
    module_version = var.profile.general.tf_framework_component_version
    label          = module.label.tags
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------





  ################################################################################
  ################################################################################
  # 1.Meta Infra
  ################################################################################
  ################################################################################





  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  # module "gitlab" {}
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  # module "aws_organizations" {}
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  # module "aws_shared" {}
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  #3rd party providers
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------




  ################################################################################
  ################################################################################
  # 5. Non-Layer Services
  ################################################################################
  ################################################################################





  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "s3" {
    source                         = "../_layers/60.etc/56.s3"
    label                          = module.label.tags
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_s3"
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "secrets" {
    source                         = "../_layers/60.etc/20.secrets"
    label                          = module.label.tags
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_secrets"
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "dns" {
    source                         = "../_layers/10.core/15.dns"
    label                          = module.label.tags
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_dns"
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "acm" {
    source                         = "../_layers/60.etc/17.acm"
    label                          = module.label.tags
    external_dns_domain            = var.profile.external_dns_domain
    acm_cloudfront                 = local.locals_acm_cloudfront_name[var.profile.general.environment]
    acm_loadbalancer               = local.locals_acm_alb_name[var.profile.general.environment]
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_acm"
  }
  output "acm_loadbalancer_arn" {
    value = module.acm.acm_loadbalancer_arn
  }
  output "acm_cloudfront_arn" {
    value = module.acm.acm_cloudfront_arn
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "static_ips" {
    source                         = "../_layers/10.core/20.static_ips"
    label                          = module.label.tags
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_static_ips"
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  # module "route53" {}
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  # module "workmail" {
  # support@book-nook-learning.com
  # no-reply@book-nook-learning.com
  #}
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  # module "ses" {}
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  #module "parameters" {
  #  source                            = "../20.parameters"
  #
  #  # general
  #  product                           = var.product
  #  tag_orchestration                 = var.tag_orchestration
  #  tf_framework_component_version    = "${var.tf_framework_component_version}_parameters"
  #  environment                       = var.environment
  #  spring_profiles_active            = var.spring_profiles_active
  #  smoketest_emails                  = var.smoketest_emails
  #  aws_region                        = var.aws_region
  #  external_dns_domain               = var.external_dns_domain
  #  contact                           = var.contact
  #}
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  #security
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------





  ################################################################################
  ################################################################################
  #10.Core
  ################################################################################
  ################################################################################




  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "vpc" {
    source                         = "../_layers/10.core/10.vpc"
    label                          = module.label.tags
    external_dns_domain            = var.profile.external_dns_domain
    vpc_cidr                       = var.profile.vpc_cidr
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_vpc"
  }
  output "vpc_id" {
    value = module.vpc.vpc_id
  }
  output "vpc_cidr" {
    value = module.vpc.vpc_cidr_block
  }
  output "vpc_dns" {
    value = module.vpc.r53_private_hosted_domain_zone_name
  }
  output "vpc_nat_eips_cidr" {
    value = module.vpc.vpc_nat_eips_cidr
  }
  output "vpc_private_subnets" {
    value = module.vpc.private_subnets
  }
  output "r53_private_zone_id" {
    value = module.vpc.r53_private_zone_id
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "sg" {
    source                         = "../_layers/10.core/20.sg"
    label                          = module.label.tags
    vpc_cidr                       = var.profile.vpc_cidr
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_sg"
    #connections
    outputs_vpc_vpc_cidr_block     = module.vpc.vpc_cidr_block
    outputs_vpc_vpc_nat_eips_cidr  = module.vpc.vpc_nat_eips_cidr
    outputs_vpc_vpc_id             = module.vpc.vpc_id
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "cache" {
    source                         = "../_layers/10.core/30.cache"
    label                          = module.label.tags
    vpc_cidr                       = var.profile.vpc_cidr
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_cache"
    #connections
    outputs_sg_sg_cache_id         = module.sg.sg_cache_id
    outputs_vpc_vpc_id             = module.vpc.vpc_id
  }
  output "elasticache" {
    value = module.cache.cache_entrypoint
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "db" {
    source                         = "../_layers/10.core/30.db"
    label                          = module.label.tags
    vpc_cidr                       = var.profile.vpc_cidr
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_db"
    #connections
    outputs_sg_sg_default_db_id    = [module.sg.sg_default_db_id]
    outputs_vpc_vpc_id             = module.vpc.vpc_id
  }
  output "db_main_entrypoint" {
    value = module.db.db_main_entrypoint
  }
  output "db_cluster_arn" {
    value = module.db.db_cluster_arn
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "bastion" {
    source                         = "../_layers/10.core/25.bastion"
    label                          = module.label.tags
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_bastion"
    #connections
    outputs_sg_sg_bastion_id       = module.sg.sg_bastion_id
    outputs_vpc_public_subnets     = module.vpc.public_subnets[0]
  }
  output "bastion_ip" {
    value = module.bastion.bastion_ip
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------





  ################################################################################
  ################################################################################
  #20.Auth
  ################################################################################
  ################################################################################




  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
#  module "lambda_cognito_post_authentication" {
#    source                         = "../_layers/20.auth/33.lambda_cognito_post_authentication"
#    label                          = module.label.tags
#    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_lambda_cognito_post_authentication"
#    #connections
#    outputs_sg_sg_rds_lambda_id    = module.sg.sg_rds_lambda_id
#    outputs_vpc_private_subnets    = module.vpc.private_subnets
#  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
#  module "lambda_cognito_pre_authentication" {
#    source                         = "../_layers/20.auth/33.lambda_cognito_pre_authentication"
#    label                          = module.label.tags
#    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_lambda_cognito_pre_authentication"
#    #connections
#    outputs_sg_sg_rds_lambda_id    = module.sg.sg_rds_lambda_id
#    outputs_vpc_private_subnets    = module.vpc.private_subnets
#  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
#  module "lambda_cognito_post_confirmation" {
#    source                         = "../_layers/20.auth/33.lambda_cognito_post_confirmation"
#    label                          = module.label.tags
#    market                         = module.label.tags["Product"]
#    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_lambda_cognito_post_confirmation"
#    #connections
#    outputs_sg_sg_rds_lambda_id    = module.sg.sg_rds_lambda_id
#    outputs_vpc_private_subnets    = module.vpc.private_subnets
#  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "cognito" {
    /*
  {
    #general description
    {
      when deploy cognito
      support+dev@book-nook-learning.com
      +dev or +staging or +prod == all direct to support@book-nook-learning.com
      so, no need to create support+ENV@book-nook-learning.com
      you just need to create WORKMAIL ORGANIZATION + USER -> support@book-nook-learning.com
      and after that login to mail and confirm cognito
      etc.
      support@book-nook-learning.com for all envs - shared resource to handle all emails

      support@book-nook-learning.com
      no-reply@book-nook-learning.com

    usp || uss || red == count 1 true - deploy from layers? generics? resources? sublayers?
    }
*/
    source                                                  = "../_layers/20.auth/35.cognito"
    label                                                   = module.label.tags
    external_dns_domain                                     = var.profile.external_dns_domain
    vpc_cidr                                                = var.profile.vpc_cidr
    profile                                                 = var.profile.cognito
    cognito_urls                                            = [
      "https://${module.label.tags["Product"]}-${module.label.tags["Environment"]}.auth.${module.label.tags["Region"]}.amazoncognito.com/login/cognito"
    ]
    cognito_invite_email_message                            = file("${path.module}/invitation_message.html")
    schemas                                                 = local.locals_cognito_schemas[var.profile.general.environment]
    tf_framework_component_version                          = "${var.profile.general.tf_framework_component_version}_cognito"
    #connections
#    outputs_lambda_lambda_post_authentication_arn           = module.lambda_cognito_post_authentication.arn
#    outputs_lambda_lambda_post_authentication_function_name = module.lambda_cognito_post_authentication.function_name
#    outputs_lambda_lambda_pre_authentication_arn            = module.lambda_cognito_pre_authentication.arn
#    outputs_lambda_lambda_pre_authentication_function_name  = module.lambda_cognito_pre_authentication.function_name
#    outputs_lambda_lambda_post_confirmation_arn             = module.lambda_cognito_post_confirmation.arn
#    outputs_lambda_lambda_post_confirmation_function_name   = module.lambda_cognito_post_confirmation.function_name
  }
  output "cognito_app_pool_id" {
    value = module.cognito.cognito_app_pool_id
  }
  output "cognito_app_client_id" {
    value = module.cognito.cognito_app_client_id
  }
  output "cognito_app_pool_arn" {
    value = module.cognito.cognito_app_pool_arn
  }
  output "cognito_app_pool_endpoint" {
    value = module.cognito.cognito_app_pool_endpoint
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------




  ################################################################################
  ################################################################################
  #30.Fe
  ################################################################################
  ################################################################################





  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "cloudfront" {
    source                         = "../_layers/30.fe/55.cloudfront_web"
    label                          = module.label.tags
    alias                          = local.locals_cloudfront_alias[var.profile.general.environment]
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_cloudfront_web"
    #connections
    outputs_vpc_vpc_nat_eips_cidr  = module.vpc.vpc_nat_eips_cidr
    outputs_acm_cloudfront_arn     = local.locals_acm_cloudfront[var.profile.general.environment] != "" ? local.locals_acm_cloudfront[var.profile.general.environment] : module.acm.acm_cloudfront_arn
  }
  output "cloudfront_distribution_domain_name" {
    value = module.cloudfront.cloudfront_distribution_domain_name
  }
  output "cloudfront_distribution_hosted_zone_id" {
    value = module.cloudfront.cloudfront_distribution_hosted_zone_id
  }
  output "cloudfront_s3_name" {
    value = module.cloudfront.s3_name
  }
  output "cloudfront_s3_arn" {
    value = module.cloudfront.s3_arn
  }
  output "cloudfront_admin_fe_id" {
    value = module.cloudfront.cloudfront_admin_fe_id
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------





  ################################################################################
  ################################################################################
  #30.Be
  ################################################################################
  ################################################################################





  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "alb" {
    source                          = "../_layers/10.core/30.alb"
    label                           = module.label.tags
    vpc_cidr                        = var.profile.vpc_cidr
    tf_framework_component_version  = "${var.profile.general.tf_framework_component_version}_alb"
    #connections
    outputs_acm_loadbalancer_arn    = local.locals_acm_alb[var.profile.general.environment] != "" ? local.locals_acm_alb[var.profile.general.environment] : module.acm.acm_loadbalancer_arn
    outputs_sg_sg_alb_public_app_id = module.sg.sg_alb_public_app_id
    outputs_vpc_vpc_id              = module.vpc.vpc_id
  }
  output "alb_apl_private_hosted_zone_id" {
    value = module.alb.alb_apl_private_hosted_zone_id
  }
  output "alb_dns" {
    value = module.alb.alb_public_app_dns_name
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "service_discovery" {
    source                         = "../_layers/30.be/32.service_discovery"
    label                          = module.label.tags
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_service_discovery"
    #connections
    outputs_vpc_vpc_id             = module.vpc.vpc_id
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "ecs" {
    source                         = "../_layers/30.be/40.ecs"
    label                          = module.label.tags
    vpc_cidr                       = var.profile.vpc_cidr
    tf_framework_component_version = "${var.profile.general.tf_framework_component_version}_ecs"
  }
  output "ecs_cluster" {
    value = module.ecs.ecs_main_cluster_name
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------





  ################################################################################
  ################################################################################
  #40.Services
  ################################################################################
  ################################################################################




  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  module "ecs_service_be" {
    source                                                               = "../_layers/40.services/5000.ddd_ecs_service_be"
    first_run                                                            = var.first_run
    label                                                                = module.label.tags

    profile                                                              = var.profile.be

#    base_app_url                                                         = var.profile.base_app_url
#    external_dns_domain                                                  = var.profile.external_dns_domain
#    csrf_enabled                                                         = var.profile.csrf_enabled
#    server_secret                                                        = var.profile.server_secret
#    server_base_url                                                      = var.profile.server_base_url
#    server_domain                                                        = var.profile.server_domain
#    spring_datasource_driver_class_name                                  = var.profile.spring_datasource_driver_class_name
#    smoketest_emails                                                     = var.profile.smoketest_emails
#    spring_profiles_active                                               = var.profile.spring_profiles_active
    platform_name                                                        = var.profile.general.platform_name
#    db_schema                                                            = var.profile.db_schema
    tf_framework_component_version                                       = "${var.profile.general.tf_framework_component_version}_ddd_ecs_service_be"
    #connections
    #   outputs_alb_alb_public_app_backends_api_gateway                        = module.alb.alb_public_app_backends_api_gateway
    outputs_alb_listener_arn                                             = module.alb.aws_lb_listener_https
    outputs_cache_cache_entrypoint                                       = module.cache.cache_entrypoint
    outputs_cognito_cognito_app_pool_id                                  = module.cognito.cognito_app_pool_id
    outputs_db_db_main_entrypoint                                        = module.db.db_main_entrypoint
    outputs_ecs_ecs_main_cluster_arn                                     = module.ecs.ecs_main_cluster_arn
    outputs_ecs_ecs_main_cluster_name                                    = module.ecs.ecs_main_cluster_name
    outputs_s3_s3_bucket_name                                            = module.s3.s3_bucket_name
    outputs_service_discovery_service_discovery_private_dns_namespace_id = module.service_discovery.service_discovery_private_dns_namespace_id
    outputs_sg_sg_alb_public_app_id                                      = module.sg.sg_alb_public_app_id
    outputs_sg_sg_cache_id                                               = module.sg.sg_cache_id
    outputs_sg_sg_default_db_id                                          = module.sg.sg_default_db_id
    outputs_vpc_vpc_id                                                   = module.vpc.vpc_id
  }
  output "ecs_service_be_task_role" {
    value = module.ecs_service_be.ecs_service_task_role
  }
  output "ecs_service_be_task_execution_role" {
    value = module.ecs_service_be.ecs_service_task_execution_role
  }
  output "ecs_service_be_td" {
    value = module.ecs_service_be.ecs_service_td
  }
  output "ecs_service_be_ecr" {
    value = module.ecs_service_be.ecs_service_ecr
  }
  output "ecs_service_be_service_name" {
    value = module.ecs_service_be.ecs_service_service_name
  }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------


  ################################################################################
  ################################################################################
  #50.CiCd
  ################################################################################
  ################################################################################







  ################################################################################
  ################################################################################
  # 60.Etc
  ################################################################################
  ################################################################################




  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  # module "private_dns" {
  /*
  {
    #general description
    {
      how to use it?
      -step 1
      -step 2
      -step 3
    }
    #dependencies Structure
    {

      ├── aws_msk_cluster
      │   ├── aws_vpc
      │   │   ├── aws_availability_zones
      │   │   ├── aws_subnet.1
      │   │   ├── aws_subnet.2
      │   │   ├── aws_subnet.3
      │   │   ├── aws_subnet.4
      │   ├── aws_security_group
      │   ├── aws_kms_key
      │   ├── aws_cloudwatch_log_group
      │   ├── aws_s3_bucket
      │   │   ├── aws_s3_bucket_acl
      │   └──|
      └──|
    }
  }
*/
  #   source                                                                 = "../_layers/60.etc/100.private_dns"
  #   label                                                                  = module.label.tags
  #   external_dns_domain                                                    = var.external_dns_domain
  #   tf_framework_component_version                                         = "${var.tf_framework_component_version}_private_dns"
  #   #connections
  #   outputs_alb_alb_public_dns_name                                        = module.alb.alb_public_app_dns_name
  #   outputs_alb_alb_apl_private_hosted_zone_id                             = module.alb.alb_apl_private_hosted_zone_id
  #   outputs_vpc_r53_private_zone_id                                        = module.vpc.r53_private_zone_id
  #   outputs_cloudfront_hosted_zone                                         = module.cloudfront.cloudfront_distribution_hosted_zone_id
  #   outputs_cloudfront_domain_name                                         = module.cloudfront.cloudfront_distribution_domain_name
  # }
  # output "private_dns" {
  #   value = module.private_dns.
  # }
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  # #module "monitoring" {}
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------
  #module "openvpn_marketplace" {
  ##need to accept terms in marketplace
  #source                          = "../_layers/60.etc/101.openvpn_marketplace"
  #label                           = module.label.tags
  #tf_framework_component_version  = "${var.profile.general.tf_framework_component_version}_etc_openvpn_marketplace"
  ##connections
  #vpc_id                          = module.vpc.vpc_id
  #public_subnet_ids               = module.vpc.public_subnets[0]
  #}
  #output "access_vpn_url" {
  #  value = module.openvpn_marketplace.access_vpn_url
  #}
  #--------------------------------------------------------------
  ################################################################
  #--------------------------------------------------------------