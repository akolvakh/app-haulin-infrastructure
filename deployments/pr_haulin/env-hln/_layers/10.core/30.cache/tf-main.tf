#--------------------------------------------------------------
# Cache
#--------------------------------------------------------------
module "cache" {
  source                     = "../../../../../../libft/generic-modules/elasticache"
  subnet_ids                 = data.aws_subnet_ids.cache_subnet.ids
  security_group_ids         = [var.outputs_sg_sg_cache_id]
  cluster_enabled            = var.cluster_enabled
  transit_encryption_enabled = true
  subnet_group_name          = "${var.label["Product"]}-${var.label["Environment"]}-subnet-group-name"
  tags                       = module.label.tags
}