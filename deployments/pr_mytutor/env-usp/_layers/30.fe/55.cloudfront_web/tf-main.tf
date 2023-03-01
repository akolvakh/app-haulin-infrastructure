#--------------------------------------------------------------
# Cloudfront
#--------------------------------------------------------------
module "cloudfront" {
  depends_on = [
    module.fe
  ]
  source = "../../../../../../libft/generic-modules/cloudfront"
  comment             = "Web for Phoenix App"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "index.html"
  #TODO
  # To specify a web ACL created using the latest version of AWS WAF (WAFv2), use the ACL ARN, for example aws_wafv2_web_acl.example.arn.
  # To specify a web ACL created using AWS WAF Classic, use the ACL ID, for example aws_waf_web_acl.example.id
  # see: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution#web_acl_id
  # web_acl_id = aws_wafv2_web_acl.admin-ui.arn
  web_acl_id = ""
  logging_config = {
    bucket          = module.logs_bucket.bucket_regional_domain_name
    prefix          = "logs"
    include_cookies = false
  }
  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket = module.fe.s3_bucket_id
  }
  origin = {
    s3_one = {
      domain_name = module.fe.bucket_regional_domain_name
      origin_id   = "s3_one"
      s3_origin_config = {
        origin_access_identity = "s3_bucket" # key in `origin_access_identities`
      }
    }
  }
  custom_error_response = [
  {
    error_caching_min_ttl = 10
    error_code = 403
    response_code = 200
    response_page_path = "/index.html"
  },
]
  default_cache_behavior = {
    target_origin_id        = "s3_one"
    viewer_protocol_policy  = "redirect-to-https" 
                               //"https-only"
    allowed_methods         = ["GET", "HEAD", "OPTIONS", "PUT", "DELETE", "POST", "PATCH"]
    cached_methods          = ["GET", "HEAD"]
    compress                = true
    query_string            = true
    min_ttl                 = 0
    default_ttl             = 300
    max_ttl                 = 1800
    #TODO
    // why I get 403 when uncomment 3 lines below? Hey AWS? As far as index.html uncached - we arguably OK
    //cache_policy_id = aws_cloudfront_cache_policy.cache_on.id
    //response_headers_policy_id = aws_cloudfront_response_headers_policy.cache_on.id
    //use_forwarded_values = false
  }
  ordered_cache_behavior = [
    {
      path_pattern               = "/"
      target_origin_id           = "s3_one"
      viewer_protocol_policy     = "redirect-to-https" //"https-only"
      allowed_methods            = ["GET", "HEAD", "OPTIONS", "PUT", "DELETE", "POST", "PATCH"]
      cached_methods             = ["GET", "HEAD"]
      compress                   = true
      cache_policy_id            = aws_cloudfront_cache_policy.cache_off.id 
      response_headers_policy_id = aws_cloudfront_response_headers_policy.cache_off.id 
      use_forwarded_values       = false
    },
    {
      path_pattern               = "/index.html"
      target_origin_id           = "s3_one"
      viewer_protocol_policy     = "redirect-to-https" //"https-only"
      allowed_methods            = ["GET", "HEAD", "OPTIONS", "PUT", "DELETE", "POST", "PATCH"]
      cached_methods             = ["GET", "HEAD"]
      compress                   = true
      cache_policy_id            = aws_cloudfront_cache_policy.cache_off.id 
      response_headers_policy_id = aws_cloudfront_response_headers_policy.cache_off.id 
      use_forwarded_values       = false
    }
  ]
  viewer_certificate = {
    acm_certificate_arn            = var.outputs_acm_cloudfront_arn //aws_acm_certificate.this.arn //var.outputs_acm_cloudfront_arn //aws_acm_certificate.this.arn //var.outputs_acm_cloudfront_arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
  aliases = var.alias
}

resource "aws_cloudfront_cache_policy" "cache_off" {
  name        = "${module.label.id}_z_cache_off_policy"
  comment     = "cache disabled policy"
  default_ttl = 0
  max_ttl     = 0
  min_ttl     = 0
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_cache_policy" "cache_on" {
  name        = "${module.label.id}_z_cache_on_5_days_policy"
  comment     = "cache for 5 days policy"
  default_ttl = 432000
  max_ttl     = 432000
  min_ttl     = 432000
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_response_headers_policy" "cache_on" {
  name = "${module.label.id}_z_cache_off_policy"
  custom_headers_config {
    items {
      header   = "Cache-Control"
      override = true
      value    = "max-age=432000, s-max-age=432000,  public, private"
    }
  }
}

resource "aws_cloudfront_response_headers_policy" "cache_off" {
  name = "${module.label.id}_z_cache_on_policy"

  custom_headers_config {
    items {
      header   = "Cache-Control"
      override = true
      value    = "max-age=0, s-max-age=0,  no-cache, no-store, must-revalidate, proxy-revalidate"
    }
  }
}
