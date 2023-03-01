#--------------------------------------------------------------
# ECR
#--------------------------------------------------------------
resource "aws_ecr_repository" "ecr" {
  name                 = "${module.label.tags["Product"]}_service_${var.service_name}"
  image_tag_mutability = "MUTABLE"

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
  tags = module.label.tags
}

module "ecr" {
  source             = "../../../../../../libft/generic-modules/ecr_image"
  count              = var.first_run ? 1 : 0
  dockerfile_name    = "Dockerfile"
  ecr_repository_url = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${module.label.tags["Region"]}.amazonaws.com/${module.label.tags["Product"]}_service_${var.service_name}"
  build_context      = "."
}