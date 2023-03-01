#--------------------------------------------------------------
# WAF
#--------------------------------------------------------------
resource "aws_wafv2_ip_set" "admin-ui" {
  name               = "${module.label.id}_admin_ui"
  description        = "IP whitelist for Admin UI. Only ${module.label.tags["Product"]} VPN in all envs"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = var.label["Environment"] == "prod" ? var.outputs_vpc_vpc_nat_eips_cidr : concat(var.outputs_vpc_vpc_nat_eips_cidr, module.shared_team_ips.offices_external_cidrs)
  tags               = module.label.tags
}

resource "aws_wafv2_web_acl" "admin-ui" {
  name        = "${module.label.id}_admin_ui"
  description = "Admin UI entry point ip whitelist."
  scope       = "CLOUDFRONT"
  tags        = module.label.tags
  default_action {
    block {}
  }
  rule {
    name     = "rule-1"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.admin-ui.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "admin-ui"
      sampled_requests_enabled   = false
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "admin-ui"
    sampled_requests_enabled   = false
  }
}
