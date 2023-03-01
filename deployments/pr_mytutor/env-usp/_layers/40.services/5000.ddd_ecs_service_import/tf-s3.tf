#--------------------------------------------------------------
# S3
#--------------------------------------------------------------
resource "random_id" "s3" {
  byte_length = 4
}

module "s3" {
  source = "../../../../../../libft/generic-modules/s3-secure_bucket"
  server_side_encryption_configuration = {}
  bucket = "teachers-bucket-${var.label["Environment"]}-${random_id.s3.dec}"
            # substr(join(
            #    "-",
            #    [
            #      cv-bucket
            #      var.label["Environment"]
            #      module.label.id,
            #      random_id.s3.dec
            #    ],
            #  ), 0, 63)
  versioning = {
    enabled = true
  }
  create_policy = true
  tags = module.label.tags
}


#TODO

# resource "aws_s3_bucket_policy" "s3" {
#   bucket = module.s3.s3_bucket_id
#   policy = data.aws_iam_policy_document.combined.json
# }

# data "aws_iam_policy_document" "combined" {
#   source_policy_documents = [
#     data.aws_iam_policy_document.s3.json,
#     module.s3.secpolicy_predefined_json
#   ]
# }

# data "aws_iam_policy_document" "s3" {
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
#       "${module.s3.s3_bucket_arn}/*"
#     ]
#     effect = "Allow"
#   }
# }


