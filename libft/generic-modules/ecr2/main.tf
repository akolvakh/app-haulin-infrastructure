resource "aws_ecr_repository" "main" {
  count                = (true == var.ecr_enable) ? 1 : 0
  name                 = join(".", [var.tag_product, var.tag_role])
  image_tag_mutability = "IMMUTABLE" // we always deploy explicit version, never "latest". Is it too rigid? 

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
    //kms_key  
    // ECR uses server side encryption only. 
    // I.e. it promises encrypt after you upload there and decrypt before you download from there
    // so - what is added value? If entitlements miscofgiured,  THIS encryptino will not stop attacker 
    // default kms key is AWS managed. 
  }
  // TODO retention policy
  tags = merge(local.common_tags, { "role" = var.tag_role })
}
