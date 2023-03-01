locals {
  module_version = "0.0.1"
  //we migrate from monilitic API to microservies(already), so got special case - microservice that wants listen "<public dns>/api/*" URL prefix
  uri_prefix_by_service_name_override = { "early_access" = "/early-access/*" }
  common = {
    Product       = data.aws_default_tags.default.tags["Product"]
    Contact       = data.aws_default_tags.default.tags["Contact"]
    Environment   = data.aws_default_tags.default.tags["Environment"]
    Orchestration = data.aws_default_tags.default.tags["Orchestration"]
  }
  common_tags = {
    "moduleVersion" = "phoenix-infrastructure/generic-modules/alb:${local.module_version}"
  }
}

