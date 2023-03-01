
resource "aws_iam_role" "codepipeline_role" {
  name = substr("${local.name_prefix}_role_${random_id.db.dec}", 0, 64)

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = substr("${local.name_prefix}_policy_${random_id.db.dec}", 0, 128)
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObjectAcl",
        "s3:PutObject"
      ],
      "Resource": [
        "${module.codepipeline_bucket.s3_bucket_arn}",
        "${module.codepipeline_bucket.s3_bucket_arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codestar-connections:UseConnection"
      ],
      "Resource": "${var.gh_connection_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "random_id" "db" {
  byte_length = 4
}
resource "aws_iam_role" "db_deploy_codebuild_role" {
  name = substr("${local.name_prefix}_codebuild_role_${random_id.db.dec}", 0, 64)

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}


data "aws_iam_policy_document" "codebuild_deploy_db" {
  statement {
    sid = "DiscoverMyS3"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
  }
  statement {
    sid = "ListMYS3Bucket"
    actions = [
      "s3:CreateBucket",
      "s3:GetObject",
      "s3:List*",
      "s3:PutObject"
    ]
    resources = [
      module.codepipeline_bucket.s3_bucket_arn,
      "${module.codepipeline_bucket.s3_bucket_arn}/*"
    ]
  }

  statement {
    sid = "ReadDBManagementCredentials"
    actions = [
      "secretsmanager:GetSecretValue",
    ]

    resources = [
      var.db_pswd_secret_arn
    ]
  }

  statement {
    sid = "GetSorucesFromMyS3Bucket"
    actions = [
      "s3:get*",
    ]

    resources = [
      "${module.codepipeline_bucket.s3_bucket_arn}",
      "${module.codepipeline_bucket.s3_bucket_arn}/*",
    ]
  }
  statement {
    sid = "AllowBuildLogs2CloudWatch"
    actions = [
      "logs:PutLogEvents",
      "logs:CreateLogStream",
      "logs:CreateLogGroup"
    ]

    resources = [
      "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:${local.name_prefix}-default-deploy-log_group:*",
      "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:${local.name_prefix}-default-deploy-log_group",
      "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:${local.name_prefix}-checkout-log_group:*",
      "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:${local.name_prefix}-checkout-log_group"
    ]
  }
  statement {
    sid = "AllowJoin2VPC4RDSConnectivity"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs"
    ]
    // TODO narrow permissions
    resources = [
      "*"
    ]
  }
  statement {
    sid = "AllowAttachNIC2TargetSubnet"
    actions = [
      "ec2:CreateNetworkInterfacePermission"
    ]
    resources = [
      "arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:network-interface/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "ec2:Subnet"
      values   = [for s in data.aws_subnet.db_subnet : s.arn]
    }
  }

  statement {
    sid       = "CodeStarUseConnection"
    actions   = ["codestar-connections:UseConnection"]
    resources = [var.gh_connection_arn]
  }
}


resource "aws_iam_role_policy" "codebuild_deploy_db" {
  name   = substr("${local.name_prefix}_default_codebuild-${random_id.db.dec}", 0, 128)
  role   = aws_iam_role.db_deploy_codebuild_role.name
  policy = data.aws_iam_policy_document.codebuild_deploy_db.json
}
