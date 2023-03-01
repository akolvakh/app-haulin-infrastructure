// ################################################################################
// ################################################################################
// # Variables
// ################################################################################
// ################################################################################
// #--------------------------------------------------------------
// # General
// #--------------------------------------------------------------
// variable "aws_region" {}
// variable "environment" {}
// variable "product" {}
// variable "contact" {}
// variable "lesson_space_api" {}
// variable "cognito_urls" {}
// variable "tag_orchestration" {}
// variable "tf_framework_component_version" {
//   description = "GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework"
// }
// variable "allowed_origin_patterns" {}
// variable "csrf_enabled" {}
// variable "server_secret" {}
// variable "spring_datasource_driver_class_name" {}
// variable "platform_name" {}
// variable "spring_datasource_url" {}
// #--------------------------------------------------------------
// # Parameters
// #--------------------------------------------------------------
// variable "smoketest_emails" {
//   type = string
// }
// variable "parameter_additional_tags" {
//   type        = map(any)
//   description = "add here any additional tags you want assign to parameters created"
//   default     = {}
// }
// variable "external_dns_domain" {}
// variable "spring_profiles_active" {}
// variable "vpc_cidr" {}
// variable "server_base_url" {}
// variable "server_domain" {}
// variable "booknook_base_app_url" {}
// variable "booknook_app_url" {}
// variable "ses_aws_region" {}
// variable "sns_monthly_spend_limit" {}
// variable "phoenix_master_db_schema" {}

// #--------------------------------------------------------------
// # ETC
// #--------------------------------------------------------------
// variable "doc_link_base" {
//   type        = string
//   description = "base url for wiki page holding documentation for the secret(s)"
//   default     = "https://phoenix.atlassian.net/wiki/spaces/DOCUMENTAT/pages/471433238/Secrets+and+environment+specific+params"
// }
// variable "email_from_domain" {}
// variable "cognito_email_from_domain" {}
// variable "cognito_ses_domain" {}
// variable "first_run" {
//   default = false
// }
// variable "cogntio_ses_sender" {}
// variable "cogntio_ses_email_subject" {}
// variable "cognito_invite_email_subject" {}
// variable "clever_url" {}
// variable "cloudfront_alias" {}
// variable "tutorcommunity_booknook_callback_url" {}
// variable "ecs_payment_tutor_lesson_hour_cost" {}
// variable "ecs_interview_sparkhire_webhook_uuid" {}
// variable "ecs_interview_sparkhire_basic_auth_password" {}
// variable "ecs_interview_sparkhire_basic_auth_username" {}
// variable "ecs_interview_sparkhire_timezone" {}
// variable "ecs_interview_sparkhire_interview_expiration_days" {}
// variable "ecs_interview_sparkhire_question_set_uuid" {}
// variable "ecs_interview_sparkhire_basic_api_token" {}
// variable "ecs_interview_sparkhire_basic_api_url" {}
// variable "ecs_interview_sparkhire_basic_www_url" {}
// variable "ecs_interview_sparkhire_job_uuid" {}
// variable "ecs_import_kafka_producer_tx_prefix" {}
// variable "ecs_message_bus_kafka_lessons_topic_replicas" {}
// variable "ecs_message_bus_kafka_lessons_topic_partitions" {}
// variable "ecs_program_management_kafka_producer_tx_prefix" {}
// variable "ecs_user_kafka_producer_tx_prefix" {}
// variable "ecs_interview_kafka_interview_update_topic_replicas" {}
// variable "ecs_interview_kafka_interview_update_topic_partitions" {}
// variable "ecs_interview_kafka_interview_update_topic_name" {}
// variable "ecs_interview_db_schema" {}
// variable "ecs_toa_users_topic_name" {}
// variable "ecs_toa_db_schema" {}
// variable "ecs_toa_kafka_producer_tx_prefix" {}
// #--------------------------------------------------------------
// # Lesson-mgt
// #--------------------------------------------------------------
// variable "ecs_lesson_management_kafka_producer_tx_prefix" {}
// variable "ecs_lesson_management_spring_kafka_topics_users" {}
// variable "ecs_lesson_management_spring_kafka_topics_lesson" {}
// variable "ecs_lesson_management_tutor_join_time_minutes" {}
// #--------------------------------------------------------------
// # PAYMENT
// #--------------------------------------------------------------
// variable "ecs_payment_wm_url" {}
// variable "ecs_payment_wm_sign_up_url" {}
// variable "ecs_payment_wm_sign_in_url" {}
// variable "ecs_payment_wm_relay_id" {}
// variable "ecs_payment_wm_relay_access_token" {}
// variable "ecs_payment_wm_add_update_action" {}
// variable "ecs_payment_wm_rule_meta_group" {}
// variable "ecs_payment_wm_delete_action" {}
// ################################################################################
// ################################################################################
// # Notes
// ################################################################################
// ################################################################################





// /*
// {
//   variables
//     first_run - we use for the first run of environment, when no services exist. We need it to create dummy ecr to deploy services with plug.
    
//   first run - vpc
//   second run - sg - lambda_clever (core)
//   third run - other
// }
// */





// ################################################################################
// ################################################################################
// # 0.Data
// ################################################################################
// ################################################################################





// data "aws_default_tags" "default" {
// #resources
// /*
// {
//   data.aws_default_tags.default
// }
// */
// }





// ################################################################################
// ################################################################################
// # 0.Locals
// ################################################################################
// ################################################################################





// locals {
//   name_prefix = join(".", [module.label.tags["Product"], module.label.tags["Environment"]])
  
//   locals_acm_cloudfront = {
//     dev          = "arn:aws:acm:us-east-1:343423493973:certificate/a84db5dc-5bed-4eb5-87d5-a43f42c08f60"
//     staging      = ""
//     prod         = ""
//     # "arn:aws:acm:us-east-1:063581306853:certificate/4bb7df24-ead8-4fd1-b105-980e9e904c0c"
//     # "arn:aws:acm:us-east-1:374165421193:certificate/2d403110-bfdf-40de-b7d5-818f97a70969"
//     # "arn:aws:acm:us-east-1:063581306853:certificate/a0e7d36e-24bd-41ea-81c4-1bc79be33dac" 
//   }
  
//   locals_acm_alb = {
//     dev          = "arn:aws:acm:us-east-1:343423493973:certificate/11836707-4736-4290-a721-67f3e944b8d8"
//     staging      = ""
//     prod         = ""
//   }
  
//   locals_cognito_schemas = {
  
//     dev     = [
//                 {
//                   attribute_data_type          = "String"
//                   developer_only_attribute     = false
//                   mutable                      = true
//                   name                         = "analytics_attributes"
//                   required                     = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type          = "String"
//                   developer_only_attribute     = false
//                   mutable                      = true
//                   name                         = "ga_user_id"
//                   required                     = false
//                   string_attribute_constraints = {
//                     max_length = "36"
//                     min_length = "36"
//                   }
//                 },
//                 {
//                   attribute_data_type          = "String"
//                   developer_only_attribute     = false
//                   mutable                      = true
//                   name                         = "gaUserId"
//                   required                     = false
//                   string_attribute_constraints = {
//                     max_length = "32"
//                     min_length = "32"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "role"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "0"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "groups"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "hash"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "referral_url"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "userid"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "family_name"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "given_name"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "multi_role_user_id"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "user_id"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "32"
//                     min_length = "32"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "user_type"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "preferred_username"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//               ]
//     staging = [
//                 {
//                   attribute_data_type          = "String"
//                   developer_only_attribute     = false
//                   mutable                      = true
//                   name                         = "analytics_attributes"
//                   required                     = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "0"
//                   }
//                 },
//                 {
//                   attribute_data_type          = "String"
//                   developer_only_attribute     = false
//                   mutable                      = true
//                   name                         = "ga_user_id"
//                   required                     = false
//                   string_attribute_constraints = {
//                     max_length = "36"
//                     min_length = "36"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "role"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "0"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "groups"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "hash"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "referral_url"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "userid"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "family_name"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "given_name"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "multi_role_user_id"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "user_id"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "user_type"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "preferred_username"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//               ]
//     prod    = [
//                 {
//                   attribute_data_type          = "String"
//                   developer_only_attribute     = false
//                   mutable                      = true
//                   name                         = "analytics_attributes"
//                   required                     = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "0"
//                   }
//                 },
//                 {
//                   attribute_data_type          = "String"
//                   developer_only_attribute     = false
//                   mutable                      = true
//                   name                         = "ga_user_id"
//                   required                     = false
//                   string_attribute_constraints = {
//                     max_length = "36"
//                     min_length = "36"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "role"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "0"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "groups"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "hash"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "referral_url"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "userid"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "family_name"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "given_name"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "multi_role_user_id"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "user_id"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "user_type"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//                 {
//                   attribute_data_type      = "String"
//                   developer_only_attribute = false
//                   mutable                  = true
//                   name                     = "preferred_username"
//                   required                 = false
//                   string_attribute_constraints = {
//                     max_length = "2048"
//                     min_length = "1"
//                   }
//                 },
//               ]
//   }
  
//   locals_cloudfront_alias = {
//     dev     = [ "usp.dev.book-nook-learning.com" ]
//     staging = [  ]
//     prod    = [  ]
    
//    //[ "${module.label.tags["Product"]}.${module.label.tags["Environment"]}.${var.external_dns_domain}", "red.dev.book-nook-learning.com" ] 
//    //[var.cloudfront_alias] 
//    //["peerprep.co"] 
//    //"uss.prod.book-nook-learning.com", 
//    //["portal.mytutorlearning.co"] 
//    //[ var.alias, "mytutorlearning.co" ] 
//    //["peerprep.co", "uss.prod.book-nook-learning.com"] 
//    //"${module.label.tags["Product"]}.${module.label.tags["Environment"]}.${var.external_dns_domain}"
//   }
   
//   locals_acm_cloudfront_name = {
//     dev          = "usp.dev.book-nook-learning.com"
//     staging      = ""
//     prod         = ""
//     # "dev-red.dev.book-nook-learning.com" //var.external_dns_domain
//     # "${module.label.tags["Product"]}.${var.environment}.${var.external_dns_domain}"
//     # "${var.label["Product"]}.${var.label["Environment"]}.${var.external_dns_domain}"
//     # "${var.label["Product"]}.${var.label["Environment"]}.book-nook-learning.com"
//     # "staging-red.staging.book-nook-learning.com"
//     # "portal.mytutorlearning.co"
//     # "uss.staging.book-nook-learning.com"
//     # "${var.label["Product"]}.${var.label["Environment"]}.book-nook-learning.com"
//   }
   
//   locals_acm_alb_name = {
//     dev          = "${module.label.tags["Product"]}.api.${module.label.tags["Environment"]}.book-nook-learning.com" 
//     staging      = "${module.label.tags["Product"]}.api.${module.label.tags["Environment"]}.book-nook-learning.com" 
//     prod         = "${module.label.tags["Product"]}.api.${module.label.tags["Environment"]}.book-nook-learning.com"
//     # "${var.label["Product"]}.api.${var.label["Environment"]}.${var.external_dns_domain}"
//     # "${var.label["Product"]}.api.production.${var.external_dns_domain}"
//     # ["${var.label["Environment"]}.${var.external_dns_domain}"]
//   }
// }





// ################################################################################
// ################################################################################
// # 0.Configs
// ################################################################################
// ################################################################################





// ################################################################################
// ################################################################################
// # 0.ETC
// ################################################################################
// ################################################################################





// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "label" {
//   source = "../../../../libft/generic-modules/null_label"

//   # name   = module.label.id
//   # tags   = module.label.tags
//   # module.label.tags["Product"]

//   # namespace  = "eg"
//   # environment = ""
//   # attributes = [data.aws_default_tags.default.tags["Product"]]
//   name       = var.product
//   stage      = var.environment
//   delimiter  = "_"
//   tags       = {
//     "Product"       = var.product,
//     "Contact"       = var.contact,
//     "Environment"   = var.environment,
//     "Orchestration" = var.tag_orchestration,
//     "Region"        = var.aws_region
//     "Layer"         = "10.vpc",
//     "Jira"          = "MYT-1"
//   }
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "framework_module_ver" {

// #resources
// /*
// {
//   module.framework_module_ver.data.aws_default_tags.default
//   module.framework_module_ver.aws_ssm_parameter.cm_vcs_tag
// }
// */

// source         = "../../../../libft/generic-modules/framework/module_ver"
// module_name    = var.tag_orchestration
// module_version = var.tf_framework_component_version
// label                          = module.label.tags
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// /*
// {



// ################################################################################
// ################################################################################
// # 1.Meta Infra
// ################################################################################
// ################################################################################



// }
// */
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// # module "gitlab" {}
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// # module "aws_organizations" {}
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// # module "aws_shared" {}
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// #3rd party providers
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// /*
// {


// ################################################################################
// ################################################################################
// # 5. Non-Layer Services
// ################################################################################
// ################################################################################



// }
// */
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "s3" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.s3.module.this.data.aws_iam_policy_document.combined
//       module.s3.module.this.data.aws_iam_policy_document.deny_insecure_transport
//       module.s3.module.this.aws_s3_bucket.bucket
//       module.s3.module.this.aws_s3_bucket_policy.bucket_policy[0]
//       module.s3.module.this.aws_s3_bucket_public_access_block.bucket_access_block
//       module.s3.data.aws_caller_identity.current
//       module.s3.data.aws_default_tags.default
//       module.s3.random_id.this
//     }
//   }
// */
// source                                                                 = "../_layers/60.etc/56.s3"
// label                                                                  = module.label.tags
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_s3"
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "secrets" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.secrets.data.aws_default_tags.default
//       module.secrets.aws_secretsmanager_secret.booknook
//       module.secrets.aws_secretsmanager_secret.db
//       module.secrets.aws_secretsmanager_secret.rds_lambda
//       module.secrets.aws_secretsmanager_secret_version.booknook
//       module.secrets.aws_secretsmanager_secret_version.db
//     }
//   }
// */
// source                                                                  = "../_layers/60.etc/20.secrets"
// label                                                                   = module.label.tags
// tf_framework_component_version                                          = "${var.tf_framework_component_version}_secrets"
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "dns" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.dns.data.aws_default_tags.default
//     }
//   }
// */
// source                                                                  = "../_layers/10.core/15.dns"
// label                                                                   = module.label.tags
// tf_framework_component_version                                          = "${var.tf_framework_component_version}_dns"
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "acm" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.acm.data.aws_default_tags.default
//       module.acm.aws_acm_certificate.cloudfront
//       module.acm.aws_acm_certificate.loadbalancer
//     }
//   }
// */
// source                                                                  = "../_layers/60.etc/17.acm"
// label                                                                   = module.label.tags
// external_dns_domain                                                     = var.external_dns_domain
// acm_cloudfront                                                          = local.locals_acm_cloudfront_name[var.environment]
// acm_loadbalancer                                                        = local.locals_acm_alb_name[var.environment]
// tf_framework_component_version                                          = "${var.tf_framework_component_version}_acm"
// }
// output "acm_loadbalancer_arn" {
//   value = module.acm.acm_loadbalancer_arn
// }
// output "acm_cloudfront_arn" {
//   value = module.acm.acm_cloudfront_arn
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "static_ips" {
// /*
//   {
//     #todo
//     {
//       why we need it? and we need it for what?
//     }
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.static_ips.data.aws_default_tags.default
//       module.static_ips.aws_eip.nlb[0]
//       module.static_ips.aws_eip.nlb[1]
//     }
//   }
// */
// source                                                                 = "../_layers/10.core/20.static_ips"
// label                                                                  = module.label.tags
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_static_ips"
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// # module "route53" {}
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// # module "workmail" {
// # support@book-nook-learning.com
// # no-reply@book-nook-learning.com 
// #}
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// # module "ses" {}
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// #module "parameters" {
// #  source                            = "../20.parameters"
// #
// #  # general
// #  product                           = var.product
// #  tag_orchestration                 = var.tag_orchestration
// #  tf_framework_component_version    = "${var.tf_framework_component_version}_parameters"
// #  environment                       = var.environment
// #  spring_profiles_active            = var.spring_profiles_active
// #  smoketest_emails                  = var.smoketest_emails
// #  aws_region                        = var.aws_region
// #  external_dns_domain               = var.external_dns_domain
// #  contact                           = var.contact
// #}
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// #security
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// /*
// {



// ################################################################################
// ################################################################################
// #10.Core
// ################################################################################
// ################################################################################


// }
// */
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "vpc" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
    
//       # module.vpc.module.main_vpc.data.aws_caller_identity.current
//       # module.vpc.module.main_vpc.data.aws_default_tags.default
//       # module.vpc.module.main_vpc.aws_eip.nat[0]
//       # module.vpc.module.main_vpc.aws_eip.nat[1]
//       # module.vpc.module.main_vpc.aws_internet_gateway.gw
//       # module.vpc.module.main_vpc.aws_nat_gateway.nat[0]
//       # module.vpc.module.main_vpc.aws_nat_gateway.nat[1]
//       # module.vpc.module.main_vpc.aws_route.private_route[0]
//       # module.vpc.module.main_vpc.aws_route.private_route[1]
//       # module.vpc.module.main_vpc.aws_route.private_route[2]
//       # module.vpc.module.main_vpc.aws_route.private_route[3]
//       # module.vpc.module.main_vpc.aws_route.private_route[4]
//       # module.vpc.module.main_vpc.aws_route.private_route[5]
//       # module.vpc.module.main_vpc.aws_route.public_route[0]
//       # module.vpc.module.main_vpc.aws_route.public_route[1]
//       # module.vpc.module.main_vpc.aws_route53_zone.reverse_lookup_zone
//       # module.vpc.module.main_vpc.aws_route53_zone.vpc_private_zone
//       # module.vpc.module.main_vpc.aws_route_table.private_route_table[0]
//       # module.vpc.module.main_vpc.aws_route_table.private_route_table[1]
//       # module.vpc.module.main_vpc.aws_route_table.private_route_table[2]
//       # module.vpc.module.main_vpc.aws_route_table.private_route_table[3]
//       # module.vpc.module.main_vpc.aws_route_table.private_route_table[4]
//       # module.vpc.module.main_vpc.aws_route_table.private_route_table[5]
//       # module.vpc.module.main_vpc.aws_route_table.public_route_table[0]
//       # module.vpc.module.main_vpc.aws_route_table.public_route_table[1]
//       # module.vpc.module.main_vpc.aws_route_table_association.private_rt_assoc[0]
//       # module.vpc.module.main_vpc.aws_route_table_association.private_rt_assoc[1]
//       # module.vpc.module.main_vpc.aws_route_table_association.private_rt_assoc[2]
//       # module.vpc.module.main_vpc.aws_route_table_association.private_rt_assoc[3]
//       # module.vpc.module.main_vpc.aws_route_table_association.private_rt_assoc[4]
//       # module.vpc.module.main_vpc.aws_route_table_association.private_rt_assoc[5]
//       # module.vpc.module.main_vpc.aws_route_table_association.public_rt_assoc[0]
//       # module.vpc.module.main_vpc.aws_route_table_association.public_rt_assoc[1]
//       # module.vpc.module.main_vpc.aws_subnet.private_subnets[0]
//       # module.vpc.module.main_vpc.aws_subnet.private_subnets[1]
//       # module.vpc.module.main_vpc.aws_subnet.private_subnets[2]
//       # module.vpc.module.main_vpc.aws_subnet.private_subnets[3]
//       # module.vpc.module.main_vpc.aws_subnet.private_subnets[4]
//       # module.vpc.module.main_vpc.aws_subnet.private_subnets[5]
//       # module.vpc.module.main_vpc.aws_subnet.public_subnets[0]
//       # module.vpc.module.main_vpc.aws_subnet.public_subnets[1]
//       # module.vpc.module.main_vpc.aws_vpc.main
//       # module.vpc.data.aws_availability_zones.available
//       # module.vpc.data.aws_default_tags.default
//     }
//   }
// */
// source                                                                  = "../_layers/10.core/10.vpc"
// label                                                                   = module.label.tags
// external_dns_domain                                                     = var.external_dns_domain
// vpc_cidr                                                                = var.vpc_cidr
// tf_framework_component_version                                          = "${var.tf_framework_component_version}_vpc"
// }
// output "vpc_id" {
//   value = module.vpc.vpc_id
// }
// output "vpc_cidr" {
//   value = module.vpc.vpc_cidr_block
// }
// output "vpc_dns" {
//   value = module.vpc.r53_private_hosted_domain_zone_name
// }
// output "vpc_nat_eips_cidr" {
//   value = module.vpc.vpc_nat_eips_cidr
// }
// output "vpc_private_subnets" {
//   value = module.vpc.private_subnets
// }
// output "r53_private_zone_id" {
//   value = module.vpc.r53_private_zone_id
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "sg" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.sg.data.aws_default_tags.default
//       module.sg.data.aws_route_tables.rt_pub_lb
//       module.sg.data.aws_route_tables.rt_pvt_lb
//       module.sg.data.aws_route_tables.rt_svc
//       module.sg.data.aws_subnet.public_lb["subnet-073b57151f7d10b65"]
//       module.sg.data.aws_subnet.public_lb["subnet-0a2aef1ff683a3352"]
//       module.sg.data.aws_subnet.service["subnet-0a24e3913d1358123"]
//       module.sg.data.aws_subnet.service["subnet-0a37d6fbb9bb42eab"]
//       module.sg.data.aws_subnet_ids.private_lb
//       module.sg.data.aws_subnet_ids.public_lb
//       module.sg.data.aws_subnet_ids.service
//       module.sg.aws_security_group.elasticache_sg
//       module.sg.aws_security_group.sg
//       module.sg.aws_security_group_rule.bastion
//       module.sg.aws_security_group_rule.rds_lambda
//       module.sg.module.alb_public_app_sg.data.aws_caller_identity.current
//       module.sg.module.alb_public_app_sg.data.aws_default_tags.default
//       module.sg.module.alb_public_app_sg.aws_security_group.sg
//       module.sg.module.bastion_sg.data.aws_caller_identity.current
//       module.sg.module.bastion_sg.data.aws_default_tags.default
//       module.sg.module.bastion_sg.aws_security_group.sg
//       module.sg.module.kafka_sg.data.aws_caller_identity.current
//       module.sg.module.kafka_sg.data.aws_default_tags.default
//       module.sg.module.kafka_sg.aws_security_group.sg
//       module.sg.module.rds_lambda_sg.data.aws_caller_identity.current
//       module.sg.module.rds_lambda_sg.data.aws_default_tags.default
//       module.sg.module.rds_lambda_sg.aws_security_group.sg
//     }
//   }
// */
// source                                                                  = "../_layers/10.core/20.sg"
// label                                                                   = module.label.tags
// vpc_cidr                                                                = var.vpc_cidr
// tf_framework_component_version                                          = "${var.tf_framework_component_version}_sg"
// #connections
// outputs_vpc_vpc_cidr_block                                              = module.vpc.vpc_cidr_block
// outputs_vpc_vpc_nat_eips_cidr                                           = module.vpc.vpc_nat_eips_cidr
// outputs_vpc_vpc_id                                                      = module.vpc.vpc_id
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "cache" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.cache.data.aws_default_tags.default
//       module.cache.data.aws_subnet_ids.cache_subnet
//       module.cache.module.cache.aws_elasticache_replication_group.non_cluster[0]
//       module.cache.module.cache.aws_elasticache_subnet_group.default
//       module.cache.module.cache.random_id.cache
//     }
//   }
// */
// source                                                                 = "../_layers/10.core/30.cache"
// label                                                                  = module.label.tags
// vpc_cidr                                                               = var.vpc_cidr
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_cache"
// #connections
// outputs_sg_sg_cache_id                                                 = module.sg.sg_cache_id
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// output "elasticache" {
//   value = module.cache.cache_entrypoint
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "kafka" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.kafka.data.aws_caller_identity.kms
//       module.kafka.data.aws_default_tags.default
//       module.kafka.aws_cloudwatch_log_group.kafka_log_group
//       module.kafka.aws_kms_key.kms
//       module.kafka.aws_msk_cluster.msk-cluster
//       module.kafka.aws_msk_configuration.mks-cluster-custom-configuration
//       module.kafka.aws_s3_bucket.bucket
//       module.kafka.aws_s3_bucket_acl.bucket_acl
//       module.kafka.random_id.cdn
//     }
//   }
// */
// source                                                                 = "../_layers/10.core/30.kafka"
// label                                                                  = module.label.tags
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_kafka"
// #connections
// outputs_sg_sg_kafka_id                                                 = module.sg.sg_kafka_id
// outputs_vpc_public_subnets                                             = module.vpc.public_subnets
// }
// output "msk_cluster_arn" {
//   value = module.kafka.msk_cluster_arn
// }
// output "bootstrap_brokers" {
//   value = module.kafka.bootstrap_brokers
// }
// output "zookeeper_connect_string" {
//   value = module.kafka.zookeeper_connect_string
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "db" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.db.data.aws_caller_identity.current
//       module.db.data.aws_default_tags.default
//       module.db.data.aws_iam_session_context.ctx
//       module.db.data.aws_subnet_ids.db_subnet
//       module.db.aws_rds_cluster_parameter_group.rds_aurora
//       module.db.random_string.suffix
//       module.db.module.db_subnet_group.aws_db_subnet_group.main
//       module.db.module.rds_aurora.data.aws_availability_zones.available
//       module.db.module.rds_aurora.aws_rds_cluster.main
//       module.db.module.rds_aurora.random_id.snapshot_identifier
//       module.db.module.rds_aurora.random_password.master_password
//     }
//   }
// */
// source                                                                 = "../_layers/10.core/30.db"
// label                                                                  = module.label.tags
// vpc_cidr                                                               = var.vpc_cidr
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_db"
// #connections
// outputs_sg_sg_default_db_id                                            = [ module.sg.sg_default_db_id ] //"sg-0f2d36e734926ee70" - for prod
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// output "db_main_entrypoint" {
//   value = module.db.db_main_entrypoint
// }
// output "db_cluster_arn" {
//   value = module.db.db_cluster_arn
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "bastion" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.bastion.module.bastion.aws_eip.default
//       module.bastion.module.bastion.aws_eip_association.eip_assoc
//       module.bastion.module.bastion.aws_instance.default
//       module.bastion.module.bastion.aws_key_pair.ec2
//       module.bastion.module.bastion.local_file.ec2
//       module.bastion.module.bastion.tls_private_key.ec2
//       module.bastion.data.aws_default_tags.default
//     }
//   }
// */
// source                                                                 = "../_layers/10.core/25.bastion"
// label                                                                  = module.label.tags
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_bastion"
// #connections
// outputs_sg_sg_bastion_id                                               = module.sg.sg_bastion_id
// outputs_vpc_public_subnets                                             = module.vpc.public_subnets[0]
// }
// output "bastion_ip" {
//   value = module.bastion.bastion_ip
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "quartz" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.quartz.data.aws_caller_identity.current
//       module.quartz.data.aws_default_tags.default
//       module.quartz.data.aws_iam_session_context.ctx
//       module.quartz.data.aws_subnet_ids.db_subnet
//       module.quartz.aws_rds_cluster_parameter_group.rds_aurora
//       module.quartz.aws_security_group.sg
//       module.quartz.aws_security_group_rule.bastion
//       module.quartz.random_string.suffix
//       module.quartz.module.bastion.aws_eip.default
//       module.quartz.module.bastion.aws_eip_association.eip_assoc
//       module.quartz.module.bastion.aws_instance.default
//       module.quartz.module.bastion.aws_key_pair.ec2
//       module.quartz.module.bastion.local_file.ec2
//       module.quartz.module.bastion.tls_private_key.ec2
//       module.quartz.module.bastion_sg.data.aws_caller_identity.current
//       module.quartz.module.bastion_sg.data.aws_default_tags.default
//       module.quartz.module.bastion_sg.aws_security_group.sg
//       module.quartz.module.db_subnet_group.aws_db_subnet_group.main
//       module.quartz.module.rds_aurora.data.aws_availability_zones.available
//       module.quartz.module.rds_aurora.aws_rds_cluster.main
//       module.quartz.module.rds_aurora.random_id.snapshot_identifier
//       module.quartz.module.rds_aurora.random_password.master_password
//     }
//   }
// */
// source                                                                 = "../_layers/10.core/38.quartz"
// label                                                                  = module.label.tags
// vpc_cidr                                                               = var.vpc_cidr
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_quartz"
// #connections
// outputs_vpc_vpc_cidr_block                                             = module.vpc.vpc_cidr_block
// outputs_vpc_public_subnets                                             = module.vpc.public_subnets[0]
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "lambda_clever" {
// /*
//   {
//     #general description
//     {
//     how to use it?
//     -step 1
//     -step 2
//     -step 3
//     }
//     #dependencies Structure
//     {
    
//     ├── aws_msk_cluster
//     │   ├── aws_vpc
//     │   │   ├── aws_availability_zones
//     │   │   ├── aws_subnet.1
//     │   │   ├── aws_subnet.2
//     │   │   ├── aws_subnet.3
//     │   │   ├── aws_subnet.4
//     │   ├── aws_security_group
//     │   ├── aws_kms_key
//     │   ├── aws_cloudwatch_log_group
//     │   ├── aws_s3_bucket
//     │   │   ├── aws_s3_bucket_acl
//     │   └──|
//     └──|
//     }
//     #resources
//     {
//     module.lambda_clever.data.archive_file.lambda_layer_package
//     module.lambda_clever.data.aws_caller_identity.current
//     module.lambda_clever.data.aws_default_tags.default
//     module.lambda_clever.data.aws_iam_policy_document.policy
//     module.lambda_clever.data.aws_iam_policy_document.secrets_policy
//     module.lambda_clever.data.aws_iam_policy_document.trust_policy
//     module.lambda_clever.aws_iam_policy.policy
//     module.lambda_clever.aws_iam_policy.secrets_policy
//     module.lambda_clever.aws_iam_role.role
//     module.lambda_clever.aws_iam_role_policy_attachment.policy
//     module.lambda_clever.aws_iam_role_policy_attachment.policy_attachment
//     module.lambda_clever.aws_iam_role_policy_attachment.secret_policy_attachment
//     module.lambda_clever.aws_lambda_function_url.this
//     module.lambda_clever.aws_secretsmanager_secret.this
//     module.lambda_clever.random_id.policy
//     module.lambda_clever.module.lambda.data.aws_iam_policy.tracing[0]
//     module.lambda_clever.module.lambda.data.aws_iam_policy.vpc[0]
//     module.lambda_clever.module.lambda.data.aws_iam_policy_document.lambda_trust_policy
//     module.lambda_clever.module.lambda.aws_iam_policy.tracing[0]
//     module.lambda_clever.module.lambda.aws_iam_policy.vpc[0]
//     module.lambda_clever.module.lambda.aws_lambda_function.lambda
//     }
//   }
// */
// source                                                                  = "../_layers/10.core/40.lambdas/33.lambda_clever"
// label                                                                   = module.label.tags
// clever_url                                                              = var.clever_url //"https://uss-prod.auth.us-east-1.amazoncognito.com/oauth2/authorize?response_type=code&client_id=23jsa9lus4uq8ik2rfm9pjg6pm&redirect_uri=https%3A%2F%2Fportal.mytutorlearning.co%2Fauth%2Flogin&state=qweqw2131a123a1231212&identity_provider=Clever&scope=aws.cognito.signin.user.admin+openid+profile"
// tf_framework_component_version                                          = "${var.tf_framework_component_version}_lambda_clever"
// #connections
// outputs_sg_sg_rds_lambda_id                                             = module.sg.sg_rds_lambda_id
// outputs_vpc_private_subnets                                             = module.vpc.private_subnets
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// /*
// {


// ################################################################################
// ################################################################################
// #20.Auth
// ################################################################################
// ################################################################################


// }
// */
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "lambda_cognito_post_authentication" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.lambda_cognito_post_authentication.data.archive_file.lambda_layer_package
//       module.lambda_cognito_post_authentication.data.aws_caller_identity.current
//       module.lambda_cognito_post_authentication.data.aws_default_tags.default
//       module.lambda_cognito_post_authentication.data.aws_iam_policy_document.policy
//       module.lambda_cognito_post_authentication.data.aws_iam_policy_document.secrets_policy
//       module.lambda_cognito_post_authentication.data.aws_iam_policy_document.trust_policy
//       module.lambda_cognito_post_authentication.aws_iam_policy.policy
//       module.lambda_cognito_post_authentication.aws_iam_policy.secrets_policy
//       module.lambda_cognito_post_authentication.aws_iam_role.role
//       module.lambda_cognito_post_authentication.aws_iam_role_policy_attachment.policy
//       module.lambda_cognito_post_authentication.aws_iam_role_policy_attachment.policy_attachment
//       module.lambda_cognito_post_authentication.aws_iam_role_policy_attachment.secret_policy_attachment
//       module.lambda_cognito_post_authentication.aws_secretsmanager_secret.this
//       module.lambda_cognito_post_authentication.random_id.policy
//       module.lambda_cognito_post_authentication.module.lambda.data.aws_iam_policy.tracing[0]
//       module.lambda_cognito_post_authentication.module.lambda.data.aws_iam_policy.vpc[0]
//       module.lambda_cognito_post_authentication.module.lambda.data.aws_iam_policy_document.lambda_trust_policy
//       module.lambda_cognito_post_authentication.module.lambda.aws_iam_policy.tracing[0]
//       module.lambda_cognito_post_authentication.module.lambda.aws_iam_policy.vpc[0]
//       module.lambda_cognito_post_authentication.module.lambda.aws_lambda_function.lambda
//     }
//   }
// */
// source                                                                 = "../_layers/20.auth/33.lambda_cognito_post_authentication"
// label                                                                  = module.label.tags
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_lambda_cognito_post_authentication"
// #connections
// outputs_sg_sg_rds_lambda_id                                            = module.sg.sg_rds_lambda_id
// outputs_vpc_private_subnets                                            = module.vpc.private_subnets
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "lambda_cognito_pre_authentication" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.lambda_cognito_pre_authentication.data.archive_file.lambda_layer_package
//       module.lambda_cognito_pre_authentication.data.aws_caller_identity.current
//       module.lambda_cognito_pre_authentication.data.aws_default_tags.default
//       module.lambda_cognito_pre_authentication.data.aws_iam_policy_document.policy
//       module.lambda_cognito_pre_authentication.data.aws_iam_policy_document.secrets_policy
//       module.lambda_cognito_pre_authentication.data.aws_iam_policy_document.trust_policy
//       module.lambda_cognito_pre_authentication.aws_iam_policy.policy
//       module.lambda_cognito_pre_authentication.aws_iam_policy.secrets_policy
//       module.lambda_cognito_pre_authentication.aws_iam_role.role
//       module.lambda_cognito_pre_authentication.aws_iam_role_policy_attachment.policy
//       module.lambda_cognito_pre_authentication.aws_iam_role_policy_attachment.policy_attachment
//       module.lambda_cognito_pre_authentication.aws_iam_role_policy_attachment.secret_policy_attachment
//       module.lambda_cognito_pre_authentication.aws_secretsmanager_secret.this
//       module.lambda_cognito_pre_authentication.random_id.policy
//       module.lambda_cognito_pre_authentication.module.lambda.data.aws_iam_policy.tracing[0]
//       module.lambda_cognito_pre_authentication.module.lambda.data.aws_iam_policy.vpc[0]
//       module.lambda_cognito_pre_authentication.module.lambda.data.aws_iam_policy_document.lambda_trust_policy
//       module.lambda_cognito_pre_authentication.module.lambda.aws_iam_policy.tracing[0]
//       module.lambda_cognito_pre_authentication.module.lambda.aws_iam_policy.vpc[0]
//       module.lambda_cognito_pre_authentication.module.lambda.aws_lambda_function.lambda
//     }
//   }
// */
// source                                                                 = "../_layers/20.auth/33.lambda_cognito_pre_authentication"
// label                                                                  = module.label.tags
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_lambda_cognito_pre_authentication"
// #connections
// outputs_sg_sg_rds_lambda_id                                            = module.sg.sg_rds_lambda_id
// outputs_vpc_private_subnets                                            = module.vpc.private_subnets
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "lambda_cognito_post_confirmation" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.lambda_cognito_post_confirmation.data.archive_file.lambda_layer_package
//       module.lambda_cognito_post_confirmation.data.aws_caller_identity.current
//       module.lambda_cognito_post_confirmation.data.aws_default_tags.default
//       module.lambda_cognito_post_confirmation.data.aws_iam_policy_document.policy
//       module.lambda_cognito_post_confirmation.data.aws_iam_policy_document.secrets_policy
//       module.lambda_cognito_post_confirmation.data.aws_iam_policy_document.trust_policy
//       module.lambda_cognito_post_confirmation.aws_iam_policy.policy
//       module.lambda_cognito_post_confirmation.aws_iam_policy.secrets_policy
//       module.lambda_cognito_post_confirmation.aws_iam_role.role
//       module.lambda_cognito_post_confirmation.aws_iam_role_policy_attachment.policy
//       module.lambda_cognito_post_confirmation.aws_iam_role_policy_attachment.policy_attachment
//       module.lambda_cognito_post_confirmation.aws_iam_role_policy_attachment.secret_policy_attachment
//       module.lambda_cognito_post_confirmation.aws_secretsmanager_secret.this
//       module.lambda_cognito_post_confirmation.random_id.policy
//       module.lambda_cognito_post_confirmation.module.lambda.data.aws_iam_policy.tracing[0]
//       module.lambda_cognito_post_confirmation.module.lambda.data.aws_iam_policy.vpc[0]
//       module.lambda_cognito_post_confirmation.module.lambda.data.aws_iam_policy_document.lambda_trust_policy
//       module.lambda_cognito_post_confirmation.module.lambda.aws_iam_policy.tracing[0]
//       module.lambda_cognito_post_confirmation.module.lambda.aws_iam_policy.vpc[0]
//       module.lambda_cognito_post_confirmation.module.lambda.aws_lambda_function.lambda
//     }
//   }
// */
// source                                                                  = "../_layers/20.auth/33.lambda_cognito_post_confirmation"
// label                                                                   = module.label.tags
// market                                                                  = module.label.tags["Product"]
// tf_framework_component_version                                          = "${var.tf_framework_component_version}_lambda_cognito_post_confirmation"
// #connections
// outputs_sg_sg_rds_lambda_id                                             = module.sg.sg_rds_lambda_id
// outputs_vpc_private_subnets                                             = module.vpc.private_subnets
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "lambda_cognito_custom_email_sender" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.lambda_cognito_post_confirmation.data.archive_file.lambda_layer_package
//       module.lambda_cognito_post_confirmation.data.aws_caller_identity.current
//       module.lambda_cognito_post_confirmation.data.aws_default_tags.default
//       module.lambda_cognito_post_confirmation.data.aws_iam_policy_document.policy
//       module.lambda_cognito_post_confirmation.data.aws_iam_policy_document.secrets_policy
//       module.lambda_cognito_post_confirmation.data.aws_iam_policy_document.trust_policy
//       module.lambda_cognito_post_confirmation.aws_iam_policy.policy
//       module.lambda_cognito_post_confirmation.aws_iam_policy.secrets_policy
//       module.lambda_cognito_post_confirmation.aws_iam_role.role
//       module.lambda_cognito_post_confirmation.aws_iam_role_policy_attachment.policy
//       module.lambda_cognito_post_confirmation.aws_iam_role_policy_attachment.policy_attachment
//       module.lambda_cognito_post_confirmation.aws_iam_role_policy_attachment.secret_policy_attachment
//       module.lambda_cognito_post_confirmation.aws_secretsmanager_secret.this
//       module.lambda_cognito_post_confirmation.random_id.policy
//       module.lambda_cognito_post_confirmation.module.lambda.data.aws_iam_policy.tracing[0]
//       module.lambda_cognito_post_confirmation.module.lambda.data.aws_iam_policy.vpc[0]
//       module.lambda_cognito_post_confirmation.module.lambda.data.aws_iam_policy_document.lambda_trust_policy
//       module.lambda_cognito_post_confirmation.module.lambda.aws_iam_policy.tracing[0]
//       module.lambda_cognito_post_confirmation.module.lambda.aws_iam_policy.vpc[0]
//       module.lambda_cognito_post_confirmation.module.lambda.aws_lambda_function.lambda
//     }
//   }
// */
// source                                                                  = "../_layers/20.auth/33.lambda_cognito_custom_email_sender"
// label                                                                   = module.label.tags
// tf_framework_component_version                                          = "${var.tf_framework_component_version}_lambda_cognito_custom_email_sender"
// #connections
// outputs_sg_sg_rds_lambda_id                                             = module.sg.sg_rds_lambda_id
// outputs_vpc_private_subnets                                             = module.vpc.private_subnets
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "cognito" {
// /*
//   {
//     #general description
//     {
//       when deploy cognito
//       support+dev@book-nook-learning.com
//       +dev or +staging or +prod == all direct to support@book-nook-learning.com
//       so, no need to create support+ENV@book-nook-learning.com
//       you just need to create WORKMAIL ORGANIZATION + USER -> support@book-nook-learning.com
//       and after that login to mail and confirm cognito
//       etc.
//       support@book-nook-learning.com for all envs - shared resource to handle all emails
      
//       support@book-nook-learning.com
//       no-reply@book-nook-learning.com
      
//     usp || uss || red == count 1 true - deploy from layers? generics? resources? sublayers?
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.cognito.data.aws_caller_identity.current
//       module.cognito.data.aws_default_tags.default
//       module.cognito.data.aws_iam_policy_document.cognito_admin_auth_role
//       module.cognito.data.aws_iam_policy_document.cognito_admin_auth_trust
//       module.cognito.data.aws_iam_policy_document.cognito_admin_unauth_role
//       module.cognito.data.aws_iam_policy_document.cognito_admin_unauth_trust
//       module.cognito.data.aws_iam_policy_document.cognito_ses
//       module.cognito.data.aws_iam_policy_document.cognito_sms_send
//       module.cognito.data.aws_iam_policy_document.cognito_sms_send_polcy
//       module.cognito.data.aws_iam_policy_document.sns_log
//       module.cognito.data.aws_iam_policy_document.sns_role_assume
//       module.cognito.data.aws_region.current
//       module.cognito.aws_cognito_identity_pool.admin_identity_pool
//       module.cognito.aws_cognito_identity_pool_roles_attachment.admin_identity_pool
//       module.cognito.aws_iam_policy.cognito_admin_auth_policy
//       module.cognito.aws_iam_policy.cognito_admin_unauth_policy
//       module.cognito.aws_iam_policy.cognito_send_sms_policy
//       module.cognito.aws_iam_policy.sns_log
//       module.cognito.aws_iam_role.cognito_admin_auth_role
//       module.cognito.aws_iam_role.cognito_admin_unauth_role
//       module.cognito.aws_iam_role.cognito_send_sms
//       module.cognito.aws_iam_role.sns_log
//       module.cognito.aws_iam_role_policy_attachment.cognito_admin_auth_policy_attachment
//       module.cognito.aws_iam_role_policy_attachment.cognito_admin_unauth_policy_attachment
//       module.cognito.aws_iam_role_policy_attachment.cognito_send_sms_policy_attachment
//       module.cognito.aws_iam_role_policy_attachment.sns_log_policy_attachment
//       module.cognito.aws_lambda_permission.cognito_post_authentication
//       module.cognito.aws_lambda_permission.cognito_post_confirmation
//       module.cognito.aws_lambda_permission.cognito_pre_authentication
//       module.cognito.aws_ses_identity_policy.cognito_ses
//       module.cognito.aws_sns_sms_preferences.sms_prefs
//       module.cognito.random_id.cognito_ex_id
//       module.cognito.random_id.ses_pol_id
//       module.cognito.random_id.ses_role_id
//       module.cognito.random_id.sns_pol_id
//       module.cognito.module.cognito_app_ses.aws_ses_domain_identity.mail_domain_identity
//       module.cognito.module.cognito_app_ses.aws_ses_domain_mail_from.mobile_main_from
//       module.cognito.module.cognito_app_ses.aws_ses_email_identity.mobile_mail_from
//       module.cognito.module.cognito_app_user_pool.data.aws_iam_policy_document.cognito_sms_send
//       module.cognito.module.cognito_app_user_pool.data.aws_iam_policy_document.cognito_sms_send_polcy
//       module.cognito.module.cognito_app_user_pool.data.aws_region.current
//       module.cognito.module.cognito_app_user_pool.aws_cognito_user_group.main[0]
//       module.cognito.module.cognito_app_user_pool.aws_cognito_user_group.main[1]
//       module.cognito.module.cognito_app_user_pool.aws_cognito_user_group.main[2]
//       module.cognito.module.cognito_app_user_pool.aws_cognito_user_group.main[3]
//       module.cognito.module.cognito_app_user_pool.aws_cognito_user_pool.pool
//       module.cognito.module.cognito_app_user_pool.aws_cognito_user_pool_client.client
//       module.cognito.module.cognito_app_user_pool.aws_cognito_user_pool_domain.main
//       module.cognito.module.cognito_app_user_pool.aws_iam_policy.cognito_send_sms_policy
//       module.cognito.module.cognito_app_user_pool.aws_iam_role.cognito_send_sms
//       module.cognito.module.cognito_app_user_pool.aws_iam_role_policy_attachment.cognito_send_sms_policy_attachment
//       module.cognito.module.cognito_app_user_pool.random_id.cognito_ex_id
//       module.cognito.module.cognito_app_user_pool.random_id.uniq
//     }
//   }
// */
// source                                                                 = "../_layers/20.auth/35.cognito"
// label                                                                  = module.label.tags
// external_dns_domain                                                    = var.external_dns_domain
// ses_aws_region                                                         = var.ses_aws_region
// sns_monthly_spend_limit                                                = var.sns_monthly_spend_limit
// vpc_cidr                                                               = var.vpc_cidr
// cognito_urls                                                           = [var.tutorcommunity_booknook_callback_url, var.cognito_urls, "https://localhost:3000/auth/login" ] //"https://staging-red-staging.auth.us-east-1.amazoncognito.com/login/cognito" //var.cognito_urls // "https://uss-prod.auth.us-east-1.amazoncognito.com/login/cognito" //"https://portal.mytutorlearning.co/auth/login" //["https://${var.label["Product"]}.${var.label["Environment"]}.${var.external_dns_domain}/auth/login"]
// cognito_mail_from_domain                                               = var.cognito_email_from_domain
// cognito_ses_domain                                                     = var.cognito_ses_domain
// cogntio_ses_sender                                                     = var.cogntio_ses_sender
// cogntio_ses_email_subject                                              = var.cogntio_ses_email_subject
// cognito_invite_email_message                                           = file("${path.module}/invitation_message.html")
// cognito_invite_email_subject                                           = var.cognito_invite_email_subject
// schemas                                                                = local.locals_cognito_schemas[var.environment]
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_cognito"
// #connections
// outputs_lambda_lambda_post_authentication_arn                          = module.lambda_cognito_post_authentication.arn
// outputs_lambda_lambda_post_authentication_function_name                = module.lambda_cognito_post_authentication.function_name
// outputs_lambda_lambda_pre_authentication_arn                           = module.lambda_cognito_pre_authentication.arn
// outputs_lambda_lambda_pre_authentication_function_name                 = module.lambda_cognito_pre_authentication.function_name
// outputs_lambda_lambda_post_confirmation_arn                            = module.lambda_cognito_post_confirmation.arn
// outputs_lambda_lambda_post_confirmation_function_name                  = module.lambda_cognito_post_confirmation.function_name
// outputs_lambda_lambda_custom_email_sender_arn                          = module.lambda_cognito_custom_email_sender.arn
// outputs_lambda_lambda_custom_email_sender_function_name                = module.lambda_cognito_custom_email_sender.function_name
// }
// output "cognito_app_pool_id" {
//   value = module.cognito.cognito_app_pool_id
// }
// output "cognito_app_client_id" {
//   value = module.cognito.cognito_app_client_id
// }
// output "cognito_app_pool_arn" {
//   value = module.cognito.cognito_app_pool_arn
// }
// output "cognito_app_pool_endpoint" {
//   value = module.cognito.cognito_app_pool_endpoint
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// /*
// {


// ################################################################################
// ################################################################################
// #30.Fe
// ################################################################################
// ################################################################################



// }
// */
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "cloudfront" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.cloudfront.data.aws_caller_identity.current
//       module.cloudfront.data.aws_default_tags.default
//       module.cloudfront.data.aws_iam_policy_document.fe
//       module.cloudfront.aws_acm_certificate.this
//       module.cloudfront.aws_cloudfront_cache_policy.cache_off
//       module.cloudfront.aws_cloudfront_cache_policy.cache_on
//       module.cloudfront.aws_cloudfront_response_headers_policy.cache_off
//       module.cloudfront.aws_cloudfront_response_headers_policy.cache_on
//       module.cloudfront.aws_s3_bucket_policy.bucket_policy
//       module.cloudfront.aws_wafv2_ip_set.admin-ui
//       module.cloudfront.aws_wafv2_web_acl.admin-ui
//       module.cloudfront.random_id.bucket_prefix
//       module.cloudfront.module.cloudfront.aws_cloudfront_distribution.this[0]
//       module.cloudfront.module.cloudfront.aws_cloudfront_origin_access_identity.this["s3_bucket"]
//       module.cloudfront.module.fe.data.aws_iam_policy_document.combined
//       module.cloudfront.module.fe.data.aws_iam_policy_document.deny_insecure_transport
//       module.cloudfront.module.fe.aws_s3_bucket.bucket
//       module.cloudfront.module.fe.aws_s3_bucket_public_access_block.bucket_access_block
//       module.cloudfront.module.logs_bucket.data.aws_iam_policy_document.combined
//       module.cloudfront.module.logs_bucket.data.aws_iam_policy_document.deny_insecure_transport
//       module.cloudfront.module.logs_bucket.aws_s3_bucket.bucket
//       module.cloudfront.module.logs_bucket.aws_s3_bucket_policy.bucket_policy[0]
//       module.cloudfront.module.logs_bucket.aws_s3_bucket_public_access_block.bucket_access_block
//     }
//   }
// */
// source                                                                 = "../_layers/30.fe/55.cloudfront_web"
// label                                                                  = module.label.tags
// alias                                                                  = local.locals_cloudfront_alias[var.environment]
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_cloudfront_web"
// #connections
// outputs_vpc_vpc_nat_eips_cidr                                          = module.vpc.vpc_nat_eips_cidr
// outputs_acm_cloudfront_arn                                             = local.locals_acm_cloudfront[var.environment] != "" ? local.locals_acm_cloudfront[var.environment] : module.acm.acm_cloudfront_arn
// }
// output "cloudfront_distribution_domain_name" {
//   value = module.cloudfront.cloudfront_distribution_domain_name
// }
// output "cloudfront_distribution_hosted_zone_id" {
//   value = module.cloudfront.cloudfront_distribution_hosted_zone_id
// }
// output "cloudfront_s3_name" {
//   value = module.cloudfront.s3_name
// }
// output "cloudfront_s3_arn" {
//   value = module.cloudfront.s3_arn
// }
// output "cloudfront_admin_fe_id" {
//   value = module.cloudfront.cloudfront_admin_fe_id
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------





// ################################################################################
// ################################################################################
// #30.Be
// ################################################################################
// ################################################################################





// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "alb" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.alb.data.aws_default_tags.default
//       module.alb.data.aws_subnet_ids.private_lb
//       module.alb.data.aws_subnet_ids.public_lb
//       module.alb.module.alb_public_app.data.aws_default_tags.default
//       module.alb.module.alb_public_app.aws_lb.lb
//       module.alb.module.alb_public_app.aws_lb_listener.http
//       module.alb.module.alb_public_app.aws_lb_listener.https
//       module.alb.module.alb_public_app.aws_lb_listener_rule.swagger
//       module.alb.module.alb_public_app.random_id.alb_id
//     }
//   }
// */
// source                                                                 = "../_layers/10.core/30.alb"
// label                                                                  = module.label.tags
// vpc_cidr                                                               = var.vpc_cidr
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_alb"
// #connections
// outputs_acm_loadbalancer_arn                                           = local.locals_acm_alb[var.environment] != "" ? local.locals_acm_alb[var.environment] : module.acm.acm_loadbalancer_arn
//                                                                        # "arn:aws:acm:us-east-1:374165421193:certificate/bbefd13e-72bd-49e6-aba5-4a7ba8ebeac0" 
// outputs_sg_sg_alb_public_app_id                                        = module.sg.sg_alb_public_app_id
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// output "alb_apl_private_hosted_zone_id" {
//   value = module.alb.alb_apl_private_hosted_zone_id
// }
// output "alb_dns" {
//   value = module.alb.alb_public_app_dns_name
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "service_discovery" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.service_discovery.data.aws_default_tags.default
//       module.service_discovery.aws_service_discovery_http_namespace.this
//       module.service_discovery.aws_service_discovery_private_dns_namespace.this
//     }
//   }
// */
// source                                                                 = "../_layers/30.be/32.service_discovery"
// label                                                                  = module.label.tags
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_service_discovery"
// #connections
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "ecs" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.ecs.data.aws_caller_identity.current
//       module.ecs.data.aws_default_tags.default
//       module.ecs.aws_ecs_cluster.main
//     }
//   }
// */
// source                                                                 = "../_layers/30.be/40.ecs"
// label                                                                  = module.label.tags
// vpc_cidr                                                               = var.vpc_cidr
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_ecs"
// }
// output "ecs_cluster" {
//   value = module.ecs.ecs_main_cluster_name
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------





// ################################################################################
// ################################################################################
// #40.Services
// ################################################################################
// ################################################################################





// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "ecs_service_api_gateway" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.ecs_service_api_gateway.data.aws_caller_identity.current
//       module.ecs_service_api_gateway.data.aws_default_tags.default
//       module.ecs_service_api_gateway.data.aws_subnet_ids.services_subnets
//       module.ecs_service_api_gateway.aws_ecr_repository.ecr
//       module.ecs_service_api_gateway.aws_iam_policy.task_execution_role_policy
//       module.ecs_service_api_gateway.aws_iam_policy.task_role_policy
//       module.ecs_service_api_gateway.aws_iam_role.task_execution_role
//       module.ecs_service_api_gateway.aws_iam_role.task_role
//       module.ecs_service_api_gateway.aws_iam_role_policy_attachment.task_execution_role_policy_attachment
//       module.ecs_service_api_gateway.aws_iam_role_policy_attachment.task_role_policy_attachment
//       module.ecs_service_api_gateway.aws_lb_listener_rule.api_rule_https
//       module.ecs_service_api_gateway.aws_lb_target_group.api_tgt
//       module.ecs_service_api_gateway.aws_security_group_rule.cache
//       module.ecs_service_api_gateway.aws_security_group_rule.db
//       module.ecs_service_api_gateway.aws_service_discovery_service.this
//       module.ecs_service_api_gateway.aws_ssm_parameter.allowed_origin_patterns
//       module.ecs_service_api_gateway.aws_ssm_parameter.csrf_enabled
//       module.ecs_service_api_gateway.aws_ssm_parameter.import_management_uri
//       module.ecs_service_api_gateway.aws_ssm_parameter.lesson_management_uri
//       module.ecs_service_api_gateway.aws_ssm_parameter.payment_management_uri
//       module.ecs_service_api_gateway.aws_ssm_parameter.program_management_uri
//       module.ecs_service_api_gateway.aws_ssm_parameter.region
//       module.ecs_service_api_gateway.aws_ssm_parameter.server_base_url
//       module.ecs_service_api_gateway.aws_ssm_parameter.server_domain
//       module.ecs_service_api_gateway.aws_ssm_parameter.server_secret
//       module.ecs_service_api_gateway.aws_ssm_parameter.spring_profiles_active
//       module.ecs_service_api_gateway.aws_ssm_parameter.tutor_application_uri
//       module.ecs_service_api_gateway.aws_ssm_parameter.tutor_interview_uri
//       module.ecs_service_api_gateway.aws_ssm_parameter.user_management_uri
//       module.ecs_service_api_gateway.random_id.exec_uniq
//       module.ecs_service_api_gateway.random_id.task_uniq
//       module.ecs_service_api_gateway.module.autoscaling.aws_appautoscaling_policy.cpu
//       module.ecs_service_api_gateway.module.autoscaling.aws_appautoscaling_policy.memory
//       module.ecs_service_api_gateway.module.autoscaling.aws_appautoscaling_target.target
//       module.ecs_service_api_gateway.module.service.data.aws_caller_identity.current
//       module.ecs_service_api_gateway.module.service.data.aws_default_tags.default
//       module.ecs_service_api_gateway.module.service.aws_ecs_service.service
//       module.ecs_service_api_gateway.module.service.random_string.suffix
//       module.ecs_service_api_gateway.module.sg.data.aws_caller_identity.current
//       module.ecs_service_api_gateway.module.sg.data.aws_default_tags.default
//       module.ecs_service_api_gateway.module.sg.aws_security_group.sg
//       module.ecs_service_api_gateway.module.task_def.data.aws_caller_identity.current
//       module.ecs_service_api_gateway.module.task_def.data.aws_default_tags.default
//       module.ecs_service_api_gateway.module.task_def.aws_ecs_task_definition.td
//     }
//   }
// */
// source                                                                 = "../_layers/40.services/5000.ddd_ecs_service_api_gateway"
// first_run                                                              = var.first_run
// label                                                                  = module.label.tags
// boooknook_base_app_url                                                 = var.booknook_base_app_url
// external_dns_domain                                                    = var.external_dns_domain
// allowed_origin_patterns                                                = var.allowed_origin_patterns
// csrf_enabled                                                           = var.csrf_enabled
// server_secret                                                          = var.server_secret
// server_base_url                                                        = var.server_base_url
// server_domain                                                          = var.server_domain
// smoketest_emails                                                       = var.smoketest_emails
// spring_profiles_active                                                 = var.spring_profiles_active
// platform_name                                                          = var.platform_name
// phoenix_master_db_schema                                               = var.phoenix_master_db_schema
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_ddd_ecs_service_api_gateway"
// #connections
// #   outputs_alb_alb_public_app_backends_api_gateway                        = module.alb.alb_public_app_backends_api_gateway
// outputs_alb_listener_arn                                               = module.alb.aws_lb_listener_https
// outputs_cache_cache_entrypoint                                         = module.cache.cache_entrypoint
// outputs_cognito_cognito_app_pool_id                                    = module.cognito.cognito_app_pool_id
// outputs_ecs_ecs_main_cluster_arn                                       = module.ecs.ecs_main_cluster_arn
// outputs_ecs_ecs_main_cluster_name                                      = module.ecs.ecs_main_cluster_name
// outputs_service_discovery_service_discovery_private_dns_namespace_id   = module.service_discovery.service_discovery_private_dns_namespace_id
// outputs_sg_sg_alb_public_app_id                                        = module.sg.sg_alb_public_app_id
// outputs_sg_sg_cache_id                                                 = module.sg.sg_cache_id
// outputs_sg_sg_default_db_id                                            = module.sg.sg_default_db_id
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// output "ecs_service_api_gateway_task_role" {
//   value = module.ecs_service_api_gateway.ecs_service_task_role
// }
// output "ecs_service_api_gateway_task_execution_role" {
//   value = module.ecs_service_api_gateway.ecs_service_task_execution_role
// }
// output "ecs_service_api_gateway_td" {
//   value = module.ecs_service_api_gateway.ecs_service_td
// }
// output "ecs_service_api_gateway_ecr" {
//   value = module.ecs_service_api_gateway.ecs_service_ecr
// }
// output "ecs_service_api_gateway_service_name" {
//   value = module.ecs_service_api_gateway.ecs_service_service_name
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "ecs_service_import" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.ecs_service_import.data.aws_caller_identity.current
//       module.ecs_service_import.data.aws_default_tags.default
//       module.ecs_service_import.data.aws_subnet_ids.services_subnets
//       module.ecs_service_import.aws_ecr_repository.ecr
//       module.ecs_service_import.aws_iam_policy.task_execution_role_policy
//       module.ecs_service_import.aws_iam_policy.task_role_policy
//       module.ecs_service_import.aws_iam_role.task_execution_role
//       module.ecs_service_import.aws_iam_role.task_role
//       module.ecs_service_import.aws_iam_role_policy_attachment.task_execution_role_policy_attachment
//       module.ecs_service_import.aws_iam_role_policy_attachment.task_role_policy_attachment
//       module.ecs_service_import.aws_lb_listener_rule.api_rule_https
//       module.ecs_service_import.aws_lb_target_group.api_tgt
//       module.ecs_service_import.aws_security_group_rule.cache
//       module.ecs_service_import.aws_security_group_rule.db
//       module.ecs_service_import.aws_service_discovery_service.this
//       module.ecs_service_import.aws_ssm_parameter.kafka_producer_tx_prefix
//       module.ecs_service_import.aws_ssm_parameter.lesson_management_service_url
//       module.ecs_service_import.aws_ssm_parameter.region
//       module.ecs_service_import.aws_ssm_parameter.server_base_url
//       module.ecs_service_import.aws_ssm_parameter.server_domain
//       module.ecs_service_import.aws_ssm_parameter.server_secret
//       module.ecs_service_import.aws_ssm_parameter.spring_datasource_driver_class_name
//       module.ecs_service_import.aws_ssm_parameter.spring_profiles_active
//       module.ecs_service_import.aws_ssm_parameter.user_service_url
//       module.ecs_service_import.random_id.exec_uniq
//       module.ecs_service_import.random_id.s3
//       module.ecs_service_import.random_id.task_uniq
//       module.ecs_service_import.module.autoscaling.aws_appautoscaling_policy.cpu
//       module.ecs_service_import.module.autoscaling.aws_appautoscaling_policy.memory
//       module.ecs_service_import.module.autoscaling.aws_appautoscaling_target.target
//       module.ecs_service_import.module.s3.data.aws_iam_policy_document.combined
//       module.ecs_service_import.module.s3.data.aws_iam_policy_document.deny_insecure_transport
//       module.ecs_service_import.module.s3.aws_s3_bucket.bucket
//       module.ecs_service_import.module.s3.aws_s3_bucket_policy.bucket_policy[0]
//       module.ecs_service_import.module.s3.aws_s3_bucket_public_access_block.bucket_access_block
//       module.ecs_service_import.module.service.data.aws_caller_identity.current
//       module.ecs_service_import.module.service.data.aws_default_tags.default
//       module.ecs_service_import.module.service.aws_ecs_service.service
//       module.ecs_service_import.module.service.random_string.suffix
//       module.ecs_service_import.module.sg.data.aws_caller_identity.current
//       module.ecs_service_import.module.sg.data.aws_default_tags.default
//       module.ecs_service_import.module.sg.aws_security_group.sg
//       module.ecs_service_import.module.task_def.data.aws_caller_identity.current
//       module.ecs_service_import.module.task_def.data.aws_default_tags.default
//       module.ecs_service_import.module.task_def.aws_ecs_task_definition.td
//     }
//   }
// */
// source                                                                 = "../_layers/40.services/5000.ddd_ecs_service_import"
// first_run                                                              = var.first_run
// label                                                                  = module.label.tags
// boooknook_base_app_url                                                 = var.booknook_app_url
// external_dns_domain                                                    = var.external_dns_domain
// csrf_enabled                                                           = var.csrf_enabled
// server_secret                                                          = var.server_secret
// server_base_url                                                        = var.server_base_url
// server_domain                                                          = var.server_domain
// spring_datasource_driver_class_name                                    = var.spring_datasource_driver_class_name
// ecs_import_kafka_producer_tx_prefix                                    = var.ecs_import_kafka_producer_tx_prefix
// smoketest_emails                                                       = var.smoketest_emails
// spring_profiles_active                                                 = var.spring_profiles_active
// platform_name                                                          = var.platform_name
// phoenix_master_db_schema                                               = var.phoenix_master_db_schema
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_ddd_ecs_service_import"
// #connections
// #   outputs_alb_alb_public_app_backends_api_gateway                        = module.alb.alb_public_app_backends_api_gateway
// outputs_alb_listener_arn                                               = module.alb.aws_lb_listener_https
// outputs_cache_cache_entrypoint                                         = module.cache.cache_entrypoint
// outputs_cognito_cognito_app_pool_id                                    = module.cognito.cognito_app_pool_id
// outputs_db_db_main_entrypoint                                          = module.db.db_main_entrypoint
// outputs_ecs_ecs_main_cluster_arn                                       = module.ecs.ecs_main_cluster_arn
// outputs_ecs_ecs_main_cluster_name                                      = module.ecs.ecs_main_cluster_name
// outputs_ecs_service_api_gateway_sg_id                                  = module.ecs_service_api_gateway.api_gateway_sg_id
// outputs_kafka_bootstrap_brokers                                        = module.kafka.bootstrap_brokers
// outputs_s3_s3_bucket_name                                              = module.s3.s3_bucket_name
// outputs_service_discovery_service_discovery_private_dns_namespace_id   = module.service_discovery.service_discovery_private_dns_namespace_id
// outputs_sg_sg_alb_public_app_id                                        = module.sg.sg_alb_public_app_id
// outputs_sg_sg_cache_id                                                 = module.sg.sg_cache_id
// outputs_sg_sg_default_db_id                                            = module.sg.sg_default_db_id
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// output "ecs_service_import_task_role" {
//   value = module.ecs_service_import.ecs_service_task_role
// }
// output "ecs_service_import_task_execution_role" {
//   value = module.ecs_service_import.ecs_service_task_execution_role
// }
// output "ecs_service_import_td" {
//   value = module.ecs_service_import.ecs_service_td
// }
// output "ecs_service_import_ecr" {
//   value = module.ecs_service_import.ecs_service_ecr
// }
// output "ecs_service_import_service_name" {
//   value = module.ecs_service_import.ecs_service_service_name
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "ecs_service_lesson_management" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.ecs_service_lesson_management.data.aws_caller_identity.current
//       module.ecs_service_lesson_management.data.aws_default_tags.default
//       module.ecs_service_lesson_management.data.aws_subnet_ids.services_subnets
//       module.ecs_service_lesson_management.aws_ecr_repository.ecr
//       module.ecs_service_lesson_management.aws_iam_policy.task_execution_role_policy
//       module.ecs_service_lesson_management.aws_iam_policy.task_role_policy
//       module.ecs_service_lesson_management.aws_iam_role.task_execution_role
//       module.ecs_service_lesson_management.aws_iam_role.task_role
//       module.ecs_service_lesson_management.aws_iam_role_policy_attachment.task_execution_role_policy_attachment
//       module.ecs_service_lesson_management.aws_iam_role_policy_attachment.task_role_policy_attachment
//       module.ecs_service_lesson_management.aws_lb_listener_rule.api_rule_https
//       module.ecs_service_lesson_management.aws_lb_target_group.api_tgt
//       module.ecs_service_lesson_management.aws_security_group_rule.cache
//       module.ecs_service_lesson_management.aws_security_group_rule.db
//       module.ecs_service_lesson_management.aws_security_group_rule.quartz
//       module.ecs_service_lesson_management.aws_service_discovery_service.this
//       module.ecs_service_lesson_management.aws_ssm_parameter.booknook_base_app_url
//       module.ecs_service_lesson_management.aws_ssm_parameter.kafka_producer_tx_prefix
//       module.ecs_service_lesson_management.aws_ssm_parameter.region
//       module.ecs_service_lesson_management.aws_ssm_parameter.server_base_url
//       module.ecs_service_lesson_management.aws_ssm_parameter.server_domain
//       module.ecs_service_lesson_management.aws_ssm_parameter.server_secret
//       module.ecs_service_lesson_management.aws_ssm_parameter.spring_datasource_driver_class_name
//       module.ecs_service_lesson_management.aws_ssm_parameter.spring_datasource_url
//       module.ecs_service_lesson_management.aws_ssm_parameter.spring_kafka_topics_lesson
//       module.ecs_service_lesson_management.aws_ssm_parameter.spring_kafka_topics_users
//       module.ecs_service_lesson_management.aws_ssm_parameter.spring_profiles_active
//       module.ecs_service_lesson_management.random_id.exec_uniq
//       module.ecs_service_lesson_management.random_id.task_uniq
//       module.ecs_service_lesson_management.module.autoscaling.aws_appautoscaling_policy.cpu
//       module.ecs_service_lesson_management.module.autoscaling.aws_appautoscaling_policy.memory
//       module.ecs_service_lesson_management.module.autoscaling.aws_appautoscaling_target.target
//       module.ecs_service_lesson_management.module.service.data.aws_caller_identity.current
//       module.ecs_service_lesson_management.module.service.data.aws_default_tags.default
//       module.ecs_service_lesson_management.module.service.aws_ecs_service.service
//       module.ecs_service_lesson_management.module.service.random_string.suffix
//       module.ecs_service_lesson_management.module.sg.data.aws_caller_identity.current
//       module.ecs_service_lesson_management.module.sg.data.aws_default_tags.default
//       module.ecs_service_lesson_management.module.sg.aws_security_group.sg
//       module.ecs_service_lesson_management.module.task_def.data.aws_caller_identity.current
//       module.ecs_service_lesson_management.module.task_def.data.aws_default_tags.default
//       module.ecs_service_lesson_management.module.task_def.aws_ecs_task_definition.td
//     }
//   }
// */
// source                                                                 = "../_layers/40.services/5000.ddd_ecs_service_lesson_management"
// first_run                                                              = var.first_run
// label                                                                  = module.label.tags
// boooknook_base_app_url                                                 = var.booknook_app_url
// external_dns_domain                                                    = var.external_dns_domain
// server_secret                                                          = var.server_secret
// spring_datasource_url                                                  = var.spring_datasource_url
// spring_datasource_driver_class_name                                    = var.spring_datasource_driver_class_name
// ecs_lesson_management_kafka_producer_tx_prefix                         = var.ecs_lesson_management_kafka_producer_tx_prefix
// ecs_lesson_management_spring_kafka_topics_users                        = var.ecs_lesson_management_spring_kafka_topics_users
// ecs_lesson_management_spring_kafka_topics_lesson                       = var.ecs_lesson_management_spring_kafka_topics_lesson
// server_base_url                                                        = var.server_base_url
// server_domain                                                          = var.server_domain
// smoketest_emails                                                       = var.smoketest_emails
// spring_profiles_active                                                 = var.spring_profiles_active
// email_from_domain                                                      = var.email_from_domain
// platform_name                                                          = var.platform_name
// phoenix_master_db_schema                                               = var.phoenix_master_db_schema
// ecs_lesson_management_tutor_join_time_minutes                          = var.ecs_lesson_management_tutor_join_time_minutes
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_ddd_ecs_service_lesson_management"
// #connections
// # outputs_alb_alb_public_app_backends_api_gateway                        = module.alb.alb_public_app_backends_api_gateway
// outputs_alb_listener_arn                                               = module.alb.aws_lb_listener_https
// outputs_cache_cache_entrypoint                                         = module.cache.cache_entrypoint
// outputs_cognito_cognito_app_pool_id                                    = module.cognito.cognito_app_pool_id
// outputs_db_db_main_entrypoint                                          = module.db.db_main_entrypoint
// outputs_ecs_ecs_main_cluster_arn                                       = module.ecs.ecs_main_cluster_arn
// outputs_ecs_ecs_main_cluster_name                                      = module.ecs.ecs_main_cluster_name
// outputs_ecs_service_api_gateway_sg_id                                  = module.ecs_service_api_gateway.api_gateway_sg_id
// outputs_kafka_bootstrap_brokers                                        = module.kafka.bootstrap_brokers
// outputs_s3_s3_bucket_name                                              = module.s3.s3_bucket_name
// outputs_service_discovery_service_discovery_private_dns_namespace_id   = module.service_discovery.service_discovery_private_dns_namespace_id
// outputs_sg_sg_alb_public_app_id                                        = module.sg.sg_alb_public_app_id
// outputs_sg_sg_cache_id                                                 = module.sg.sg_cache_id
// outputs_sg_sg_default_db_id                                            = module.sg.sg_default_db_id
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// outputs_sg_sg_ecs_program_management_id                                = module.ecs_service_program_management.sg_ecs_program_management_id
// outputs_sg_sg_quartz_db_id                                             = module.quartz.sg_default_db_id
// outputs_db_db_quartz_entrypoint                                        = module.quartz.db_quartz_entrypoint
// }
// output "ecs_service_lesson_management_task_role" {
//   value = module.ecs_service_lesson_management.ecs_service_task_role
// }
// output "ecs_service_lesson_management_task_execution_role" {
//   value = module.ecs_service_lesson_management.ecs_service_task_execution_role
// }
// output "ecs_service_lesson_management_td" {
//   value = module.ecs_service_lesson_management.ecs_service_td
// }
// output "ecs_service_lesson_management_ecr" {
//   value = module.ecs_service_lesson_management.ecs_service_ecr
// }
// output "ecs_service_lesson_management_service_name" {
//   value = module.ecs_service_lesson_management.ecs_service_service_name
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "ecs_service_message_bus" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.ecs_service_message_bus.data.aws_caller_identity.current
//       module.ecs_service_message_bus.data.aws_default_tags.default
//       module.ecs_service_message_bus.data.aws_subnet_ids.services_subnets
//       module.ecs_service_message_bus.aws_ecr_repository.ecr
//       module.ecs_service_message_bus.aws_iam_policy.task_execution_role_policy
//       module.ecs_service_message_bus.aws_iam_policy.task_role_policy
//       module.ecs_service_message_bus.aws_iam_role.task_execution_role
//       module.ecs_service_message_bus.aws_iam_role.task_role
//       module.ecs_service_message_bus.aws_iam_role_policy_attachment.task_execution_role_policy_attachment
//       module.ecs_service_message_bus.aws_iam_role_policy_attachment.task_role_policy_attachment
//       module.ecs_service_message_bus.aws_lb_listener_rule.api_rule_https
//       module.ecs_service_message_bus.aws_lb_target_group.api_tgt
//       module.ecs_service_message_bus.aws_security_group_rule.cache
//       module.ecs_service_message_bus.aws_security_group_rule.db
//       module.ecs_service_message_bus.aws_service_discovery_service.this
//       module.ecs_service_message_bus.aws_ssm_parameter.kafka_lessons_topic_partitions
//       module.ecs_service_message_bus.aws_ssm_parameter.kafka_lessons_topic_replicas
//       module.ecs_service_message_bus.aws_ssm_parameter.region
//       module.ecs_service_message_bus.aws_ssm_parameter.spring_profiles_active
//       module.ecs_service_message_bus.random_id.exec_uniq
//       module.ecs_service_message_bus.random_id.task_uniq
//       module.ecs_service_message_bus.module.autoscaling.aws_appautoscaling_policy.cpu
//       module.ecs_service_message_bus.module.autoscaling.aws_appautoscaling_policy.memory
//       module.ecs_service_message_bus.module.autoscaling.aws_appautoscaling_target.target
//       module.ecs_service_message_bus.module.service.data.aws_caller_identity.current
//       module.ecs_service_message_bus.module.service.data.aws_default_tags.default
//       module.ecs_service_message_bus.module.service.aws_ecs_service.service
//       module.ecs_service_message_bus.module.service.random_string.suffix
//       module.ecs_service_message_bus.module.sg.data.aws_caller_identity.current
//       module.ecs_service_message_bus.module.sg.data.aws_default_tags.default
//       module.ecs_service_message_bus.module.sg.aws_security_group.sg
//       module.ecs_service_message_bus.module.task_def.data.aws_caller_identity.current
//       module.ecs_service_message_bus.module.task_def.data.aws_default_tags.default
//       module.ecs_service_message_bus.module.task_def.aws_ecs_task_definition.td
//     }
//   }
// */
// source                                                                 = "../_layers/40.services/5000.ddd_ecs_service_message_bus"
// first_run                                                              = var.first_run
// label                                                                  = module.label.tags
// boooknook_base_app_url                                                 = var.booknook_app_url
// external_dns_domain                                                    = var.external_dns_domain
// server_base_url                                                        = var.server_base_url
// server_domain                                                          = var.server_domain
// smoketest_emails                                                       = var.smoketest_emails
// spring_profiles_active                                                 = var.spring_profiles_active
// platform_name                                                          = var.platform_name
// phoenix_master_db_schema                                               = var.phoenix_master_db_schema
// lesson_space_api                                                       = var.lesson_space_api //"10555e09-8b63-454d-9900-9e0392b7fb69"
// ecs_message_bus_kafka_lessons_topic_replicas                           = var.ecs_message_bus_kafka_lessons_topic_replicas
// ecs_message_bus_kafka_lessons_topic_partitions                         = var.ecs_message_bus_kafka_lessons_topic_partitions
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_ddd_ecs_service_message_bus"
// #connections
// #   outputs_alb_alb_public_app_backends_api_gateway                        = module.alb.alb_public_app_backends_api_gateway
// outputs_alb_listener_arn                                               = module.alb.aws_lb_listener_https
// outputs_cache_cache_entrypoint                                         = module.cache.cache_entrypoint
// outputs_cognito_cognito_app_pool_id                                    = module.cognito.cognito_app_pool_id
// outputs_db_db_main_entrypoint                                          = module.db.db_main_entrypoint
// outputs_ecs_ecs_main_cluster_arn                                       = module.ecs.ecs_main_cluster_arn
// outputs_ecs_ecs_main_cluster_name                                      = module.ecs.ecs_main_cluster_name
// outputs_ecs_service_api_gateway_sg_id                                  = module.ecs_service_api_gateway.api_gateway_sg_id
// outputs_kafka_bootstrap_brokers                                        = module.kafka.bootstrap_brokers
// outputs_s3_s3_bucket_name                                              = module.s3.s3_bucket_name
// outputs_service_discovery_service_discovery_private_dns_namespace_id   = module.service_discovery.service_discovery_private_dns_namespace_id
// outputs_sg_sg_alb_public_app_id                                        = module.sg.sg_alb_public_app_id
// outputs_sg_sg_cache_id                                                 = module.sg.sg_cache_id
// outputs_sg_sg_default_db_id                                            = module.sg.sg_default_db_id
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// output "ecs_service_message_bus_task_role" {
//   value = module.ecs_service_message_bus.ecs_service_task_role
// }
// output "ecs_service_message_bus_task_execution_role" {
//   value = module.ecs_service_message_bus.ecs_service_task_execution_role
// }
// output "ecs_service_message_bus_td" {
//   value = module.ecs_service_message_bus.ecs_service_td
// }
// output "ecs_service_message_bus_ecr" {
//   value = module.ecs_service_message_bus.ecs_service_ecr
// }
// output "ecs_service_message_bus_service_name" {
//   value = module.ecs_service_message_bus.ecs_service_service_name
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "ecs_service_payment" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.ecs_service_payment.data.aws_caller_identity.current
//       module.ecs_service_payment.data.aws_default_tags.default
//       module.ecs_service_payment.data.aws_subnet_ids.services_subnets
//       module.ecs_service_payment.aws_ecr_repository.ecr
//       module.ecs_service_payment.aws_iam_policy.task_execution_role_policy
//       module.ecs_service_payment.aws_iam_policy.task_role_policy
//       module.ecs_service_payment.aws_iam_role.task_execution_role
//       module.ecs_service_payment.aws_iam_role.task_role
//       module.ecs_service_payment.aws_iam_role_policy_attachment.task_execution_role_policy_attachment
//       module.ecs_service_payment.aws_iam_role_policy_attachment.task_role_policy_attachment
//       module.ecs_service_payment.aws_lb_listener_rule.api_rule_https
//       module.ecs_service_payment.aws_lb_target_group.api_tgt
//       module.ecs_service_payment.aws_security_group_rule.cache
//       module.ecs_service_payment.aws_security_group_rule.db
//       module.ecs_service_payment.aws_service_discovery_service.this
//       module.ecs_service_payment.aws_ssm_parameter.region
//       module.ecs_service_payment.aws_ssm_parameter.server_base_url
//       module.ecs_service_payment.aws_ssm_parameter.server_domain
//       module.ecs_service_payment.aws_ssm_parameter.server_secret
//       module.ecs_service_payment.aws_ssm_parameter.spring_profiles_active
//       module.ecs_service_payment.aws_ssm_parameter.tutor_lesson_hour_cost
//       module.ecs_service_payment.random_id.exec_uniq
//       module.ecs_service_payment.random_id.task_uniq
//       module.ecs_service_payment.module.autoscaling.aws_appautoscaling_policy.cpu
//       module.ecs_service_payment.module.autoscaling.aws_appautoscaling_policy.memory
//       module.ecs_service_payment.module.autoscaling.aws_appautoscaling_target.target
//       module.ecs_service_payment.module.service.data.aws_caller_identity.current
//       module.ecs_service_payment.module.service.data.aws_default_tags.default
//       module.ecs_service_payment.module.service.aws_ecs_service.service
//       module.ecs_service_payment.module.service.random_string.suffix
//       module.ecs_service_payment.module.sg.data.aws_caller_identity.current
//       module.ecs_service_payment.module.sg.data.aws_default_tags.default
//       module.ecs_service_payment.module.sg.aws_security_group.sg
//       module.ecs_service_payment.module.task_def.data.aws_caller_identity.current
//       module.ecs_service_payment.module.task_def.data.aws_default_tags.default
//       module.ecs_service_payment.module.task_def.aws_ecs_task_definition.td
//     }
//   }
// */
// source                                                                 = "../_layers/40.services/5000.ddd_ecs_service_payment"
// #general
// first_run                                                              = var.first_run
// label                                                                  = module.label.tags
// boooknook_base_app_url                                                 = var.booknook_app_url
// external_dns_domain                                                    = var.external_dns_domain
// server_base_url                                                        = var.server_base_url
// server_domain                                                          = var.server_domain
// server_secret                                                          = var.server_secret
// smoketest_emails                                                       = var.smoketest_emails
// spring_profiles_active                                                 = var.spring_profiles_active
// platform_name                                                          = var.platform_name
// phoenix_master_db_schema                                               = var.phoenix_master_db_schema
// ecs_payment_tutor_lesson_hour_cost                                     = var.ecs_payment_tutor_lesson_hour_cost
// ecs_payment_wm_url                                                     = var.ecs_payment_wm_url
// ecs_payment_wm_sign_up_url                                             = var.ecs_payment_wm_sign_up_url
// ecs_payment_wm_sign_in_url                                             = var.ecs_payment_wm_sign_in_url
// ecs_payment_wm_relay_id                                                = var.ecs_payment_wm_relay_id
// ecs_payment_wm_relay_access_token                                      = var.ecs_payment_wm_relay_access_token
// ecs_payment_wm_add_update_action                                       = var.ecs_payment_wm_add_update_action
// ecs_payment_wm_rule_meta_group                                         = var.ecs_payment_wm_rule_meta_group
// ecs_payment_wm_delete_action                                           = var.ecs_payment_wm_delete_action
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_ddd_ecs_service_payment"
// #connections
// #   outputs_alb_alb_public_app_backends_api_gateway                        = module.alb.alb_public_app_backends_api_gateway
// outputs_alb_listener_arn                                               = module.alb.aws_lb_listener_https
// outputs_cache_cache_entrypoint                                         = module.cache.cache_entrypoint
// outputs_cognito_cognito_app_pool_id                                    = module.cognito.cognito_app_pool_id
// outputs_db_db_main_entrypoint                                          = module.db.db_main_entrypoint
// outputs_ecs_ecs_main_cluster_arn                                       = module.ecs.ecs_main_cluster_arn
// outputs_ecs_ecs_main_cluster_name                                      = module.ecs.ecs_main_cluster_name
// outputs_ecs_service_api_gateway_sg_id                                  = module.ecs_service_api_gateway.api_gateway_sg_id
// outputs_kafka_bootstrap_brokers                                        = module.kafka.bootstrap_brokers
// outputs_s3_s3_bucket_name                                              = module.s3.s3_bucket_name
// outputs_service_discovery_service_discovery_private_dns_namespace_id   = module.service_discovery.service_discovery_private_dns_namespace_id
// outputs_sg_sg_alb_public_app_id                                        = module.sg.sg_alb_public_app_id
// outputs_sg_sg_cache_id                                                 = module.sg.sg_cache_id
// outputs_sg_sg_default_db_id                                            = module.sg.sg_default_db_id
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// output "ecs_service_payment_task_role" {
//   value = module.ecs_service_payment.ecs_service_task_role
// }
// output "ecs_service_payment_task_execution_role" {
//   value = module.ecs_service_payment.ecs_service_task_execution_role
// }
// output "ecs_service_payment_td" {
//   value = module.ecs_service_payment.ecs_service_td
// }
// output "ecs_service_payment_ecr" {
//   value = module.ecs_service_payment.ecs_service_ecr
// }
// output "ecs_service_payment_service_name" {
//   value = module.ecs_service_payment.ecs_service_service_name
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "ecs_service_program_management" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.ecs_service_program_management.data.aws_caller_identity.current
//       module.ecs_service_program_management.data.aws_default_tags.default
//       module.ecs_service_program_management.data.aws_subnet_ids.services_subnets
//       module.ecs_service_program_management.aws_ecr_repository.ecr
//       module.ecs_service_program_management.aws_iam_policy.task_execution_role_policy
//       module.ecs_service_program_management.aws_iam_policy.task_role_policy
//       module.ecs_service_program_management.aws_iam_role.task_execution_role
//       module.ecs_service_program_management.aws_iam_role.task_role
//       module.ecs_service_program_management.aws_iam_role_policy_attachment.task_execution_role_policy_attachment
//       module.ecs_service_program_management.aws_iam_role_policy_attachment.task_role_policy_attachment
//       module.ecs_service_program_management.aws_lb_listener_rule.api_rule_https
//       module.ecs_service_program_management.aws_lb_target_group.api_tgt
//       module.ecs_service_program_management.aws_security_group_rule.cache
//       module.ecs_service_program_management.aws_security_group_rule.db
//       module.ecs_service_program_management.aws_service_discovery_service.this
//       module.ecs_service_program_management.aws_ssm_parameter.kafka_producer_tx_prefix
//       module.ecs_service_program_management.aws_ssm_parameter.lesson_management_service_url
//       module.ecs_service_program_management.aws_ssm_parameter.region
//       module.ecs_service_program_management.aws_ssm_parameter.server_base_url
//       module.ecs_service_program_management.aws_ssm_parameter.server_domain
//       module.ecs_service_program_management.aws_ssm_parameter.server_secret
//       module.ecs_service_program_management.aws_ssm_parameter.spring_datasource_driver_class_name
//       module.ecs_service_program_management.aws_ssm_parameter.spring_profiles_active
//       module.ecs_service_program_management.aws_ssm_parameter.user_service_url
//       module.ecs_service_program_management.random_id.exec_uniq
//       module.ecs_service_program_management.random_id.task_uniq
//       module.ecs_service_program_management.module.autoscaling.aws_appautoscaling_policy.cpu
//       module.ecs_service_program_management.module.autoscaling.aws_appautoscaling_policy.memory
//       module.ecs_service_program_management.module.autoscaling.aws_appautoscaling_target.target
//       module.ecs_service_program_management.module.service.data.aws_caller_identity.current
//       module.ecs_service_program_management.module.service.data.aws_default_tags.default
//       module.ecs_service_program_management.module.service.aws_ecs_service.service
//       module.ecs_service_program_management.module.service.random_string.suffix
//       module.ecs_service_program_management.module.sg.data.aws_caller_identity.current
//       module.ecs_service_program_management.module.sg.data.aws_default_tags.default
//       module.ecs_service_program_management.module.sg.aws_security_group.sg
//       module.ecs_service_program_management.module.task_def.data.aws_caller_identity.current
//       module.ecs_service_program_management.module.task_def.data.aws_default_tags.default
//       module.ecs_service_program_management.module.task_def.aws_ecs_task_definition.td
//     }
//   }
// */
// source                                                                 = "../_layers/40.services/5000.ddd_ecs_service_program_management"
// first_run                                                              = var.first_run
// label                                                                  = module.label.tags
// boooknook_base_app_url                                                 = var.booknook_app_url
// external_dns_domain                                                    = var.external_dns_domain
// server_base_url                                                        = var.server_base_url
// server_domain                                                          = var.server_domain
// smoketest_emails                                                       = var.smoketest_emails
// spring_profiles_active                                                 = var.spring_profiles_active
// platform_name                                                          = var.platform_name
// phoenix_master_db_schema                                               = var.phoenix_master_db_schema
// ecs_program_management_kafka_producer_tx_prefix                        = var.ecs_program_management_kafka_producer_tx_prefix
// server_secret                                                          = var.server_secret
// spring_datasource_driver_class_name                                    = var.spring_datasource_driver_class_name
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_ddd_ecs_service_program_management"
// #connections
// #   outputs_alb_alb_public_app_backends_api_gateway                        = module.alb.alb_public_app_backends_api_gateway
// outputs_alb_listener_arn                                               = module.alb.aws_lb_listener_https
// outputs_cache_cache_entrypoint                                         = module.cache.cache_entrypoint
// outputs_cognito_cognito_app_pool_id                                    = module.cognito.cognito_app_pool_id
// outputs_db_db_main_entrypoint                                          = module.db.db_main_entrypoint
// outputs_ecs_ecs_main_cluster_arn                                       = module.ecs.ecs_main_cluster_arn
// outputs_ecs_ecs_main_cluster_name                                      = module.ecs.ecs_main_cluster_name
// outputs_ecs_service_api_gateway_sg_id                                  = module.ecs_service_api_gateway.api_gateway_sg_id
// outputs_kafka_bootstrap_brokers                                        = module.kafka.bootstrap_brokers
// outputs_s3_s3_bucket_name                                              = module.s3.s3_bucket_name
// outputs_service_discovery_service_discovery_private_dns_namespace_id   = module.service_discovery.service_discovery_private_dns_namespace_id
// outputs_sg_sg_alb_public_app_id                                        = module.sg.sg_alb_public_app_id
// outputs_sg_sg_cache_id                                                 = module.sg.sg_cache_id
// outputs_sg_sg_default_db_id                                            = module.sg.sg_default_db_id
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// output "ecs_service_program_management_task_role" {
//   value = module.ecs_service_program_management.ecs_service_task_role
// }
// output "ecs_service_program_management_task_execution_role" {
//   value = module.ecs_service_program_management.ecs_service_task_execution_role
// }
// output "ecs_service_program_management_td" {
//   value = module.ecs_service_program_management.ecs_service_td
// }
// output "ecs_service_program_management_ecr" {
//   value = module.ecs_service_program_management.ecs_service_ecr
// }
// output "ecs_service_program_management_service_name" {
//   value = module.ecs_service_program_management.ecs_service_service_name
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "ecs_service_tutor_onboarding_application" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.ecs_service_tutor_onboarding_application.data.aws_caller_identity.current
//       module.ecs_service_tutor_onboarding_application.data.aws_default_tags.default
//       module.ecs_service_tutor_onboarding_application.data.aws_subnet_ids.services_subnets
//       module.ecs_service_tutor_onboarding_application.aws_ecr_repository.ecr
//       module.ecs_service_tutor_onboarding_application.aws_iam_policy.task_execution_role_policy
//       module.ecs_service_tutor_onboarding_application.aws_iam_policy.task_role_policy
//       module.ecs_service_tutor_onboarding_application.aws_iam_role.task_execution_role
//       module.ecs_service_tutor_onboarding_application.aws_iam_role.task_role
//       module.ecs_service_tutor_onboarding_application.aws_iam_role_policy_attachment.task_execution_role_policy_attachment
//       module.ecs_service_tutor_onboarding_application.aws_iam_role_policy_attachment.task_role_policy_attachment
//       module.ecs_service_tutor_onboarding_application.aws_lb_listener_rule.api_rule_https
//       module.ecs_service_tutor_onboarding_application.aws_lb_target_group.api_tgt
//       module.ecs_service_tutor_onboarding_application.aws_security_group_rule.cache
//       module.ecs_service_tutor_onboarding_application.aws_security_group_rule.db
//       module.ecs_service_tutor_onboarding_application.aws_service_discovery_service.this
//       module.ecs_service_tutor_onboarding_application.aws_ssm_parameter.db_schema
//       module.ecs_service_tutor_onboarding_application.aws_ssm_parameter.kafka_producer_tx_prefix
//       module.ecs_service_tutor_onboarding_application.aws_ssm_parameter.region
//       module.ecs_service_tutor_onboarding_application.aws_ssm_parameter.server_base_url
//       module.ecs_service_tutor_onboarding_application.aws_ssm_parameter.server_domain
//       module.ecs_service_tutor_onboarding_application.aws_ssm_parameter.server_secret
//       module.ecs_service_tutor_onboarding_application.aws_ssm_parameter.spring_datasource_driver_class_name
//       module.ecs_service_tutor_onboarding_application.aws_ssm_parameter.spring_datasource_url
//       module.ecs_service_tutor_onboarding_application.aws_ssm_parameter.spring_profiles_active
//       module.ecs_service_tutor_onboarding_application.aws_ssm_parameter.users_topic_name
//       module.ecs_service_tutor_onboarding_application.random_id.exec_uniq
//       module.ecs_service_tutor_onboarding_application.random_id.s3
//       module.ecs_service_tutor_onboarding_application.random_id.task_uniq
//       module.ecs_service_tutor_onboarding_application.module.autoscaling.aws_appautoscaling_policy.cpu
//       module.ecs_service_tutor_onboarding_application.module.autoscaling.aws_appautoscaling_policy.memory
//       module.ecs_service_tutor_onboarding_application.module.autoscaling.aws_appautoscaling_target.target
//       module.ecs_service_tutor_onboarding_application.module.s3.data.aws_iam_policy_document.combined
//       module.ecs_service_tutor_onboarding_application.module.s3.data.aws_iam_policy_document.deny_insecure_transport
//       module.ecs_service_tutor_onboarding_application.module.s3.aws_s3_bucket.bucket
//       module.ecs_service_tutor_onboarding_application.module.s3.aws_s3_bucket_policy.bucket_policy[0]
//       module.ecs_service_tutor_onboarding_application.module.s3.aws_s3_bucket_public_access_block.bucket_access_block
//       module.ecs_service_tutor_onboarding_application.module.service.data.aws_caller_identity.current
//       module.ecs_service_tutor_onboarding_application.module.service.data.aws_default_tags.default
//       module.ecs_service_tutor_onboarding_application.module.service.aws_ecs_service.service
//       module.ecs_service_tutor_onboarding_application.module.service.random_string.suffix
//       module.ecs_service_tutor_onboarding_application.module.sg.data.aws_caller_identity.current
//       module.ecs_service_tutor_onboarding_application.module.sg.data.aws_default_tags.default
//       module.ecs_service_tutor_onboarding_application.module.sg.aws_security_group.sg
//       module.ecs_service_tutor_onboarding_application.module.task_def.data.aws_caller_identity.current
//       module.ecs_service_tutor_onboarding_application.module.task_def.data.aws_default_tags.default
//       module.ecs_service_tutor_onboarding_application.module.task_def.aws_ecs_task_definition.td
//     }
//   }
// */
// source                                                                 = "../_layers/40.services/5000.ddd_ecs_service_toa"
// first_run                                                              = var.first_run
// label                                                                  = module.label.tags
// boooknook_base_app_url                                                 = var.booknook_app_url
// external_dns_domain                                                    = var.external_dns_domain
// server_base_url                                                        = var.server_base_url
// server_domain                                                          = var.server_domain
// smoketest_emails                                                       = var.smoketest_emails
// spring_profiles_active                                                 = var.spring_profiles_active
// platform_name                                                          = var.platform_name
// phoenix_master_db_schema                                               = var.phoenix_master_db_schema
// server_secret                                                          = var.server_secret
// spring_datasource_url                                                  = var.spring_datasource_url
// spring_datasource_driver_class_name                                    = var.spring_datasource_driver_class_name
// ecs_toa_kafka_producer_tx_prefix                                       = var.ecs_toa_kafka_producer_tx_prefix
// ecs_toa_db_schema                                                      = var.ecs_toa_db_schema
// ecs_toa_users_topic_name                                               = var.ecs_toa_users_topic_name
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_ddd_ecs_service_toa"
// #connections
// #  outputs_alb_alb_public_app_backends_api_gateway                        = module.alb.alb_public_app_backends_api_gateway
// outputs_alb_listener_arn                                               = module.alb.aws_lb_listener_https
// outputs_db_db_main_entrypoint                                          = module.db.db_main_entrypoint
// outputs_ecs_ecs_main_cluster_arn                                       = module.ecs.ecs_main_cluster_arn
// outputs_ecs_ecs_main_cluster_name                                      = module.ecs.ecs_main_cluster_name
// outputs_ecs_service_api_gateway_sg_id                                  = module.ecs_service_api_gateway.api_gateway_sg_id
// outputs_kafka_bootstrap_brokers                                        = module.kafka.bootstrap_brokers
// outputs_service_discovery_service_discovery_private_dns_namespace_id   = module.service_discovery.service_discovery_private_dns_namespace_id
// outputs_sg_sg_alb_public_app_id                                        = module.sg.sg_alb_public_app_id
// outputs_sg_sg_cache_id                                                 = module.sg.sg_cache_id
// outputs_sg_sg_default_db_id                                            = module.sg.sg_default_db_id
// outputs_sg_sg_ecs_user_id                                              = module.ecs_service_user.sg_ecs_user_id
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// }
// output "ecs_service_toa_task_role" {
//   value = module.ecs_service_tutor_onboarding_application.ecs_service_task_role
// }
// output "ecs_service_toa_task_execution_role" {
//   value = module.ecs_service_tutor_onboarding_application.ecs_service_task_execution_role
// }
// output "ecs_service_toa_td" {
//   value = module.ecs_service_tutor_onboarding_application.ecs_service_td
// }
// output "ecs_service_toa_ecr" {
//   value = module.ecs_service_tutor_onboarding_application.ecs_service_ecr
// }
// output "ecs_service_toa_service_name" {
//   value = module.ecs_service_tutor_onboarding_application.ecs_service_service_name
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "ecs_service_user" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//     #resources
//     {
//       module.ecs_service_user.data.aws_caller_identity.current
//       module.ecs_service_user.data.aws_default_tags.default
//       module.ecs_service_user.data.aws_subnet_ids.services_subnets
//       module.ecs_service_user.aws_ecr_repository.ecr
//       module.ecs_service_user.aws_iam_policy.task_execution_role_policy
//       module.ecs_service_user.aws_iam_policy.task_role_policy
//       module.ecs_service_user.aws_iam_role.task_execution_role
//       module.ecs_service_user.aws_iam_role.task_role
//       module.ecs_service_user.aws_iam_role_policy_attachment.task_execution_role_policy_attachment
//       module.ecs_service_user.aws_iam_role_policy_attachment.task_role_policy_attachment
//       module.ecs_service_user.aws_lb_listener_rule.api_rule_https
//       module.ecs_service_user.aws_lb_target_group.api_tgt
//       module.ecs_service_user.aws_security_group_rule.cache
//       module.ecs_service_user.aws_security_group_rule.db
//       module.ecs_service_user.aws_security_group_rule.quartz
//       module.ecs_service_user.aws_service_discovery_service.this
//       module.ecs_service_user.aws_ssm_parameter.kafka_producer_tx_prefix
//       module.ecs_service_user.aws_ssm_parameter.region
//       module.ecs_service_user.aws_ssm_parameter.server_base_url
//       module.ecs_service_user.aws_ssm_parameter.server_domain
//       module.ecs_service_user.aws_ssm_parameter.server_secret
//       module.ecs_service_user.aws_ssm_parameter.service_user_platform_name
//       module.ecs_service_user.aws_ssm_parameter.spring_datasource_driver_class_name
//       module.ecs_service_user.aws_ssm_parameter.spring_datasource_url
//       module.ecs_service_user.aws_ssm_parameter.spring_profiles_active
//       module.ecs_service_user.aws_ssm_parameter.tutor_onboarding_application_uri
//       module.ecs_service_user.random_id.exec_uniq
//       module.ecs_service_user.random_id.task_uniq
//       module.ecs_service_user.module.autoscaling.aws_appautoscaling_policy.cpu
//       module.ecs_service_user.module.autoscaling.aws_appautoscaling_policy.memory
//       module.ecs_service_user.module.autoscaling.aws_appautoscaling_target.target
//       module.ecs_service_user.module.service.data.aws_caller_identity.current
//       module.ecs_service_user.module.service.data.aws_default_tags.default
//       module.ecs_service_user.module.service.aws_ecs_service.service
//       module.ecs_service_user.module.service.random_string.suffix
//       module.ecs_service_user.module.sg.data.aws_caller_identity.current
//       module.ecs_service_user.module.sg.data.aws_default_tags.default
//       module.ecs_service_user.module.sg.aws_security_group.sg
//       module.ecs_service_user.module.task_def.data.aws_caller_identity.current
//       module.ecs_service_user.module.task_def.data.aws_default_tags.default
//       module.ecs_service_user.module.task_def.aws_ecs_task_definition.td
//     }
//   }
// */
// source                                                                 = "../_layers/40.services/5000.ddd_ecs_service_user"
// first_run                                                              = var.first_run
// label                                                                  = module.label.tags
// boooknook_base_app_url                                                 = var.booknook_app_url
// external_dns_domain                                                    = var.external_dns_domain
// server_base_url                                                        = var.server_base_url
// server_domain                                                          = var.server_domain
// smoketest_emails                                                       = var.smoketest_emails
// spring_profiles_active                                                 = var.spring_profiles_active
// platform_name                                                          = var.platform_name
// phoenix_master_db_schema                                               = var.phoenix_master_db_schema
// server_secret                                                          = var.server_secret
// spring_datasource_url                                                  = var.spring_datasource_url
// spring_datasource_driver_class_name                                    = var.spring_datasource_driver_class_name
// ecs_user_kafka_producer_tx_prefix                                      = var.ecs_user_kafka_producer_tx_prefix
// tf_framework_component_version                                         = "${var.tf_framework_component_version}_ddd_ecs_service_user"
// #connections
// #  outputs_alb_alb_public_app_backends_api_gateway                        = module.alb.alb_public_app_backends_api_gateway
// outputs_alb_listener_arn                                               = module.alb.aws_lb_listener_https
// outputs_cache_cache_entrypoint                                         = module.cache.cache_entrypoint
// outputs_cognito_cognito_app_pool_id                                    = module.cognito.cognito_app_pool_id
// outputs_db_db_main_entrypoint                                          = module.db.db_main_entrypoint
// outputs_ecs_ecs_main_cluster_arn                                       = module.ecs.ecs_main_cluster_arn
// outputs_ecs_ecs_main_cluster_name                                      = module.ecs.ecs_main_cluster_name
// outputs_ecs_service_api_gateway_sg_id                                  = module.ecs_service_api_gateway.api_gateway_sg_id
// outputs_kafka_bootstrap_brokers                                        = module.kafka.bootstrap_brokers
// outputs_s3_s3_bucket_name                                              = module.s3.s3_bucket_name
// outputs_service_discovery_service_discovery_private_dns_namespace_id   = module.service_discovery.service_discovery_private_dns_namespace_id
// outputs_sg_sg_alb_public_app_id                                        = module.sg.sg_alb_public_app_id
// outputs_sg_sg_cache_id                                                 = module.sg.sg_cache_id
// outputs_sg_sg_default_db_id                                            = module.sg.sg_default_db_id
// outputs_sg_sg_quartz_db_id                                             = module.quartz.sg_default_db_id
// outputs_db_db_quartz_entrypoint                                        = module.quartz.db_quartz_entrypoint
// outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// outputs_sg_sg_ecs_payment_id                                           = module.ecs_service_payment.sg_ecs_payment_id
// outputs_sg_sg_ecs_import_id                                            = module.ecs_service_import.sg_ecs_import_id
// outputs_sg_sg_ecs_program_management_id                                = module.ecs_service_program_management.sg_ecs_program_management_id
// }
// output "ecs_service_user_task_role" {
//   value = module.ecs_service_user.ecs_service_task_role
// }
// output "ecs_service_user_task_execution_role" {
//   value = module.ecs_service_user.ecs_service_task_execution_role
// }
// output "ecs_service_user_td" {
//   value = module.ecs_service_user.ecs_service_td
// }
// output "ecs_service_user_ecr" {
//   value = module.ecs_service_user.ecs_service_ecr
// }
// output "ecs_service_user_service_name" {
//   value = module.ecs_service_user.ecs_service_service_name
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// # module "ecs_service_interview" {
// # /*
// #   {
// #     #general description
// #     {
// #       how to use it?
// #       -step 1
// #       -step 2
// #       -step 3
// #     }
// #     #dependencies Structure
// #     {
      
// #       ├── aws_msk_cluster
// #       │   ├── aws_vpc
// #       │   │   ├── aws_availability_zones
// #       │   │   ├── aws_subnet.1
// #       │   │   ├── aws_subnet.2
// #       │   │   ├── aws_subnet.3
// #       │   │   ├── aws_subnet.4
// #       │   ├── aws_security_group
// #       │   ├── aws_kms_key
// #       │   ├── aws_cloudwatch_log_group
// #       │   ├── aws_s3_bucket
// #       │   │   ├── aws_s3_bucket_acl
// #       │   └──|
// #       └──|
// #     }
// #     #resources
// #     {
// #       module.ecs_service_interview.data.aws_caller_identity.current
// #       module.ecs_service_interview.data.aws_default_tags.default
// #       module.ecs_service_interview.data.aws_subnet_ids.services_subnets
// #       module.ecs_service_interview.aws_ecr_repository.ecr
// #       module.ecs_service_interview.aws_iam_policy.task_execution_role_policy
// #       module.ecs_service_interview.aws_iam_policy.task_role_policy
// #       module.ecs_service_interview.aws_iam_role.task_execution_role
// #       module.ecs_service_interview.aws_iam_role.task_role
// #       module.ecs_service_interview.aws_iam_role_policy_attachment.task_execution_role_policy_attachment
// #       module.ecs_service_interview.aws_iam_role_policy_attachment.task_role_policy_attachment
// #       module.ecs_service_interview.aws_lb_listener_rule.api_rule_https
// #       module.ecs_service_interview.aws_lb_listener_rule.sparkhire
// #       module.ecs_service_interview.aws_lb_target_group.api_tgt
// #       module.ecs_service_interview.aws_security_group_rule.db
// #       module.ecs_service_interview.aws_service_discovery_service.this
// #       module.ecs_service_interview.aws_ssm_parameter.db_schema
// #       module.ecs_service_interview.aws_ssm_parameter.kafka_interview_update_topic_name
// #       module.ecs_service_interview.aws_ssm_parameter.kafka_interview_update_topic_partitions
// #       module.ecs_service_interview.aws_ssm_parameter.kafka_interview_update_topic_replicas
// #       module.ecs_service_interview.aws_ssm_parameter.sparkhire_basic_api_token
// #       module.ecs_service_interview.aws_ssm_parameter.sparkhire_basic_api_url
// #       module.ecs_service_interview.aws_ssm_parameter.sparkhire_basic_auth_password
// #       module.ecs_service_interview.aws_ssm_parameter.sparkhire_basic_auth_username
// #       module.ecs_service_interview.aws_ssm_parameter.sparkhire_basic_www_url
// #       module.ecs_service_interview.aws_ssm_parameter.sparkhire_interview_expiration_days
// #       module.ecs_service_interview.aws_ssm_parameter.sparkhire_job_uuid
// #       module.ecs_service_interview.aws_ssm_parameter.sparkhire_question_set_uuid
// #       module.ecs_service_interview.aws_ssm_parameter.sparkhire_timezone
// #       module.ecs_service_interview.aws_ssm_parameter.sparkhire_webhook_uuid
// #       module.ecs_service_interview.random_id.exec_uniq
// #       module.ecs_service_interview.random_id.task_uniq
// #       module.ecs_service_interview.module.autoscaling.aws_appautoscaling_policy.cpu
// #       module.ecs_service_interview.module.autoscaling.aws_appautoscaling_policy.memory
// #       module.ecs_service_interview.module.autoscaling.aws_appautoscaling_target.target
// #       module.ecs_service_interview.module.service.data.aws_caller_identity.current
// #       module.ecs_service_interview.module.service.data.aws_default_tags.default
// #       module.ecs_service_interview.module.service.aws_ecs_service.service
// #       module.ecs_service_interview.module.service.random_string.suffix
// #       module.ecs_service_interview.module.sg.data.aws_caller_identity.current
// #       module.ecs_service_interview.module.sg.data.aws_default_tags.default
// #       module.ecs_service_interview.module.sg.aws_security_group.sg
// #       module.ecs_service_interview.module.task_def.data.aws_caller_identity.current
// #       module.ecs_service_interview.module.task_def.data.aws_default_tags.default
// #       module.ecs_service_interview.module.task_def.aws_ecs_task_definition.td
// #     }
// #   }
// # */
// # source                                                                 = "../_layers/40.services/5000.ddd_ecs_service_interview"
// # first_run                                                              = var.first_run
// # label                                                                  = module.label.tags
// # spring_profiles_active                                                 = var.spring_profiles_active
// # platform_name                                                          = var.platform_name
// # ecs_interview_sparkhire_webhook_uuid                                   = var.ecs_interview_sparkhire_webhook_uuid
// # ecs_interview_sparkhire_basic_auth_password                            = var.ecs_interview_sparkhire_basic_auth_password
// # ecs_interview_sparkhire_basic_auth_username                            = var.ecs_interview_sparkhire_basic_auth_username
// # ecs_interview_sparkhire_timezone                                       = var.ecs_interview_sparkhire_timezone
// # ecs_interview_sparkhire_interview_expiration_days                      = var.ecs_interview_sparkhire_interview_expiration_days
// # ecs_interview_sparkhire_question_set_uuid                              = var.ecs_interview_sparkhire_question_set_uuid
// # ecs_interview_sparkhire_basic_api_token                                = var.ecs_interview_sparkhire_basic_api_token
// # ecs_interview_sparkhire_basic_api_url                                  = var.ecs_interview_sparkhire_basic_api_url
// # ecs_interview_sparkhire_basic_www_url                                  = var.ecs_interview_sparkhire_basic_www_url
// # ecs_interview_sparkhire_job_uuid                                       = var.ecs_interview_sparkhire_job_uuid
// # ecs_interview_kafka_interview_update_topic_replicas                    = var.ecs_interview_kafka_interview_update_topic_replicas
// # ecs_interview_kafka_interview_update_topic_partitions                  = var.ecs_interview_kafka_interview_update_topic_partitions
// # ecs_interview_kafka_interview_update_topic_name                        = var.ecs_interview_kafka_interview_update_topic_name
// # ecs_interview_db_schema                                                = var.ecs_interview_db_schema
// # tf_framework_component_version                                         = "${var.tf_framework_component_version}_ddd_ecs_service_interview"
// # #connections
// # outputs_alb_listener_arn                                               = module.alb.aws_lb_listener_https
// # outputs_db_db_main_entrypoint                                          = module.db.db_main_entrypoint
// # outputs_ecs_ecs_main_cluster_arn                                       = module.ecs.ecs_main_cluster_arn
// # outputs_ecs_ecs_main_cluster_name                                      = module.ecs.ecs_main_cluster_name
// # outputs_ecs_service_api_gateway_sg_id                                  = module.ecs_service_api_gateway.api_gateway_sg_id
// # outputs_kafka_bootstrap_brokers                                        = module.kafka.bootstrap_brokers
// # outputs_service_discovery_service_discovery_private_dns_namespace_id   = module.service_discovery.service_discovery_private_dns_namespace_id
// # outputs_sg_sg_alb_public_app_id                                        = module.sg.sg_alb_public_app_id
// # outputs_sg_sg_default_db_id                                            = module.sg.sg_default_db_id
// # outputs_vpc_vpc_id                                                     = module.vpc.vpc_id
// # }
// # output "ecs_service_interview_task_role" {
// #   value = module.ecs_service_interview.ecs_service_task_role
// # }
// # output "ecs_service_interview_task_execution_role" {
// #   value = module.ecs_service_interview.ecs_service_task_execution_role
// # }
// # output "ecs_service_interview_td" {
// #   value = module.ecs_service_interview.ecs_service_td
// # }
// # output "ecs_service_interview_ecr" {
// #   value = module.ecs_service_interview.ecs_service_ecr
// # }
// # output "ecs_service_interview_service_name" {
// #   value = module.ecs_service_interview.ecs_service_service_name
// # }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------




// ################################################################################
// ################################################################################
// #50.CiCd
// ################################################################################
// ################################################################################







// ################################################################################
// ################################################################################
// # 60.Etc
// ################################################################################
// ################################################################################




// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// # module "private_dns" {
// /*
//   {
//     #general description
//     {
//       how to use it?
//       -step 1
//       -step 2
//       -step 3
//     }
//     #dependencies Structure
//     {
      
//       ├── aws_msk_cluster
//       │   ├── aws_vpc
//       │   │   ├── aws_availability_zones
//       │   │   ├── aws_subnet.1
//       │   │   ├── aws_subnet.2
//       │   │   ├── aws_subnet.3
//       │   │   ├── aws_subnet.4
//       │   ├── aws_security_group
//       │   ├── aws_kms_key
//       │   ├── aws_cloudwatch_log_group
//       │   ├── aws_s3_bucket
//       │   │   ├── aws_s3_bucket_acl
//       │   └──|
//       └──|
//     }
//   }
// */
// #   source                                                                 = "../_layers/60.etc/100.private_dns"
// #   label                                                                  = module.label.tags
// #   external_dns_domain                                                    = var.external_dns_domain
// #   tf_framework_component_version                                         = "${var.tf_framework_component_version}_private_dns"
// #   #connections
// #   outputs_alb_alb_public_dns_name                                        = module.alb.alb_public_app_dns_name
// #   outputs_alb_alb_apl_private_hosted_zone_id                             = module.alb.alb_apl_private_hosted_zone_id
// #   outputs_vpc_r53_private_zone_id                                        = module.vpc.r53_private_zone_id
// #   outputs_cloudfront_hosted_zone                                         = module.cloudfront.cloudfront_distribution_hosted_zone_id
// #   outputs_cloudfront_domain_name                                         = module.cloudfront.cloudfront_distribution_domain_name
// # }
// # output "private_dns" {
// #   value = module.private_dns.
// # }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// # #module "monitoring" {}
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
// module "openvpn_marketplace" {
// #need to accept terms in marketplace
// source                          = "../_layers/60.etc/101.openvpn_marketplace"
// label                           = module.label.tags
// tf_framework_component_version  = "${var.tf_framework_component_version}_etc_openvpn_marketplace"
// #connections
// vpc_id                          = module.vpc.vpc_id
// public_subnet_ids               = module.vpc.public_subnets[0]
// }
// output "access_vpn_url" {
//   value = module.openvpn_marketplace.access_vpn_url
// }
// #--------------------------------------------------------------
// ################################################################
// #--------------------------------------------------------------
