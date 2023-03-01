module "service" {
  source                         = "../../../../../../libft/generic-modules/deployment/service"
  service_name                   = var.service_name
  cluster_name                   = var.outputs_ecs_ecs_main_cluster_arn
  td_arn                         = module.task_def.task_def_arn
  desired_count                  = local.autoscaling[var.label["Environment"]].autoscaling_desired_task_count
  network_subnets_ids            = data.aws_subnet_ids.services_subnets.ids
  network_security_groups        = [module.sg.sg_id]
  load_balancer_target_group_arn = aws_lb_target_group.api_tgt.arn
  tag_description                = var.tag_description
  service_additional_tags        = module.label.tags
  registry_arn                   = aws_service_discovery_service.this.arn
  label                          = module.label.tags
}
