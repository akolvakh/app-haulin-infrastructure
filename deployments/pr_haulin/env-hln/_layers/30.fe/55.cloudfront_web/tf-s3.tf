#--------------------------------------------------------------
# S3
#--------------------------------------------------------------
resource "random_id" "bucket_prefix" {
  byte_length = 8
}

data "aws_iam_policy_document" "fe" {
  statement {
    sid = "cf to bucket objects ro access"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${module.cloudfront.this_cloudfront_origin_access_identity_ids[0]}"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${module.fe.s3_bucket_arn}/*"
    ]
    effect = "Allow"
  }
  statement {
    sid    = "denyInsecureTransport"
    effect = "Deny"

    actions = [
      "s3:*",
    ]

    resources = [
      module.fe.s3_bucket_arn,
      "${module.fe.s3_bucket_arn}/*",
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = module.fe.s3_bucket_id
  policy = data.aws_iam_policy_document.fe.json
}

module "fe" {
  source                               = "../../../../../../libft/generic-modules/s3-secure_bucket"
  create_policy                        = false
  server_side_encryption_configuration = {}
  bucket                               = "${module.label.id}-${random_id.bucket_prefix.dec}"
  tags                                 = module.label.tags
  versioning = {
    enabled = true
  }
}
  
module "logs_bucket" {
  source = "../../../../../../libft/generic-modules/s3-secure_bucket"
  bucket = "${module.label.id}-logs-${random_id.bucket_prefix.dec}"
  tags   = module.label.tags
  versioning = {
    enabled = true
  }
}
