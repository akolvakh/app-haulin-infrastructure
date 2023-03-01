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
| <a name="module_alb_public_app"></a> [alb\_public\_app](#module\_alb\_public\_app) | ../../../../libft/generic-modules/alb | n/a |
| <a name="module_framework_module_ver"></a> [framework\_module\_ver](#module\_framework\_module\_ver) | ../../../../libft/generic-modules/framework/module_ver | n/a |
| <a name="module_label"></a> [label](#module\_label) | ../../../../libft/generic-modules/null_label | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_default_tags.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_subnet_ids.private_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [aws_subnet_ids.public_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [terraform_remote_state.acm_private_certificate](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.bastion](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.cloud9](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.dns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.gitlab](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.parameters](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.route53](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.secrets](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.ses](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.sg](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.static_ips](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.workmail](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | -------------------------------------------------------------- General -------------------------------------------------------------- | `any` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | (Optional) ARN of the default SSL server certificate. Exactly one certificate is required if the protocol is HTTPS. For adding additional SSL certificates, see the aws\_lb\_listener\_certificate resource | `string` | `null` | no |
| <a name="input_contact"></a> [contact](#input\_contact) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | n/a | `any` | n/a | yes |
| <a name="input_public_certificate_arn"></a> [public\_certificate\_arn](#input\_public\_certificate\_arn) | The ARN of AWS ACM certificate | `string` | `"arn:aws:acm:us-east-1:776131206689:certificate/d73ab1c6-bf66-49e3-9df6-ceb2b20f2656"` | no |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | link to AWS SSP parameter keeping git version of the module being deployed | `any` | n/a | yes |
| <a name="input_tf_framework_component_version"></a> [tf\_framework\_component\_version](#input\_tf\_framework\_component\_version) | GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | -------------------------------------------------------------- Networking -------------------------------------------------------------- | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_public_app_backends_api_gateway"></a> [alb\_public\_app\_backends\_api\_gateway](#output\_alb\_public\_app\_backends\_api\_gateway) | n/a |
| <a name="output_alb_public_app_backends_api_name_2_tgt_grp_map"></a> [alb\_public\_app\_backends\_api\_name\_2\_tgt\_grp\_map](#output\_alb\_public\_app\_backends\_api\_name\_2\_tgt\_grp\_map) | n/a |
| <a name="output_alb_public_app_backends_web_name_2_tgt_grp_map"></a> [alb\_public\_app\_backends\_web\_name\_2\_tgt\_grp\_map](#output\_alb\_public\_app\_backends\_web\_name\_2\_tgt\_grp\_map) | n/a |
| <a name="output_alb_public_app_dns_name"></a> [alb\_public\_app\_dns\_name](#output\_alb\_public\_app\_dns\_name) | -------------------------------------------------------------- ALB Public App -------------------------------------------------------------- |
| <a name="output_alb_public_app_security_groups"></a> [alb\_public\_app\_security\_groups](#output\_alb\_public\_app\_security\_groups) | security groups assigned to the public ALB |
| <a name="output_module_label_tags"></a> [module\_label\_tags](#output\_module\_label\_tags) | n/a |
| <a name="output_vpn_proxy_eips"></a> [vpn\_proxy\_eips](#output\_vpn\_proxy\_eips) | Static EIPs of VPN proxy, for product VPN only |
