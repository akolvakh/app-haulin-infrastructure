#--------------------------------------------------------------
# Target Groups
#--------------------------------------------------------------
resource "aws_lb_target_group" "api_tgt" {
  name  = "${module.label.tags["Environment"]}-${module.label.tags["Product"]}-toa-http"
          # "toa-http"
          # "${module.label.tags["Environment"]}-${module.label.tags["Product"]}-${var.service_name}-http"
  port  = 8080
  protocol             = "HTTP"
  target_type          = "ip"
  vpc_id               = var.outputs_vpc_vpc_id
  deregistration_delay = 60

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "4"
    interval            = "65"
    matcher             = "200"
    path                = "/actuator/health"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "60"
  }

  lifecycle {
    create_before_destroy = true
  }
  #  tags = merge(
  #    {
  #      "Name" = join(
  #        ".",
  #        [
  #          local.common.Product,
  #          var.tag_role,
  #          local.common.Environment,
  #          "lb_target_group",
  #        ],
  #      )
  #      "Description" = var.tag_description
  #    },
  #    local.common_tags,
  #    var.alb_additional_tags,
  #  )

}

#--------------------------------------------------------------
# Listener Rules
#--------------------------------------------------------------
resource "aws_lb_listener_rule" "api_rule_https" {
  listener_arn = var.outputs_alb_listener_arn
  priority     = (12 + 1) * 100
                 # (count.index + 1) * 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_tgt.arn
  }

  condition {
    path_pattern {
      values = [
        "/service/${var.service_name}/*"
      ]
    }
  }
  #  tags = merge(
  #    {
  #      "Name" = join(
  #        ".",
  #        [
  #          local.common.Product,
  #          var.tag_role,
  #          local.common.Environment,
  #          "listenet_rule",
  #        ],
  #      )
  #      "Description" = var.tag_description
  #    },
  #    local.common_tags,
  #    var.alb_additional_tags,
  #  )
}

