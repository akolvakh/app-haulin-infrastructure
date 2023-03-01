## AUTHOR/VENDOR
- Copied from https://github.com/clouddrove/terraform-aws-elasticache
- @ALL When you copy a source code from Internet into phoenix code base, taking resposibility of supporting that code, pls add few words documentation, why we did so? Same when we use a 3rd party module


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0, < 0.15.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_replication_group.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_replication_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | (Optional) Specifies whether any modifications are applied immediately, or during the next maintenance window. Default is false. | `bool` | `false` | no |
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input\_at\_rest\_encryption\_enabled) | (Optional) Enable encryption at rest. | `bool` | `true` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | (Required) Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| <a name="input_auth_token"></a> [auth\_token](#input\_auth\_token) | (Optional) The password used to access a password protected server. Can be specified only if transit\_encryption\_enabled = true. | `string` | `"gihweisdjhewiuei"` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | (Optional) Specifies whether a minor engine upgrades will be applied automatically to the underlying Cache Cluster instances during the maintenance window. Defaults to true. | `bool` | `true` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | (Optional) Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. If true, Multi-AZ is enabled for this replication group. If false, Multi-AZ is disabled for this replication group. Must be enabled for Redis (cluster mode enabled) replication groups. Defaults to false. | `bool` | `false` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | (Required) A list of EC2 availability zones in which the replication group's cache clusters will be created. The order of the availability zones in the list is not important. | `list(string)` | n/a | yes |
| <a name="input_cluster_enabled"></a> [cluster\_enabled](#input\_cluster\_enabled) | (Optional) Enabled or disabled cluster. | `bool` | `false` | no |
| <a name="input_cluster_replication_enabled"></a> [cluster\_replication\_enabled](#input\_cluster\_replication\_enabled) | (Optional) (Redis only) Enabled or disabled replication\_group for redis cluster. | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) Description for the cache subnet group. Defaults to `Managed by Terraform`. | `string` | `"Managed by Terraform"` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | (Optional) Enable or disable of elasticache | `bool` | `true` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | (Optional) The name of the cache engine to be used for the clusters in this replication group. e.g. redis. | `string` | `""` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | (Optional) The version number of the cache engine to be used for the cache clusters in this replication group. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Required) Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_family"></a> [family](#input\_family) | (Required) The family of the ElastiCache parameter group. | `string` | `""` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | (Optional) The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. Can be specified only if at\_rest\_encryption\_enabled = true. | `string` | `""` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | (Optional) Maintenance window. | `string` | `"sun:05:00-sun:06:00"` | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | (Optional) ManagedBy, phoenix. | `string` | `"phoenix@phoenix.com"` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | (Optional) The compute and memory capacity of the nodes in the node group. | `string` | `"cache.t2.small"` | no |
| <a name="input_notification_topic_arn"></a> [notification\_topic\_arn](#input\_notification\_topic\_arn) | (Optional) An Amazon Resource Name (ARN) of an SNS topic to send ElastiCache notifications to. | `string` | `""` | no |
| <a name="input_num_cache_nodes"></a> [num\_cache\_nodes](#input\_num\_cache\_nodes) | (Required unless replication\_group\_id is provided) The initial number of cache nodes that the cache cluster will have. For Redis, this value must be 1. | `number` | `1` | no |
| <a name="input_num_node_groups"></a> [num\_node\_groups](#input\_num\_node\_groups) | (Optional) Number of Shards (nodes). | `string` | `""` | no |
| <a name="input_number_cache_clusters"></a> [number\_cache\_clusters](#input\_number\_cache\_clusters) | (Required for Cluster Mode Disabled) The number of cache clusters (primary and replicas) this replication group will have. If Multi-AZ is enabled, the value of this parameter must be at least 2. Updates will occur before other modifications. | `string` | `""` | no |
| <a name="input_parameter_group_name"></a> [parameter\_group\_name](#input\_parameter\_group\_name) | (Optional) The name of the parameter group to associate with this replication group. If this argument is omitted, the default cache parameter group for the specified engine is used. | `string` | `""` | no |
| <a name="input_port"></a> [port](#input\_port) | (Optional) the port number on which each of the cache nodes will accept connections. | `string` | `""` | no |
| <a name="input_replicas_per_node_group"></a> [replicas\_per\_node\_group](#input\_replicas\_per\_node\_group) | (Optional) Replicas per Shard. | `string` | `""` | no |
| <a name="input_replication_enabled"></a> [replication\_enabled](#input\_replication\_enabled) | (Optional) (Redis only) Enabled or disabled replication\_group for redis standalone instance. | `bool` | `false` | no |
| <a name="input_replication_group_id"></a> [replication\_group\_id](#input\_replication\_group\_id) | (Optional) The replication group identifier This parameter is stored as a lowercase string. | `string` | `""` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | (Required) Terraform current module repo. | `string` | `"https://registry.terraform.io/modules/clouddrove/elasticache/aws/0.14.0"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | (Optional) One or more VPC security groups associated with the cache cluster. | `list` | `[]` | no |
| <a name="input_security_group_names"></a> [security\_group\_names](#input\_security\_group\_names) | (Optional) A list of cache security group names to associate with this replication group. | `any` | `null` | no |
| <a name="input_snapshot_arns"></a> [snapshot\_arns](#input\_snapshot\_arns) | (Optional) A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. | `any` | `null` | no |
| <a name="input_snapshot_name"></a> [snapshot\_name](#input\_snapshot\_name) | (Optional) The name of a snapshot from which to restore data into the new node group. Changing the snapshot\_name forces a new resource. | `string` | `""` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | (Optional) (Redis only) The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. For example, if you set SnapshotRetentionLimit to 5, then a snapshot that was taken today will be retained for 5 days before being deleted. If the value of SnapshotRetentionLimit is set to zero (0), backups are turned off. Please note that setting a snapshot\_retention\_limit is not supported on cache.t1.micro or cache.t2.* cache nodes. | `any` | `null` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | (Optional) (Redis only) The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. The minimum snapshot window is a 60 minute period. | `any` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Optional) List of VPC Subnet IDs for the cache subnet group. | `list` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(any)` | `{}` | no |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | (Optional) Whether to enable encryption in transit. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Redis cluster id. |
| <a name="output_port"></a> [port](#output\_port) | Redis port. |
| <a name="output_redis_endpoint"></a> [redis\_endpoint](#output\_redis\_endpoint) | Redis endpoint address. |
| <a name="output_tags"></a> [tags](#output\_tags) | A mapping of tags to assign to the resource. |
