## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_launch_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | (Required) App name. | `any` | n/a | yes |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | (Optional) Associate a public ip address with an instance in a VPC. | `bool` | `false` | no |
| <a name="input_count_size"></a> [count\_size](#input\_count\_size) | (Required) Whether to create launch configuration. | `number` | n/a | yes |
| <a name="input_ebs_block_device"></a> [ebs\_block\_device](#input\_ebs\_block\_device) | (Optional) Additional EBS block devices to attach to the instance. | `list(any)` | `[]` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | (Optional) If true, the launched EC2 instance will be EBS-optimized. | `bool` | `false` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | (Optional) Enables/disables detailed monitoring. This is enabled by default. | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | (Required) Environment. | `any` | n/a | yes |
| <a name="input_ephemeral_block_device"></a> [ephemeral\_block\_device](#input\_ephemeral\_block\_device) | (Optional) Customize Ephemeral (also known as 'Instance Store') volumes on the instance. | `list(any)` | `[]` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | (Optional) The IAM instance profile to associate with launched instances. | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | (Required) The EC2 image ID to launch. | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | (Required) The size of instance to launch. | `any` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | (Optional) The key name that should be used for the instance. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Creates a unique name beginning with the specified prefix. | `any` | n/a | yes |
| <a name="input_placement_tenancy"></a> [placement\_tenancy](#input\_placement\_tenancy) | (Optional) The tenancy of the instance. Valid values are 'default' or 'dedicated'. | `string` | `"default"` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | (Optional) Customize details about the root block device of the instance. | `list(any)` | `[]` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | (Required) A list of security group IDs to assign to the launch configuration. | `list(any)` | n/a | yes |
| <a name="input_spot_price"></a> [spot\_price](#input\_spot\_price) | (Optional) The price to use for reserving spot instances. | `number` | `0` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | (Optional) The user data to provide when launching the instance. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_launch_configuration_id"></a> [this\_launch\_configuration\_id](#output\_this\_launch\_configuration\_id) | The ID of the launch configuration. |
| <a name="output_this_launch_configuration_name"></a> [this\_launch\_configuration\_name](#output\_this\_launch\_configuration\_name) | The name of the launch configuration. |
