# -sg
# -alb
# -ecr
# -ecs
# -service
# -cicd
# -etc


#--------------------------------------------------------------
# ECS Cluster
#--------------------------------------------------------------
/*
{
  #TODO
  // ref https://aws.amazon.com/blogs/containers/new-using-amazon-ecs-exec-access-your-containers-fargate-ec2/
  // debug containers supported kine "kubectl exec" just for AWS ECS. lets ue it
  @TBD 
   ref https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster
}
*/
resource "aws_ecs_cluster" "main" {
  name = "${module.label.id}_ecs_cluster"
  capacity_providers = ["FARGATE", "FARGATE_SPOT"]
  default_capacity_provider_strategy {
    capacity_provider = var.cluster_default_capacity_provider
    weight            = 100
  }
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = module.label.tags
}