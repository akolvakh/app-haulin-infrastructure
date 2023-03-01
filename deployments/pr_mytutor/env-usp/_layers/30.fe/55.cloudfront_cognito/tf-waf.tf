#--------------------------------------------------------------
# WAF
#--------------------------------------------------------------
resource "aws_wafv2_web_acl" "main" {
  name        = "${module.label.id}_acl"
  description = "Cognito CF Proxy Rate-limiting ACL"
  scope       = "CLOUDFRONT"
  tags        = module.label.tags
  default_action {
    allow {}
  }
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "${module.label.id}_cognito_proxy_ratelimit_acl"
    sampled_requests_enabled   = true
  }
  rule {
    name     = "rate-limit"
    priority = 0

    action {
      block {}
    }

    statement {
      rate_based_statement {
        aggregate_key_type = "IP"
        forwarded_ip_config {
          fallback_behavior = "NO_MATCH"
          header_name       = "X-Forwarded-For"
        }
        limit = "100" # maximum number of calls from a single IP address that are allowed within a 5 minute period
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "${module.label.id}_cognito_proxy_ratelimit"
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "denylist"
    priority = 0

    action {
      block {}
    }

    statement {
      or_statement {
        statement {
          ip_set_reference_statement {
          arn = aws_wafv2_ip_set.denylist.arn
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = join("-", [var.label["Product"], var.label["Environment"], "cognito-proxy-denylist"])
      sampled_requests_enabled   = true
    }
  }
  rule {
    name     = "allowlist"
    priority = 1

    action {
      block {}
    }

    statement {
      or_statement {
        statement {
          ip_set_reference_statement {
            arn = aws_wafv2_ip_set.allowlist.arn
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = join("-", [var.label["Product"], var.label["Environment"], "cognito-proxy-allowlist"])
      sampled_requests_enabled   = true
    }
  }
  lifecycle {
    ignore_changes = [
      rule
    ]
  }
}

resource "aws_wafv2_ip_set" "allowlist" {
   name               = join("-", [var.label["Product"], var.label["Environment"], "AllowListIPV4"])
   description        = "Allowlist for IPV4 addresses"
   scope              = "CLOUDFRONT"
   ip_address_version = "IPV4"
   addresses          = []
   tags                = module.label.tags
 }

resource "aws_wafv2_ip_set" "denylist" {
  name               = join("-", [var.label["Product"], var.label["Environment"], "DenyListIPV4"])
  description        = "Denylist for IPV4 addresses"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = []
  tags                = module.label.tags
 }