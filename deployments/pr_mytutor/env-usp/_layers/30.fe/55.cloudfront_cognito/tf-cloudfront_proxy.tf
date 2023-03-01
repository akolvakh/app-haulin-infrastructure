#TODO
#--------------------------------------------------------------
# Cloudfront proxy
#--------------------------------------------------------------
 module "cloudfront_cognito_proxy" {
   source = "../../../../libft/generic-modules/cloudfront"

   comment             = "Proxy for Cognito endpoint protection"
   enabled             = true
   is_ipv6_enabled     = true
   price_class         = "PriceClass_100"
   retain_on_delete    = false
   wait_for_deployment = false
   web_acl_id          = aws_wafv2_web_acl.main.arn

   origin = {
     cognito_proxy = {
       domain_name = "cognito-idp.${var.aws_region}.amazonaws.com"
       origin_id   = "cognito_proxy"

       custom_origin_config = {
         origin_ssl_protocols   = ["TLSv1"]
         origin_protocol_policy = "https-only"
         https_port             = "443"
         http_port              = "80"
       }
     }
   }

   default_cache_behavior = {
     target_origin_id       = "cognito_proxy"
     viewer_protocol_policy = "https-only"

     allowed_methods = ["GET", "HEAD", "OPTIONS", "DELETE", "PATCH", "POST", "PUT"]

     lambda_function_association = {

       # Valid keys: viewer-request, origin-request, viewer-response, origin-response
       origin-request = {
         lambda_arn   = data.terraform_remote_state.lambda_at_edge.outputs.lambda_cognito_proxy_qualified_arn
         include_body = "true"
       }
     }
   }

   tags = local.common_tags
 }