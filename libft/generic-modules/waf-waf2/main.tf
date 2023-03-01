#------------------------------------------------------------------------------
# WAFv2
#------------------------------------------------------------------------------
resource "aws_wafv2_web_acl" "my_web_acl" {
  name  = var.waf_name
  scope = var.waf_scope

  default_action {
    allow {}
  }

  rule {
    name     = "RateLimit"
    priority = var.waf_priority

    action {
      block {}
    }

    statement {

      rate_based_statement {
        aggregate_key_type = var.waf_aggregate_key_type
        limit              = var.waf_rate_limit
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimit"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = var.waf_metric_name
    sampled_requests_enabled   = false
  }
}

#------------------------------------------------------------------------------
# WAFv2 Association
#------------------------------------------------------------------------------
resource "aws_wafv2_web_acl_association" "web_acl_association_my_lb" {
  resource_arn = var.waf_elb_arn
  web_acl_arn  = aws_wafv2_web_acl.my_web_acl.arn
}
