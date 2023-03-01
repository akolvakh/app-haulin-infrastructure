#------------------------------------------------------------------------------
# General
#------------------------------------------------------------------------------
resource "random_string" "suffix" {
  length  = 8
  special = false
}

#ToDo Finish replication configuration + more generic
#------------------------------------------------------------------------------
# S3 bucket
#------------------------------------------------------------------------------
resource "aws_s3_bucket" "bucket" {
  bucket_prefix = var.bucket_prefix
  acl           = var.acl

  versioning {
    enabled = var.versioning

    #ToDo Check: CKV_AWS_52: "Ensure S3 bucket has MFA delete enabled"
    mfa_delete = var.mfa_delete
  }

  logging {
    target_bucket = var.target_bucket
    target_prefix = var.target_prefix
  }


  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        #ToDo Check: CKV_AWS_145: "Ensure that S3 buckets are encrypted with KMS by default"
        //        kms_master_key_id = var.kms_master_key_id
        kms_master_key_id = aws_kms_key.examplekms.arn

        #ToDo Check: CKV_AWS_19: "Ensure all data stored in the S3 bucket is securely encrypted at rest"
        //        sse_algorithm     = "AES256"
        sse_algorithm = var.sse_algorithm
      }
    }
  }

  tags = {
    Name        = var.bucket_name
    Terraform   = true
    App         = var.app
    Environment = "${var.app}-${var.env}"
  }


  #ToDo Check: CKV_AWS_144: "Ensure that S3 bucket has cross-region replication enabled"
  replication_configuration {
    role = aws_iam_role.replication.arn

    rules {
      id     = "foobar"
      prefix = "foo"
      status = "Enabled"

      destination {
        bucket        = var.destination_replica_bucket_arn
        storage_class = "STANDARD"
      }
    }
  }

}


resource "aws_iam_role" "replication" {
  name = "tf-iam-role-replication-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "replication" {
  name = "tf-iam-role-policy-replication-policy"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.bucket.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete"
      ],
      "Effect": "Allow",
      "Resource": "${var.destination_replica_bucket_arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_kms_key" "examplekms" {
  description             = "KMS key 1"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}
