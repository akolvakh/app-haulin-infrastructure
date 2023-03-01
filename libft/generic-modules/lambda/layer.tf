
resource "aws_lambda_layer_version" "lambda_layer" {
  count = var.create_layer ? 1 : 0

  layer_name          = var.layer_name
  filename            = var.layer_archive
  source_code_hash    = var.layer_sha256
  compatible_runtimes = [var.layer_version]
}