resource "random_id" "suffix" {
  byte_length = 8
}

resource "aws_lb_target_group" "ip2alb" {
  name               = substr(join("-", [local.name_prefix, random_id.suffix.dec]), 0, 32)
  port               = 443
  protocol           = "TLS"
  preserve_client_ip = true
  target_type        = "ip"
  health_check {
    enabled           = true
    healthy_threshold = 3
    path              = "/healthcheck"
    interval          = 30
    protocol          = "HTTPS"
    // non custmizable for NLB. timeout=10 sec
  }
  depends_on = [
    aws_lb.nlb
  ]
  lifecycle {
    create_before_destroy = true
  } //ref https://github.com/cloudposse/terraform-aws-alb-ingress/issues/24

  vpc_id = var.alb_vpc_id
  tags   = local.common_tags
}
