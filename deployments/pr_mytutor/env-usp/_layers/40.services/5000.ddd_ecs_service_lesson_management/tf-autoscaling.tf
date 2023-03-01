module "autoscaling" {
  source             = "../../../../../../libft/generic-modules/deployment/service/autoscaling_basic"
  autoscaling_config = local.autoscaling[var.label["Environment"]]
  #TODO
  resource_id        = "service/${var.outputs_ecs_ecs_main_cluster_name}/${var.label["Product"]}-${var.label["Environment"]}-ecs-service-${var.service_name}"
}
