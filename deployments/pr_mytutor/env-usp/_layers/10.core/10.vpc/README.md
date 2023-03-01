## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.13.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_framework_module_ver"></a> [framework\_module\_ver](#module\_framework\_module\_ver) | ../../../../libft/generic-modules/framework/module_ver | n/a |
| <a name="module_label"></a> [label](#module\_label) | ../../../../libft/generic-modules/null_label | n/a |
| <a name="module_main_vpc"></a> [main\_vpc](#module\_main\_vpc) | ../../../../libft/generic-modules/vpc | n/a |
| <a name="module_shared_config_cidr_vpn"></a> [shared\_config\_cidr\_vpn](#module\_shared\_config\_cidr\_vpn) | ../../../../libft/generic-modules/shared_config/cidr_ranges/vpn | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_default_tags.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [terraform_remote_state.cloud9](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.gitlab](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.route53](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.ses](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.workmail](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | -------------------------------------------------------------- General -------------------------------------------------------------- | `any` | n/a | yes |
| <a name="input_contact"></a> [contact](#input\_contact) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_external_dns_domain"></a> [external\_dns\_domain](#input\_external\_dns\_domain) | DNS domain to expose APP to external  (privileged networks in DEV/QA, WORLD for prod) | `string` | n/a | yes |
| <a name="input_peer_account"></a> [peer\_account](#input\_peer\_account) | we establish VPC peering VPN=>DEV env only. Account of the VPN vpcc | `string` | `"037564237295"` | no |
| <a name="input_peer_region"></a> [peer\_region](#input\_peer\_region) | we establish VPC peering VPN=>DEV env only. Region of the VPN vpcc | `string` | `"us-east-2"` | no |
| <a name="input_peer_vpc_id"></a> [peer\_vpc\_id](#input\_peer\_vpc\_id) | we establish VPC peering VPN=>DEV env only. VPC id of the vpn vpc | `string` | `"vpc-0b7be28cf8e307311"` | no |
| <a name="input_product"></a> [product](#input\_product) | n/a | `any` | n/a | yes |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | n/a | `any` | n/a | yes |
| <a name="input_tf_framework_component_version"></a> [tf\_framework\_component\_version](#input\_tf\_framework\_component\_version) | GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | -------------------------------------------------------------- VPC -------------------------------------------------------------- | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | A list of private subnet IDs. |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | A list of public subnet IDs. |
| <a name="output_r53_private_hosted_domain_zone_name"></a> [r53\_private\_hosted\_domain\_zone\_name](#output\_r53\_private\_hosted\_domain\_zone\_name) | The Hosted Zone domain name |
| <a name="output_r53_private_zone_id"></a> [r53\_private\_zone\_id](#output\_r53\_private\_zone\_id) | The Hosted Zone ID. This can be referenced by zone records |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The VPC IP range in CIDR format. |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | id of VPC created |
| <a name="output_vpc_nat_eips_cidr"></a> [vpc\_nat\_eips\_cidr](#output\_vpc\_nat\_eips\_cidr) | NAT EIPS - internet visible source ips for egress traffic, in cidr format |
