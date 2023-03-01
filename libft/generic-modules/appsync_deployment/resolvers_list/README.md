## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.resolvers_list](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [local_file.resolvers_list](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resolvers_dir"></a> [resolvers\_dir](#input\_resolvers\_dir) | Directory where resolver files rest | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_resolvers_list"></a> [resolvers\_list](#output\_resolvers\_list) | n/a |

## Example
```
module "be_resolvers_list" {
  source = "../../../generic-modules/appsync_deployment/resolvers_list"

  resolvers_dir = var.be_resolvers_dir
}
```
