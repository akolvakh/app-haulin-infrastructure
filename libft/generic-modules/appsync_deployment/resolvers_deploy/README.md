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
| [aws_appsync_resolver.resolver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_resolver) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_id"></a> [api\_id](#input\_api\_id) | Id of the AppSync API | `string` | n/a | yes |
| <a name="input_data_source"></a> [data\_source](#input\_data\_source) | AppSync data source | `string` | n/a | yes |
| <a name="input_field"></a> [field](#input\_field) | AppSync field | `string` | n/a | yes |
| <a name="input_kind"></a> [kind](#input\_kind) | AppSync kind | `string` | n/a | yes |
| <a name="input_request_template"></a> [request\_template](#input\_request\_template) | AppSync request template | `string` | n/a | yes |
| <a name="input_response_template"></a> [response\_template](#input\_response\_template) | AppSync response template | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | AppSync type | `string` | n/a | yes |

## Outputs

No outputs.

## Example
```
module "resolver" {
  source = "../../../generic-modules/appsync_deployment/resolvers_deploy"
  
  for_each   = {
    # for index, vm in local.array:
    for index, vm in data.terraform_remote_state.appsync_resolvers.outputs.be_resolvers_list:
    # for index, vm in var.asd:
    index => vm
    # OR: vm.name => vm (not always unique if names are the same)
    # OR: sha1(vm.name) vm => (not always unique if names are the same)
    # NOT: uuid() => vm (gets recreated everytime)
  }
  
  api_id            = data.terraform_remote_state.appsync.outputs.appsync_be_api_id
  data_source       = each.value.a0
  kind              = each.value.a1
  type              = each.value.a2
  field             = each.value.a3
  request_template  = file("${var.resolvers_dir}/${each.value.a0}.${each.value.a1}.${each.value.a2}.${each.value.a3}.request.txt")
  response_template = file("${var.resolvers_dir}/${each.value.a0}.${each.value.a1}.${each.value.a2}.${each.value.a3}.response.txt")

}
```
