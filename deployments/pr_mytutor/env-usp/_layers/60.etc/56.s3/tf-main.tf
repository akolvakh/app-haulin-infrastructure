#--------------------------------------------------------------
# S3
#--------------------------------------------------------------
resource "random_id" "this" {
  byte_length = 4
}

module "this" {
  source = "../../../../../../libft/generic-modules/s3-secure_bucket"
  server_side_encryption_configuration = {}
  bucket = substr(join(
    "-",
    [
      module.label.id,
      random_id.this.dec
    ],
  ), 0, 63)
  versioning = {
    enabled = true
  }
  create_policy = true
  tags = module.label.tags
}


#TODO

# resource "aws_s3_bucket_policy" "this" {
#   bucket = module.this.s3_bucket_id
#   policy = data.aws_iam_policy_document.combined.json
# }

# data "aws_iam_policy_document" "combined" {
#   source_policy_documents = [
#     data.aws_iam_policy_document.this.json,
#     module.this.secpolicy_predefined_json
#   ]
# }

# data "aws_iam_policy_document" "this" {
#   statement {
#     sid = "s3GetObject"
    
#     #TODO
#     #PRINCIPAL
#     principals {
#       type        = "AWS"
#       identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity "]
#     }

#     actions = [
#       "s3:GetObject"
#     ]

#     resources = [
#       "${module.this.s3_bucket_arn}/*"
#     ]
#     effect = "Allow"
#   }
# }
