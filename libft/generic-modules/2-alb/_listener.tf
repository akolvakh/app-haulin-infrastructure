##########################
# TBD HTTPS listener and certs maangement
##########################


#########################
# HTTP listener
#########################

/**
We have to support HTTP for internet  -  just to redirect to HTTPS entry point
@TBD ADD SSL listener and cert management 
*/

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.http_port
  protocol          = "HTTP"

  # default_action {
  #   type = "fixed-response"

  #   fixed_response {
  #     content_type = "text/plain"
  #     message_body = "invalid URI in request"
  #     status_code  = "200"
  #   }
  # }
  
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  
  
  
  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          var.tag_role,
          local.common.Environment,
          "alb_listener",
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.alb_additional_tags,
  )
}

#########################
# HTTPS listener
#########################

resource "aws_lb_listener" "https" {
  count             = var.certificate_arn == null ? 0 : 1
  load_balancer_arn = aws_lb.lb.arn
  port              = var.https_port
  protocol          = "HTTPS"
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "invalid URI in request"
      status_code  = "200"
    }
  }
  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          var.tag_role,
          local.common.Environment,
          "https_alb_listener",
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.alb_additional_tags,
  )
}
