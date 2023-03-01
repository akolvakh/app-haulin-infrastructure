#------------------------------------------------------------------------------
# ECR
#------------------------------------------------------------------------------
resource "aws_ecr_repository" "main" {
  name                 = var.ecr_name
  image_tag_mutability = var.ecr_image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.isc_scan_on_push
  }
  encryption_configuration {
    encryption_type = var.ecr_encryption_type
    kms_key         = var.ecr_kms_key
  }
}
