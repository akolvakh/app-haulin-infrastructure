resource "aws_appconfig_environment" "this" {
  name           = "${var.appconfig_app_label}-environment"
  description    = "AppConfig Environment"
  application_id = aws_appconfig_application.this.id

  tags = merge(local.common_tags)
}

resource "aws_appconfig_application" "this" {
  name        = "${var.appconfig_app_label}-application"
  description = "AppConfig designed to store phoenix app configuration"

  tags = merge(local.common_tags)
}

resource "aws_appconfig_configuration_profile" "this" {
  application_id = aws_appconfig_application.this.id
  description    = "phoenix app Configuration Profile"
  name           = var.appconfig_app_label
  location_uri   = var.appconfig_profile_location

  tags = merge(local.common_tags)
}

resource "aws_appconfig_hosted_configuration_version" "this" {
  application_id           = aws_appconfig_application.this.id
  configuration_profile_id = aws_appconfig_configuration_profile.this.configuration_profile_id
  description              = "phoenix app Configuration Version"
  content_type             = var.content_type

  content = var.configuration_content
}

resource "aws_appconfig_deployment_strategy" "this" {
  name                           = "${var.appconfig_app_label}-deployment-strategy"
  description                    = "phoenix Appconfig Deployment Strategy"
  deployment_duration_in_minutes = 3
  growth_factor                  = 50
  growth_type                    = "LINEAR"
  replicate_to                   = "NONE"

  tags = merge(local.common_tags)
}

resource "aws_appconfig_deployment" "this" {
  application_id           = aws_appconfig_application.this.id
  configuration_profile_id = aws_appconfig_configuration_profile.this.configuration_profile_id
  configuration_version    = aws_appconfig_hosted_configuration_version.this.version_number
  deployment_strategy_id   = aws_appconfig_deployment_strategy.this.id
  description              = "Appconfig deployment"
  environment_id           = aws_appconfig_environment.this.environment_id

  tags = merge(local.common_tags)
}
