#automize through iteration and outputs via mapping

#--------------------------------------------------------------
# ECR
#--------------------------------------------------------------
#resource "aws_ecr_repository" "ecr" {
#  name                 = "service_${var.service_name}"
#  image_tag_mutability = "MUTABLE"
#
#  image_scanning_configuration {
#    scan_on_push = true
#  }
#  encryption_configuration {
#    encryption_type = "AES256"
#    #TODO
#    //kms_key
#    // ECR uses server side encryptino only. I.e. it promises encrypt after you upload there and decrypt before you download from there
#    // default kms keey is AWS managed.
#  }
#  tags = module.label.tags
#}


#--------------------------------------------------------------
# ECR
#--------------------------------------------------------------
resource "aws_ecr_repository" "ecr" {
  # count                = ("dev" == var.environment) ? length(module.shared_ecs_services_config.service_names) : 0
  # count                = ("prod" == var.environment) ? length(module.shared_ecs_services_config.service_names) : 0
  count                = length(module.shared_ecs_services_config.service_names["${module.label.tags["Environment"]}"])
  name                 = "${module.label.tags["Product"]}_service_${element(module.shared_ecs_services_config.service_names["${module.label.tags["Environment"]}"], count.index)}"
  # name                 = "service_be"
  # name                 = module.label.id
  image_tag_mutability = "MUTABLE" // we want set LATEST tag from CI. Any security concern here?

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
    #TODO
    //kms_key
    // ECR uses server side encryptino only. I.e. it promises encrypt after you upload there and decrypt before you download from there
    // default kms keey is AWS managed.
  }
  tags = merge(module.label.tags, { "role" = "ecr_repo_${element(module.shared_ecs_services_config.service_names["${module.label.tags["Environment"]}"], count.index)}" })
}

module "ecr" {
  source             = "../../../../../../libft/generic-modules/ecr_image"
  dockerfile_name    = "Dockerfile"
  ecr_repository_url = "${data.aws_caller_identity.kms.account_id}.dkr.ecr.${${module.label.tags["Region"]}}.amazonaws.com/${module.label.tags["Product"]}_${var.service_name}"
  build_context      = "."
}

module "ecr_user" {
  source             = "../../../../../../libft/generic-modules/ecr_image"
  dockerfile_name    = "Dockerfile"
  ecr_repository_url = "${data.aws_caller_identity.kms.account_id}.dkr.ecr.${${module.label.tags["Region"]}}.amazonaws.com/${module.label.tags["Product"]}_service_user"
  build_context      = "."
}

module "ecr_import" {
source             = "../../../../../../libft/generic-modules/ecr_image"
dockerfile_name    = "Dockerfile"
ecr_repository_url = "${data.aws_caller_identity.kms.account_id}.dkr.ecr.${${module.label.tags["Region"]}}.amazonaws.com/${module.label.tags["Product"]}_service_import"
build_context      = "."
}

module "ecr_message-bus" {
source             = "../../../../../../libft/generic-modules/ecr_image"
dockerfile_name    = "Dockerfile"
ecr_repository_url = "${data.aws_caller_identity.kms.account_id}.dkr.ecr.${${module.label.tags["Region"]}}.amazonaws.com/${module.label.tags["Product"]}_service_message-bus"
build_context      = "."
}

module "ecr_program-management" {
source             = "../../../../../../libft/generic-modules/ecr_image"
dockerfile_name    = "Dockerfile"
ecr_repository_url = "${data.aws_caller_identity.kms.account_id}.dkr.ecr.${${module.label.tags["Region"]}}.amazonaws.com/${module.label.tags["Product"]}_service_program-management"
build_context      = "."
}

module "ecr_lesson-management" {
source             = "../../../../../../libft/generic-modules/ecr_image"
dockerfile_name    = "Dockerfile"
ecr_repository_url = "${data.aws_caller_identity.kms.account_id}.dkr.ecr.${${module.label.tags["Region"]}}.amazonaws.com/${module.label.tags["Product"]}_service_lesson-management"
build_context      = "."
}

module "ecr_lesson-management" {
source             = "../../../../../../libft/generic-modules/ecr_image"
dockerfile_name    = "Dockerfile"
ecr_repository_url = "${data.aws_caller_identity.kms.account_id}.dkr.ecr.${${module.label.tags["Region"]}}.amazonaws.com/${module.label.tags["Product"]}_service_api-gateway"
build_context      = "."
}

module "ecr_api-gateway" {
source             = "../../../../../../libft/generic-modules/ecr_image"
dockerfile_name    = "Dockerfile"
ecr_repository_url = "${data.aws_caller_identity.kms.account_id}.dkr.ecr.${${module.label.tags["Region"]}}.amazonaws.com/${module.label.tags["Product"]}_service_api-gateway"
build_context      = "."
}

module "ecr_payment" {
source             = "../../../../../../libft/generic-modules/ecr_image"
dockerfile_name    = "Dockerfile"
ecr_repository_url = "${data.aws_caller_identity.kms.account_id}.dkr.ecr.${${module.label.tags["Region"]}}.amazonaws.com/${module.label.tags["Product"]}_payment"
build_context      = "."
}

module "ecr_tutor-onboarding-application" {
source             = "../../../../../../libft/generic-modules/ecr_image"
dockerfile_name    = "Dockerfile"
ecr_repository_url = "${data.aws_caller_identity.kms.account_id}.dkr.ecr.${${module.label.tags["Region"]}}.amazonaws.com/${module.label.tags["Product"]}_tutor-onboarding-application"
build_context      = "."
}