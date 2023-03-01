#--------------------------------------------------------------
# Target Groups
#--------------------------------------------------------------
resource "aws_lb_target_group" "api_tgt" {
  count = length(var.backends_api)


  name  = join("-", [local.common.Product, var.tag_role, count.index, "http"])
  # name  = join("-", [local.common.Product, var.tag_role, var.backends_api[count.index], "http"])
  # name  = join("-", ["pub", var.backends_api[count.index], "http"])
  # name  = join("-", [local.common.Product, var.tag_role, count.index, "https"])


  port  = 8080 // all APIs to use standard port
  // should encrypt internal traffic too, but SSL cert management overhead, outages caused by outdated certs, troubleshooting inconvenience
  // TBD

  protocol             = "HTTP"
  # protocol             = "HTTPS"


  target_type          = "ip" //for FARGATE compatiblity
  vpc_id               = var.alb_vpc_id
  deregistration_delay = 60

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "4"
    interval            = "65" // APP is very slow on start
    matcher             = "200"
    path                = "/actuator/health" // can we have stadard healthcheck path not tied to a Spring Framework specific? just "/health"??
    # path                = "/actuator/health" // can we have stadard healthcheck path not tied to a Spring Framework specific? just "/health"??

    port     = "traffic-port"
    protocol = "HTTP"
    # protocol = "HTTPS"
    timeout  = "60"
  }
  depends_on = [
    aws_lb.lb,
  ]
  lifecycle {
    create_before_destroy = true
  } //ref https://github.com/cloudposse/terraform-aws-alb-ingress/issues/24
  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          var.tag_role,
          local.common.Environment,
          "lb_target_group",
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.alb_additional_tags,
  )
}

# resource "aws_lb_target_group" "web_tgt" {
#   count = length(var.backends_web)
#   name  = join("-", [local.common.Product, var.tag_role, count.index])
#   port  = 8080 // all APIs to use standard port
#   // should encrypt internal traffic too, but SSL cert management overhead, outages caused by outdated certs, troubleshooting inconvenience
#   // TBD
#   protocol             = "HTTP"
#   target_type          = "ip" //for FARGATE compatiblity
#   vpc_id               = var.alb_vpc_id
#   deregistration_delay = 60

#   health_check {
#     healthy_threshold   = "5"
#     unhealthy_threshold = "2"
#     interval            = "30"
#     matcher             = "200"
#     path                = "/actuator/health" //"/health" // what is healthcheck path our java apps/services use, should be standard one

#     port     = "traffic-port"
#     protocol = "HTTP"
#     timeout  = "5"
#   }
#   depends_on = [
#     aws_lb.lb,
#   ]
#   tags = merge(
#     {
#       "Name" = join(
#         ".",
#         [
#           local.common.Product,
#           var.tag_role,
#           local.common.Environment,
#           "lb_target_group",
#         ],
#       )
#       "Description" = var.tag_description
#     },
#     local.common_tags,
#     var.alb_additional_tags,
#   )
# }
#
resource "aws_lb_target_group" "api_gateway_tgt" {
  name  = join("-", [local.common.Product, var.tag_role, "gtw", "http"])
  # name  = join("-", [local.common.Product, var.tag_role, count.index, "https"])
  port  = 8080 // all APIs to use standard port
  // should encrypt internal traffic too, but SSL cert management overhead, outages caused by outdated certs, troubleshooting inconvenience
  // TBD
  protocol             = "HTTP"
  # protocol             = "HTTPS"
  target_type          = "ip" //for FARGATE compatiblity
  vpc_id               = var.alb_vpc_id
  deregistration_delay = 60

  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "4"
    interval            = "65" // APP is very slow on start
    matcher             = "200"
    path                = "/actuator/health" // can we have stadard healthcheck path not tied to a Spring Framework specific? just "/health"??
    # path                = "/actuator/health" // can we have stadard healthcheck path not tied to a Spring Framework specific? just "/health"??

    port     = "traffic-port"
    protocol = "HTTP"
    # protocol = "HTTPS"
    timeout  = "60"
  }
  depends_on = [
    aws_lb.lb,
  ]
  lifecycle {
    create_before_destroy = true
  } //ref https://github.com/cloudposse/terraform-aws-alb-ingress/issues/24
  tags = merge(
    {
      "Name" = join(
        ".",
        [
          local.common.Product,
          var.tag_role,
          local.common.Environment,
          "lb_target_group",
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.alb_additional_tags,
  )
}
#--------------------------------------------------------------
# Listener Rules
#--------------------------------------------------------------
# resource "aws_lb_listener_rule" "api_rule" {
#   count = length(var.backends_api)

#   listener_arn = aws_lb_listener.http.arn
#   priority     = (count.index + 1) * 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.api_tgt.*.arn[count.index]
#   }

#   condition {
#     path_pattern {
#       values = [
#         contains(keys(local.uri_prefix_by_service_name_override), var.backends_api[count.index]) ? local.uri_prefix_by_service_name_override[var.backends_api[count.index]] : "${var.prefix_api}/${var.backends_api[count.index]}/*"
#       ]
#     }
#   }
#   tags = merge(
#     {
#       "Name" = join(
#         ".",
#         [
#           local.common.Product,
#           var.tag_role,
#           local.common.Environment,
#           "listenet_rule",
#         ],
#       )
#       "Description" = var.tag_description
#     },
#     local.common_tags,
#     var.alb_additional_tags,
#   )
# }




resource "aws_lb_listener_rule" "api_gateway_rule_https" {
  # listener_arn = aws_lb_listener.http.arn
  listener_arn = aws_lb_listener.https[0].arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_gateway_tgt.arn
  }

  condition {
    path_pattern {
      values = [
        # contains(keys(local.uri_prefix_by_service_name_override), var.backends_api[count.index]) ? local.uri_prefix_by_service_name_override[var.backends_api[count.index]] : "${var.prefix_api}/${var.backends_api[count.index]}/*"
        "/api*"
      ]
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
          "listenet_rule",
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.alb_additional_tags,
  )
}

resource "aws_lb_listener_rule" "api_rule_https" {
  count = length(var.backends_api)

  # listener_arn = aws_lb_listener.http.arn
  listener_arn = aws_lb_listener.https[0].arn
  priority     = (count.index + 1) * 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_tgt.*.arn[count.index]
  }

  # action {
  #   type = "fixed-response"

  #   fixed_response {
  #     content_type = "text/plain"
  #     message_body = "Resource is not found"
  #     status_code  = "404"
  #   }
  # }

  condition {
    path_pattern {
      values = [
        contains(keys(local.uri_prefix_by_service_name_override), var.backends_api[count.index]) ? local.uri_prefix_by_service_name_override[var.backends_api[count.index]] : "${var.prefix_api}/${var.backends_api[count.index]}/*"
        # "/api*"
      ]
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
          "listenet_rule",
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.alb_additional_tags,
  )
}

#resource "aws_lb_listener_rule" "web_rule" {
#  count = length(var.backends_web)
#
#  # listener_arn = aws_lb_listener.http.arn
#  listener_arn = aws_lb_listener.https[0].arn
#  //The priority for the rule between 1 and 50000. 1 is top. keep api with higher priority over web
#  priority = 25000 + ((count.index + 1) * 100)
#
#  action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.web_tgt.*.arn[count.index]
#  }
#
#  condition {
#    path_pattern {
#      values = [
#        "default" == "${var.backends_web[count.index]}" ? "${var.prefix_web}/*" : "${var.prefix_web}/${var.backends_web[count.index]}/*"
#        # "/api*"
#      ]
#    }
#  }
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
#}

resource "aws_lb_listener_rule" "swagger" {

  # count = var.environment == "staging" ? 1 : 0
  
  # listener_arn = aws_lb_listener.http.arn
  listener_arn = aws_lb_listener.https[0].arn
  # listener_arn = aws_lb_listener.https.arn
  
  priority = 1

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Resource is not found"
      status_code  = "404"
    }
  }

  condition {
    path_pattern {
      values = [
        "/api/be/internal/documentation/*"
      ]
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
          "listenet_rule",
        ],
      )
      "Description" = var.tag_description
    },
    local.common_tags,
    var.alb_additional_tags,
  )

}
