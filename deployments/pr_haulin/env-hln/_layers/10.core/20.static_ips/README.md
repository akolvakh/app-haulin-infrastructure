## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.16.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_framework_module_ver"></a> [framework\_module\_ver](#module\_framework\_module\_ver) | ../../../../libft/generic-modules/framework/module_ver | n/a |
| <a name="module_label"></a> [label](#module\_label) | ../../../../libft/generic-modules/null_label | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eip.nlb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_default_tags.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [terraform_remote_state.acm_private_certificate](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.cloud9](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.dns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.gitlab](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.route53](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.ses](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.workmail](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | -------------------------------------------------------------- General -------------------------------------------------------------- | `any` | n/a | yes |
| <a name="input_contact"></a> [contact](#input\_contact) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | n/a | `any` | n/a | yes |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | n/a | `any` | n/a | yes |
| <a name="input_tag_role"></a> [tag\_role](#input\_tag\_role) | n/a | `string` | `"public_static_ip"` | no |
| <a name="input_tf_framework_component_version"></a> [tf\_framework\_component\_version](#input\_tf\_framework\_component\_version) | GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_env_entrypoint_static_ips_cidr"></a> [env\_entrypoint\_static\_ips\_cidr](#output\_env\_entrypoint\_static\_ips\_cidr) |  |
| <a name="output_env_entrypoint_static_ips_ids"></a> [env\_entrypoint\_static\_ips\_ids](#output\_env\_entrypoint\_static\_ips\_ids) |  |
