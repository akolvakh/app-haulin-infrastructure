resource "random_id" "random_prefix" {
  byte_length = 8
}

resource "aws_wafv2_ip_set" "main" {
  name               = "${var.ip_set_name}-${random_id.random_prefix.dec}"
  description        = var.ip_set_description
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"

  addresses = var.ip_addresses

  tags = {
    Terraform = "true"
    Env       = "web"
  }
}

resource "aws_wafv2_web_acl" "main" {
  name        = "${var.waf_prefix}-rule-group"
  description = var.web_acl_description
  scope       = "CLOUDFRONT"

  default_action {
    block {}
  }

  rule {
    name     = var.rule_name
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.main.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${var.waf_prefix}-waf-rule-metric"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${var.waf_prefix}-waf-metric"
    sampled_requests_enabled   = false
  }

  tags = merge(local.common_tags, { "role" = var.tag_role })
}