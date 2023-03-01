resource "aws_appsync_resolver" "resolver" {
  api_id            = var.api_id
  field             = var.field
  type              = title("${var.type}")
  data_source       = local.dataSourceNameMap[var.data_source]
  request_template  = var.request_template
  response_template = var.response_template
  kind              = upper("${var.kind}")

  caching_config {
    caching_keys = [
      "$context.identity.sub",
      "$context.arguments.id",
    ]
    ttl = 60
  }
}
