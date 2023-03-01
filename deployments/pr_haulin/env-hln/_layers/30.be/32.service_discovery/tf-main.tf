resource "aws_service_discovery_http_namespace" "this" {
  name = "${module.label.tags["Product"]}-${module.label.tags["Environment"]}"
  tags = module.label.tags
}

resource "aws_service_discovery_private_dns_namespace" "this" {
  name = "${module.label.tags["Environment"]}-ecs.${module.label.tags["Product"]}.internal"
  vpc  = var.outputs_vpc_vpc_id
  tags = module.label.tags
}
