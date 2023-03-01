## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_internal_sg"></a> [alb\_internal\_sg](#module\_alb\_internal\_sg) | ../../../../libft/generic-modules/sg | n/a |
| <a name="module_alb_public_admin_sg"></a> [alb\_public\_admin\_sg](#module\_alb\_public\_admin\_sg) | ../../../../libft/generic-modules/sg | n/a |
| <a name="module_alb_public_app_sg"></a> [alb\_public\_app\_sg](#module\_alb\_public\_app\_sg) | ../../../../libft/generic-modules/sg | n/a |
| <a name="module_bastion_sg"></a> [bastion\_sg](#module\_bastion\_sg) | ../../../../libft/generic-modules/sg | n/a |
| <a name="module_db_default_sg"></a> [db\_default\_sg](#module\_db\_default\_sg) | ../../../../libft/generic-modules/sg | n/a |
| <a name="module_ecs_per_service_sg"></a> [ecs\_per\_service\_sg](#module\_ecs\_per\_service\_sg) | ../../../../libft/generic-modules/sg | n/a |
| <a name="module_elasticache_sg"></a> [elasticache\_sg](#module\_elasticache\_sg) | ../../../../libft/generic-modules/sg | n/a |
| <a name="module_framework_module_ver"></a> [framework\_module\_ver](#module\_framework\_module\_ver) | ../../../../libft/generic-modules/framework/module_ver | n/a |
| <a name="module_kafka_sg"></a> [kafka\_sg](#module\_kafka\_sg) | ../../../../libft/generic-modules/sg | n/a |
| <a name="module_label"></a> [label](#module\_label) | ../../../../libft/generic-modules/null_label | n/a |
| <a name="module_rds_lambda_sg"></a> [rds\_lambda\_sg](#module\_rds\_lambda\_sg) | ../../../../libft/generic-modules/sg | n/a |
| <a name="module_shared_cidr_ranges_config"></a> [shared\_cidr\_ranges\_config](#module\_shared\_cidr\_ranges\_config) | ../../../../libft/generic-modules/shared_config/cidr_ranges/vpn | n/a |
| <a name="module_shared_team_ips"></a> [shared\_team\_ips](#module\_shared\_team\_ips) | ../../../../libft/generic-modules/shared_config/cidr_ranges/team | n/a |
| <a name="module_shared_top_level_config_ecs"></a> [shared\_top\_level\_config\_ecs](#module\_shared\_top\_level\_config\_ecs) | ../../../../libft/generic-modules/shared_config/ecs_services | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_tags.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_route_tables.rt_pub_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_route_tables.rt_pvt_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_route_tables.rt_svc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_tables) | data source |
| [aws_subnet.public_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet_ids.private_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.public_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appsync_ip_range"></a> [appsync\_ip\_range](#input\_appsync\_ip\_range) | AppSync demands all backends be internet visible! We have to reshape our Arch. This variable is a temp workaround, given release schedule, sadly | `string` | `"0.0.0.0/0"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | -------------------------------------------------------------- General -------------------------------------------------------------- | `any` | n/a | yes |
| <a name="input_contact"></a> [contact](#input\_contact) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | n/a | `any` | n/a | yes |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | set by framework on every resource being creatd, points to apllied version | `any` | n/a | yes |
| <a name="input_tf_framework_component_version"></a> [tf\_framework\_component\_version](#input\_tf\_framework\_component\_version) | current git tag or branch if tag unset. Set by framework | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_sg_alb_public_app_id"></a> [sg\_alb\_public\_app\_id](#output\_sg\_alb\_public\_app\_id) | security group of Main APP LB |
| <a name="output_sg_bastion_id"></a> [sg\_bastion\_id](#output\_sg\_bastion\_id) | security group of Bastion for RDS |
| <a name="output_sg_cache_id"></a> [sg\_cache\_id](#output\_sg\_cache\_id) | security group of APP/Admin Cache |
| <a name="output_sg_default_db_id"></a> [sg\_default\_db\_id](#output\_sg\_default\_db\_id) | security group of default DB |
| <a name="output_sg_ecs_service_names_2_sg_id_map"></a> [sg\_ecs\_service\_names\_2\_sg\_id\_map](#output\_sg\_ecs\_service\_names\_2\_sg\_id\_map) | map ecsServieName=>SecurityGroupID |
| <a name="output_sg_kafka_id"></a> [sg\_kafka\_id](#output\_sg\_kafka\_id) | security group of Kafka. |
| <a name="output_sg_rds_lambda_id"></a> [sg\_rds\_lambda\_id](#output\_sg\_rds\_lambda\_id) | security group of Kafka. |
