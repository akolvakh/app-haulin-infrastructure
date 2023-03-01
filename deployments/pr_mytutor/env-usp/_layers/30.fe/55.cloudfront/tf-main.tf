#55.mobile_app_cdn
#cloudfront
#web
#cdn

#--------------------------------------------------------------
# Cloudfront
#--------------------------------------------------------------
module "cloudfront_app_static" {
  depends_on = [
    module.cloudfront_app_static
  ]
  source = "../../../../../../libft/generic-modules/cloudfront"
  comment             = "${module.label.tags["Product"]} mobile app CDN"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_200"
  retain_on_delete    = false
  wait_for_deployment = false
  web_acl_id          = ""
  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket = module.cloudfront_app_static.s3_bucket_id
  }
  origin = {
    s3 = {
      #TODO
      # aws_s3_bucket.cloudfront_app_static.bucket_regional_domain_name
      domain_name = module.cloudfront_app_static.bucket_regional_domain_name
      origin_path = ""
      origin_id   = "s3"
      s3_origin_config = {
        origin_access_identity = "s3_bucket" # key in `origin_access_identities`
      }
    }
  }
  default_cache_behavior = {
    target_origin_id        = "s3"
    viewer_protocol_policy  = "redirect-to-https" //"https-only"
    allowed_methods         = ["GET", "HEAD", "OPTIONS", "PUT", "DELETE", "POST"]
    cached_methods          = ["GET", "HEAD"]
    compress                = true
    query_string            = true
    min_ttl                 = 0
    default_ttl             = 300
    max_ttl                 = 1800
  }
}
