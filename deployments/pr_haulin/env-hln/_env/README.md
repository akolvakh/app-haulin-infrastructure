## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm"></a> [acm](#module\_acm) | ../_layers/60.etc/17.acm | n/a |
| <a name="module_alb"></a> [alb](#module\_alb) | ../_layers/10.core/30.alb | n/a |
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ../_layers/10.core/25.bastion | n/a |
| <a name="module_cache"></a> [cache](#module\_cache) | ../_layers/10.core/30.cache | n/a |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | ../_layers/30.fe/55.cloudfront_web | n/a |
| <a name="module_cognito"></a> [cognito](#module\_cognito) | ../_layers/20.auth/35.cognito | n/a |
| <a name="module_db"></a> [db](#module\_db) | ../_layers/10.core/30.db | n/a |
| <a name="module_dns"></a> [dns](#module\_dns) | ../_layers/10.core/15.dns | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ../_layers/30.be/40.ecs | n/a |
| <a name="module_ecs_service_api_gateway"></a> [ecs\_service\_api\_gateway](#module\_ecs\_service\_api\_gateway) | ../_layers/40.services/5000.ddd_ecs_service_api_gateway | n/a |
| <a name="module_ecs_service_import"></a> [ecs\_service\_import](#module\_ecs\_service\_import) | ../_layers/40.services/5000.ddd_ecs_service_import | n/a |
| <a name="module_ecs_service_lesson_management"></a> [ecs\_service\_lesson\_management](#module\_ecs\_service\_lesson\_management) | ../_layers/40.services/5000.ddd_ecs_service_lesson_management | n/a |
| <a name="module_ecs_service_message_bus"></a> [ecs\_service\_message\_bus](#module\_ecs\_service\_message\_bus) | ../_layers/40.services/5000.ddd_ecs_service_message_bus | n/a |
| <a name="module_ecs_service_payment"></a> [ecs\_service\_payment](#module\_ecs\_service\_payment) | ../_layers/40.services/5000.ddd_ecs_service_payment | n/a |
| <a name="module_ecs_service_program_management"></a> [ecs\_service\_program\_management](#module\_ecs\_service\_program\_management) | ../_layers/40.services/5000.ddd_ecs_service_program_management | n/a |
| <a name="module_ecs_service_tutor_onboarding_application"></a> [ecs\_service\_tutor\_onboarding\_application](#module\_ecs\_service\_tutor\_onboarding\_application) | ../_layers/40.services/5000.ddd_ecs_service_toa | n/a |
| <a name="module_ecs_service_user"></a> [ecs\_service\_user](#module\_ecs\_service\_user) | ../_layers/40.services/5000.ddd_ecs_service_user | n/a |
| <a name="module_framework_module_ver"></a> [framework\_module\_ver](#module\_framework\_module\_ver) | ../../../../libft/generic-modules/framework/module_ver | n/a |
| <a name="module_kafka"></a> [kafka](#module\_kafka) | ../_layers/10.core/30.kafka | n/a |
| <a name="module_label"></a> [label](#module\_label) | ../../../../libft/generic-modules/null_label | n/a |
| <a name="module_lambda_cognito_post_auth"></a> [lambda\_cognito\_post\_auth](#module\_lambda\_cognito\_post\_auth) | ../_layers/20.auth/33.lambda_cognito_post_auth | n/a |
| <a name="module_lambda_cognito_post_confirmation_admin"></a> [lambda\_cognito\_post\_confirmation\_admin](#module\_lambda\_cognito\_post\_confirmation\_admin) | ../_layers/20.auth/33.lambda_cognito_post_confirmation_admin | n/a |
| <a name="module_lambda_cognito_post_confirmation_kafka"></a> [lambda\_cognito\_post\_confirmation\_kafka](#module\_lambda\_cognito\_post\_confirmation\_kafka) | ../_layers/20.auth/33.lambda_cognito_post_confirmation_kafka | n/a |
| <a name="module_private_dns"></a> [private\_dns](#module\_private\_dns) | ../_layers/60.etc/100.private_dns | n/a |
| <a name="module_s3"></a> [s3](#module\_s3) | ../_layers/60.etc/56.s3 | n/a |
| <a name="module_secrets"></a> [secrets](#module\_secrets) | ../_layers/60.etc/20.secrets | n/a |
| <a name="module_service_discovery"></a> [service\_discovery](#module\_service\_discovery) | ../_layers/30.be/32.service_discovery | n/a |
| <a name="module_sg"></a> [sg](#module\_sg) | ../_layers/10.core/20.sg | n/a |
| <a name="module_static_ips"></a> [static\_ips](#module\_static\_ips) | ../_layers/10.core/20.static_ips | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../_layers/10.core/10.vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_tags.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | -------------------------------------------------------------- General -------------------------------------------------------------- | `any` | n/a | yes |
| <a name="input_booknook_app_url"></a> [booknook\_app\_url](#input\_booknook\_app\_url) | n/a | `any` | n/a | yes |
| <a name="input_booknook_base_app_url"></a> [booknook\_base\_app\_url](#input\_booknook\_base\_app\_url) | n/a | `any` | n/a | yes |
| <a name="input_contact"></a> [contact](#input\_contact) | n/a | `any` | n/a | yes |
| <a name="input_doc_link_base"></a> [doc\_link\_base](#input\_doc\_link\_base) | base url for wiki page holding documentation for the secret(s) | `string` | `"https://phoenix.atlassian.net/wiki/spaces/DOCUMENTAT/pages/471433238/Secrets+and+environment+specific+params"` | no |
| <a name="input_email_from_domain"></a> [email\_from\_domain](#input\_email\_from\_domain) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_external_dns_domain"></a> [external\_dns\_domain](#input\_external\_dns\_domain) | n/a | `any` | n/a | yes |
| <a name="input_parameter_additional_tags"></a> [parameter\_additional\_tags](#input\_parameter\_additional\_tags) | add here any additional tags you want assign to parameters created | `map(any)` | `{}` | no |
| <a name="input_product"></a> [product](#input\_product) | n/a | `any` | n/a | yes |
| <a name="input_server_base_url"></a> [server\_base\_url](#input\_server\_base\_url) | n/a | `any` | n/a | yes |
| <a name="input_server_domain"></a> [server\_domain](#input\_server\_domain) | n/a | `any` | n/a | yes |
| <a name="input_ses_aws_region"></a> [ses\_aws\_region](#input\_ses\_aws\_region) | n/a | `any` | n/a | yes |
| <a name="input_smoketest_emails"></a> [smoketest\_emails](#input\_smoketest\_emails) | -------------------------------------------------------------- Parameters -------------------------------------------------------------- | `string` | n/a | yes |
| <a name="input_sns_monthly_spend_limit"></a> [sns\_monthly\_spend\_limit](#input\_sns\_monthly\_spend\_limit) | n/a | `any` | n/a | yes |
| <a name="input_spring_profiles_active"></a> [spring\_profiles\_active](#input\_spring\_profiles\_active) | n/a | `any` | n/a | yes |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | n/a | `any` | n/a | yes |
| <a name="input_tf_framework_component_version"></a> [tf\_framework\_component\_version](#input\_tf\_framework\_component\_version) | GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_cloudfront_arn"></a> [acm\_cloudfront\_arn](#output\_acm\_cloudfront\_arn) | n/a |
| <a name="output_acm_loadbalancer_arn"></a> [acm\_loadbalancer\_arn](#output\_acm\_loadbalancer\_arn) | -------------------------------------------------------------- ACM -------------------------------------------------------------- |
| <a name="output_alb_apl_private_hosted_zone_id"></a> [alb\_apl\_private\_hosted\_zone\_id](#output\_alb\_apl\_private\_hosted\_zone\_id) | -------------------------------------------------------------- ALB -------------------------------------------------------------- |
| <a name="output_alb_dns"></a> [alb\_dns](#output\_alb\_dns) | n/a |
| <a name="output_bastion_ip"></a> [bastion\_ip](#output\_bastion\_ip) | -------------------------------------------------------------- Bastion -------------------------------------------------------------- |
| <a name="output_bootstrap_brokers"></a> [bootstrap\_brokers](#output\_bootstrap\_brokers) | n/a |
| <a name="output_cloudfront_distribution_domain_name"></a> [cloudfront\_distribution\_domain\_name](#output\_cloudfront\_distribution\_domain\_name) | -------------------------------------------------------------- FE -------------------------------------------------------------- |
| <a name="output_cloudfront_distribution_hosted_zone_id"></a> [cloudfront\_distribution\_hosted\_zone\_id](#output\_cloudfront\_distribution\_hosted\_zone\_id) | n/a |
| <a name="output_cloudfront_s3_name"></a> [cloudfront\_s3\_name](#output\_cloudfront\_s3\_name) | n/a |
| <a name="output_cognito_app_client_id"></a> [cognito\_app\_client\_id](#output\_cognito\_app\_client\_id) | n/a |
| <a name="output_cognito_app_pool_arn"></a> [cognito\_app\_pool\_arn](#output\_cognito\_app\_pool\_arn) | n/a |
| <a name="output_cognito_app_pool_endpoint"></a> [cognito\_app\_pool\_endpoint](#output\_cognito\_app\_pool\_endpoint) | n/a |
| <a name="output_cognito_app_pool_id"></a> [cognito\_app\_pool\_id](#output\_cognito\_app\_pool\_id) | -------------------------------------------------------------- Cognito -------------------------------------------------------------- |
| <a name="output_db_cluster_arn"></a> [db\_cluster\_arn](#output\_db\_cluster\_arn) | n/a |
| <a name="output_db_main_entrypoint"></a> [db\_main\_entrypoint](#output\_db\_main\_entrypoint) | -------------------------------------------------------------- DB -------------------------------------------------------------- |
| <a name="output_ecs_cluster"></a> [ecs\_cluster](#output\_ecs\_cluster) | -------------------------------------------------------------- ECS -------------------------------------------------------------- |
| <a name="output_ecs_service_api_gateway_ecr"></a> [ecs\_service\_api\_gateway\_ecr](#output\_ecs\_service\_api\_gateway\_ecr) | n/a |
| <a name="output_ecs_service_api_gateway_task_execution_role"></a> [ecs\_service\_api\_gateway\_task\_execution\_role](#output\_ecs\_service\_api\_gateway\_task\_execution\_role) | n/a |
| <a name="output_ecs_service_api_gateway_task_role"></a> [ecs\_service\_api\_gateway\_task\_role](#output\_ecs\_service\_api\_gateway\_task\_role) | -------------------------------------------------------------- ECS Service API Gateway -------------------------------------------------------------- |
| <a name="output_ecs_service_api_gateway_td"></a> [ecs\_service\_api\_gateway\_td](#output\_ecs\_service\_api\_gateway\_td) | n/a |
| <a name="output_ecs_service_import_ecr"></a> [ecs\_service\_import\_ecr](#output\_ecs\_service\_import\_ecr) | n/a |
| <a name="output_ecs_service_import_task_execution_role"></a> [ecs\_service\_import\_task\_execution\_role](#output\_ecs\_service\_import\_task\_execution\_role) | n/a |
| <a name="output_ecs_service_import_task_role"></a> [ecs\_service\_import\_task\_role](#output\_ecs\_service\_import\_task\_role) | -------------------------------------------------------------- ECS Service Import -------------------------------------------------------------- |
| <a name="output_ecs_service_import_td"></a> [ecs\_service\_import\_td](#output\_ecs\_service\_import\_td) | n/a |
| <a name="output_ecs_service_lesson_management_ecr"></a> [ecs\_service\_lesson\_management\_ecr](#output\_ecs\_service\_lesson\_management\_ecr) | n/a |
| <a name="output_ecs_service_lesson_management_task_execution_role"></a> [ecs\_service\_lesson\_management\_task\_execution\_role](#output\_ecs\_service\_lesson\_management\_task\_execution\_role) | n/a |
| <a name="output_ecs_service_lesson_management_task_role"></a> [ecs\_service\_lesson\_management\_task\_role](#output\_ecs\_service\_lesson\_management\_task\_role) | -------------------------------------------------------------- ECS Service Lesson Management -------------------------------------------------------------- |
| <a name="output_ecs_service_lesson_management_td"></a> [ecs\_service\_lesson\_management\_td](#output\_ecs\_service\_lesson\_management\_td) | n/a |
| <a name="output_ecs_service_message_bus_ecr"></a> [ecs\_service\_message\_bus\_ecr](#output\_ecs\_service\_message\_bus\_ecr) | n/a |
| <a name="output_ecs_service_message_bus_task_execution_role"></a> [ecs\_service\_message\_bus\_task\_execution\_role](#output\_ecs\_service\_message\_bus\_task\_execution\_role) | n/a |
| <a name="output_ecs_service_message_bus_task_role"></a> [ecs\_service\_message\_bus\_task\_role](#output\_ecs\_service\_message\_bus\_task\_role) | -------------------------------------------------------------- ECS Service Message Bus -------------------------------------------------------------- |
| <a name="output_ecs_service_message_bus_td"></a> [ecs\_service\_message\_bus\_td](#output\_ecs\_service\_message\_bus\_td) | n/a |
| <a name="output_ecs_service_payment_ecr"></a> [ecs\_service\_payment\_ecr](#output\_ecs\_service\_payment\_ecr) | n/a |
| <a name="output_ecs_service_payment_task_execution_role"></a> [ecs\_service\_payment\_task\_execution\_role](#output\_ecs\_service\_payment\_task\_execution\_role) | n/a |
| <a name="output_ecs_service_payment_task_role"></a> [ecs\_service\_payment\_task\_role](#output\_ecs\_service\_payment\_task\_role) | -------------------------------------------------------------- ECS Service Payment -------------------------------------------------------------- |
| <a name="output_ecs_service_payment_td"></a> [ecs\_service\_payment\_td](#output\_ecs\_service\_payment\_td) | n/a |
| <a name="output_ecs_service_program_management_ecr"></a> [ecs\_service\_program\_management\_ecr](#output\_ecs\_service\_program\_management\_ecr) | n/a |
| <a name="output_ecs_service_program_management_task_execution_role"></a> [ecs\_service\_program\_management\_task\_execution\_role](#output\_ecs\_service\_program\_management\_task\_execution\_role) | n/a |
| <a name="output_ecs_service_program_management_task_role"></a> [ecs\_service\_program\_management\_task\_role](#output\_ecs\_service\_program\_management\_task\_role) | -------------------------------------------------------------- ECS Service Program Management -------------------------------------------------------------- |
| <a name="output_ecs_service_program_management_td"></a> [ecs\_service\_program\_management\_td](#output\_ecs\_service\_program\_management\_td) | n/a |
| <a name="output_ecs_service_toa_ecr"></a> [ecs\_service\_toa\_ecr](#output\_ecs\_service\_toa\_ecr) | n/a |
| <a name="output_ecs_service_toa_task_execution_role"></a> [ecs\_service\_toa\_task\_execution\_role](#output\_ecs\_service\_toa\_task\_execution\_role) | n/a |
| <a name="output_ecs_service_toa_task_role"></a> [ecs\_service\_toa\_task\_role](#output\_ecs\_service\_toa\_task\_role) | -------------------------------------------------------------- ECS Service Tutor Onboarding Application -------------------------------------------------------------- |
| <a name="output_ecs_service_toa_td"></a> [ecs\_service\_toa\_td](#output\_ecs\_service\_toa\_td) | n/a |
| <a name="output_ecs_service_user_ecr"></a> [ecs\_service\_user\_ecr](#output\_ecs\_service\_user\_ecr) | n/a |
| <a name="output_ecs_service_user_task_execution_role"></a> [ecs\_service\_user\_task\_execution\_role](#output\_ecs\_service\_user\_task\_execution\_role) | n/a |
| <a name="output_ecs_service_user_task_role"></a> [ecs\_service\_user\_task\_role](#output\_ecs\_service\_user\_task\_role) | -------------------------------------------------------------- ECS Service User -------------------------------------------------------------- |
| <a name="output_ecs_service_user_td"></a> [ecs\_service\_user\_td](#output\_ecs\_service\_user\_td) | n/a |
| <a name="output_elasticache"></a> [elasticache](#output\_elasticache) | -------------------------------------------------------------- Elasticache -------------------------------------------------------------- |
| <a name="output_msk_cluster_arn"></a> [msk\_cluster\_arn](#output\_msk\_cluster\_arn) | -------------------------------------------------------------- Kafka -------------------------------------------------------------- |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | n/a |
| <a name="output_vpc_dns"></a> [vpc\_dns](#output\_vpc\_dns) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | -------------------------------------------------------------- VPC -------------------------------------------------------------- |
| <a name="output_zookeeper_connect_string"></a> [zookeeper\_connect\_string](#output\_zookeeper\_connect\_string) | n/a |
