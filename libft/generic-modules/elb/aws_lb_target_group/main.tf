#------------------------------------------------------------------------------
# LB target group
#------------------------------------------------------------------------------
resource "aws_lb_target_group" "main" {
  name                 = var.name
  port                 = var.port
  protocol             = var.protocol
  vpc_id               = var.vpc_id
  target_type          = var.target_type
  deregistration_delay = var.target_deregistration_delay

  health_check {
    healthy_threshold   = var.hc_healthy_threshold
    interval            = var.hc_interval
    protocol            = var.hc_protocol
    matcher             = var.hc_matcher
    timeout             = var.hc_timeout
    path                = var.hc_healthcheck_path
    unhealthy_threshold = var.hc_unhealthy_threshold
  }
}
