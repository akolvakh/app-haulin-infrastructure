#------------------------------------------------------------------------------
# LB listener
#------------------------------------------------------------------------------
resource "aws_lb_listener" "http_forward" {
  load_balancer_arn = var.elb_arn
  port              = var.port

  #ToDo Check: CKV_AWS_2: "Ensure ALB protocol is HTTPS"
  #Uncheck security
  protocol = var.protocol
  //  protocol = "HTTPS"

  #ToDo Check: CKV_AWS_103: "Ensure that load balancer is using TLS 1.2"
  //  ssl_policy = var.ssl_policy
  //  ssl_policy = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"

  default_action {
    type             = var.da_type
    target_group_arn = var.aws_lb_target_group_main_arn
  }
}
