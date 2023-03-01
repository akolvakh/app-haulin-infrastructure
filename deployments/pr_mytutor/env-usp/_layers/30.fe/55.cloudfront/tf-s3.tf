#--------------------------------------------------------------
# S3
#--------------------------------------------------------------
resource "random_id" "cdn" {
  byte_length = 4
}

module "app_static" {
  source = "../../../../../../libft/generic-modules/s3/secure_bucket"
  server_side_encryption_configuration = {}
  bucket = substr(join(
    "-",
    [
      module.label.id,
      random_id.cdn.dec
    ],
  ), 0, 63)
  versioning = {
    enabled = true
  }
  create_policy = false
  tags = module.label.tags
}

resource "aws_s3_bucket_policy" "app_static" {
  bucket = module.app_static.s3_bucket_id
  policy = data.aws_iam_policy_document.combined.json
}

data "aws_iam_policy_document" "combined" {
  source_policy_documents = [
    data.aws_iam_policy_document.app_static.json,
    module.app_static.secpolicy_predefined_json
  ]
}

data "aws_iam_policy_document" "app_static" {
  statement {
    sid = "CloudFrontReadObjects"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${module.cloudfront_app_static.this_cloudfront_origin_access_identity_ids[0]}"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${module.app_static.s3_bucket_arn}/*"
    ]
    effect = "Allow"
  }
}
