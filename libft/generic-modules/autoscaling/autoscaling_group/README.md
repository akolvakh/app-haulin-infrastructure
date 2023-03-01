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
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app"></a> [app](#input\_app) | (Required) App name. | `any` | n/a | yes |
| <a name="input_default_cooldown"></a> [default\_cooldown](#input\_default\_cooldown) | (Optional) The amount of time, in seconds, after a scaling activity completes before another scaling activity can start. | `number` | `300` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | (Required) The number of Amazon EC2 instances that should be running in the group. | `number` | n/a | yes |
| <a name="input_enabled_metrics"></a> [enabled\_metrics](#input\_enabled\_metrics) | (Optional) A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances. | `list(any)` | <pre>[<br>  "GroupMinSize",<br>  "GroupMaxSize",<br>  "GroupDesiredCapacity",<br>  "GroupInServiceInstances",<br>  "GroupPendingInstances",<br>  "GroupStandbyInstances",<br>  "GroupTerminatingInstances",<br>  "GroupTotalInstances"<br>]</pre> | no |
| <a name="input_env"></a> [env](#input\_env) | (Required) Environment. | `any` | n/a | yes |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | (Optional) Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling. | `bool` | `false` | no |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | (Optional) Time (in seconds) after instance comes into service before checking health. | `number` | `300` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | (Required) Controls how health checking is done. Values are - EC2 and ELB. | `any` | n/a | yes |
| <a name="input_launch_configuration"></a> [launch\_configuration](#input\_launch\_configuration) | (Required) The name of the launch configuration to use. | `any` | n/a | yes |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | (Optional) A list of elastic load balancer names to add to the autoscaling group names. | `list(string)` | `[]` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | (Required) The maximum size of the auto scale group. | `number` | n/a | yes |
| <a name="input_metrics_granularity"></a> [metrics\_granularity](#input\_metrics\_granularity) | (Optional) The granularity to associate with the metrics to collect. The only valid value is 1Minute. | `string` | `"1Minute"` | no |
| <a name="input_min_elb_capacity"></a> [min\_elb\_capacity](#input\_min\_elb\_capacity) | (Optional) Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes. | `number` | `0` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | (Required) The minimum size of the auto scale group. | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) The name of the auto scaling group. | `any` | n/a | yes |
| <a name="input_placement_group"></a> [placement\_group](#input\_placement\_group) | (Optional) The name of the placement group into which you'll launch your instances, if any. | `string` | `""` | no |
| <a name="input_protect_from_scale_in"></a> [protect\_from\_scale\_in](#input\_protect\_from\_scale\_in) | (Optional) Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events. | `bool` | `false` | no |
| <a name="input_suspended_processes"></a> [suspended\_processes](#input\_suspended\_processes) | (Optional) A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resource. | `map(string)` | <pre>{<br>  "App": "phoenix",<br>  "Environment": "dev",<br>  "Name": "phoenix-autoscaling"<br>}</pre> | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | (Optional) A list of aws\_alb\_target\_group ARNs, for use with Application Load Balancing. | `list(string)` | `[]` | no |
| <a name="input_termination_policies"></a> [termination\_policies](#input\_termination\_policies) | (Optional) A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default. | `list(any)` | <pre>[<br>  "Default"<br>]</pre> | no |
| <a name="input_vpc_zone_identifier"></a> [vpc\_zone\_identifier](#input\_vpc\_zone\_identifier) | (Required) A list of subnet IDs to launch resources in. | `list(any)` | n/a | yes |
| <a name="input_wait_for_capacity_timeout"></a> [wait\_for\_capacity\_timeout](#input\_wait\_for\_capacity\_timeout) | (Optional) A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior. | `string` | `"10m"` | no |
| <a name="input_wait_for_elb_capacity"></a> [wait\_for\_elb\_capacity](#input\_wait\_for\_elb\_capacity) | (Optional) Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min\_elb\_capacity behavior. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_autoscaling_group_arn"></a> [this\_autoscaling\_group\_arn](#output\_this\_autoscaling\_group\_arn) | The ARN for this AutoScaling Group. |
| <a name="output_this_autoscaling_group_default_cooldown"></a> [this\_autoscaling\_group\_default\_cooldown](#output\_this\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity. |
| <a name="output_this_autoscaling_group_desired_capacity"></a> [this\_autoscaling\_group\_desired\_capacity](#output\_this\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group. |
| <a name="output_this_autoscaling_group_health_check_grace_period"></a> [this\_autoscaling\_group\_health\_check\_grace\_period](#output\_this\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health. |
| <a name="output_this_autoscaling_group_health_check_type"></a> [this\_autoscaling\_group\_health\_check\_type](#output\_this\_autoscaling\_group\_health\_check\_type) | EC2 or ELB. Controls how health checking is done. |
| <a name="output_this_autoscaling_group_id"></a> [this\_autoscaling\_group\_id](#output\_this\_autoscaling\_group\_id) | The autoscaling group id. |
| <a name="output_this_autoscaling_group_launch_configuration"></a> [this\_autoscaling\_group\_launch\_configuration](#output\_this\_autoscaling\_group\_launch\_configuration) | The launch configuration of the autoscale group. |
| <a name="output_this_autoscaling_group_max_size"></a> [this\_autoscaling\_group\_max\_size](#output\_this\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group. |
| <a name="output_this_autoscaling_group_min_size"></a> [this\_autoscaling\_group\_min\_size](#output\_this\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group. |
| <a name="output_this_autoscaling_group_name"></a> [this\_autoscaling\_group\_name](#output\_this\_autoscaling\_group\_name) | The autoscaling group name. |
| <a name="output_this_autoscaling_group_target_group_arns"></a> [this\_autoscaling\_group\_target\_group\_arns](#output\_this\_autoscaling\_group\_target\_group\_arns) | List of Target Group ARNs that apply to this AutoScaling Group. |
| <a name="output_this_autoscaling_group_vpc_zone_identifier"></a> [this\_autoscaling\_group\_vpc\_zone\_identifier](#output\_this\_autoscaling\_group\_vpc\_zone\_identifier) | The VPC zone identifier. |
