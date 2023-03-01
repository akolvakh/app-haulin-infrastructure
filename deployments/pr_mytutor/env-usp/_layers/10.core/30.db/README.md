## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.13.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.1.3 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db_subnet_group"></a> [db\_subnet\_group](#module\_db\_subnet\_group) | ../../../../libft/generic-modules/rds_aurora/db_subnet_group | n/a |
| <a name="module_framework_module_ver"></a> [framework\_module\_ver](#module\_framework\_module\_ver) | ../../../../libft/generic-modules/framework/module_ver | n/a |
| <a name="module_label"></a> [label](#module\_label) | ../../../../libft/generic-modules/null_label | n/a |
| <a name="module_rds_aurora"></a> [rds\_aurora](#module\_rds\_aurora) | ../../../../libft/generic-modules/rds_aurora/rds_cluster | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_rds_cluster_parameter_group.rds_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_default_tags.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/default_tags) | data source |
| [aws_iam_session_context.ctx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_session_context) | data source |
| [aws_subnet_ids.db_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids) | data source |
| [terraform_remote_state.acm_private_certificate](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.bastion](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.cloud9](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.dns](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.gitlab](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.parameters](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.route53](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.s3](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.secrets](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.ses](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.sg](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.static_ips](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vpc](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.workmail](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_backup_region"></a> [aws\_backup\_region](#input\_aws\_backup\_region) | Region we store backups into | `string` | `"us-east-2"` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | -------------------------------------------------------------- General -------------------------------------------------------------- | `any` | n/a | yes |
| <a name="input_backup_additional_tags"></a> [backup\_additional\_tags](#input\_backup\_additional\_tags) | A map of additional tags, just tag/value pairs, to add to the backup module. | `map(string)` | <pre>{<br>  "Jira": "TECHGEN-4570"<br>}</pre> | no |
| <a name="input_backup_delete_after"></a> [backup\_delete\_after](#input\_backup\_delete\_after) | how long we keed backups? | `map` | <pre>{<br>  "dev": 1,<br>  "prod": "90",<br>  "qa": 1,<br>  "staging": "30"<br>}</pre> | no |
| <a name="input_contact"></a> [contact](#input\_contact) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_product"></a> [product](#input\_product) | n/a | `any` | n/a | yes |
| <a name="input_rds_db_scaling_auto_pause"></a> [rds\_db\_scaling\_auto\_pause](#input\_rds\_db\_scaling\_auto\_pause) | TBD | `bool` | `true` | no |
| <a name="input_rds_db_scaling_max_capacity"></a> [rds\_db\_scaling\_max\_capacity](#input\_rds\_db\_scaling\_max\_capacity) | TBD | `number` | `4` | no |
| <a name="input_rds_db_scaling_min_capacity"></a> [rds\_db\_scaling\_min\_capacity](#input\_rds\_db\_scaling\_min\_capacity) | TBD | `number` | `2` | no |
| <a name="input_rds_db_scaling_seconds_until_auto_pause"></a> [rds\_db\_scaling\_seconds\_until\_auto\_pause](#input\_rds\_db\_scaling\_seconds\_until\_auto\_pause) | TBD | `number` | `1800` | no |
| <a name="input_rds_db_scaling_timeout_action"></a> [rds\_db\_scaling\_timeout\_action](#input\_rds\_db\_scaling\_timeout\_action) | TBD | `string` | `"ForceApplyCapacityChange"` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Create backup(snapshot) before DB deleted? ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance | `bool` | `true` | no |
| <a name="input_tag_orchestration"></a> [tag\_orchestration](#input\_tag\_orchestration) | n/a | `any` | n/a | yes |
| <a name="input_tag_role"></a> [tag\_role](#input\_tag\_role) | n/a | `string` | `"primary_db"` | no |
| <a name="input_tf_framework_component_version"></a> [tf\_framework\_component\_version](#input\_tf\_framework\_component\_version) | GIT tag or branch if no tag vailable, identifying terraform source code version being run. Set by Makefile Framework | `any` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_cluster_arn"></a> [db\_cluster\_arn](#output\_db\_cluster\_arn) | ARN od RDS being created |
| <a name="output_db_main_entrypoint"></a> [db\_main\_entrypoint](#output\_db\_main\_entrypoint) | db url to connect to. Sample: product-dev-cluster-new.cluster-c8l0ihekb0ck.us-east-1.rds.amazonaws.com |
