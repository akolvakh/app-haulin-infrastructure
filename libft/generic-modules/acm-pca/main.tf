# S3 Secure Bucket
data "aws_iam_policy_document" "acmpca_bucket_access" {
  statement {
    actions = [
      "s3:GetBucketAcl",
      "s3:GetBucketLocation",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = [
      "${module.s3_bucket.s3_bucket_arn}",
      "${module.s3_bucket.s3_bucket_arn}/*"
    ]

    principals {
      identifiers = ["acm-pca.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_s3_bucket_policy" "acmpca" {
  bucket = module.s3_bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.acmpca_bucket_access.json
}

module "s3_bucket" {
  source = "../../../generic-modules/s3/secure_bucket"
  bucket = replace("acmpca-${var.common_name}-${var.aws_account_id}", ".", "-")

  tags = merge(
    var.tags,
    {
      Name = "${var.backup_bucket_name_prefix}-${var.aws_region}-${data.aws_caller_identity.current.account_id}"
    },
    {
      Environment = "${var.environment}"
  })

}

resource "aws_acmpca_certificate_authority_certificate" "acmpca" {
  certificate_authority_arn = aws_acmpca_certificate_authority.acmpca.arn

  certificate       = aws_acmpca_certificate.acmpca.certificate
  certificate_chain = aws_acmpca_certificate.acmpca.certificate_chain
}

resource "aws_acmpca_certificate" "acmpca" {
  certificate_authority_arn   = aws_acmpca_certificate_authority.acmpca.arn
  certificate_signing_request = aws_acmpca_certificate_authority.acmpca.certificate_signing_request
  signing_algorithm           = "SHA512WITHRSA"

  template_arn = "arn:${data.aws_partition.current.partition}:acm-pca:::template/RootCACertificate/V1"

  validity {
    type  = "YEARS"
    value = 10
  }
}

resource "aws_acmpca_certificate_authority" "acmpca" {
  type = "ROOT"

  certificate_authority_configuration {
    key_algorithm     = "RSA_4096"
    signing_algorithm = "SHA512WITHRSA"

    subject {
      common_name         = var.common_name
      country             = var.country
      organization        = var.organization
      organizational_unit = var.organizational_unit
    }
  }
  revocation_configuration {
    crl_configuration {
      custom_cname       = "crl.${var.common_name}"
      enabled            = true
      expiration_in_days = 7
      s3_bucket_name     = aws_s3_bucket.acmpca.id
    }
  }

  depends_on = [aws_s3_bucket_policy.acmpca]
}

data "aws_partition" "current" {}
