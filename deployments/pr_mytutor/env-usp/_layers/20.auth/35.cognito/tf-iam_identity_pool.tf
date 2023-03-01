data "aws_iam_policy_document" "cognito_admin_auth_role" {

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::*"
      # "arn:aws:s3:::${data.terraform_remote_state.cdn.outputs.cdn_bucket_name}/*"
    ]
  }
}

data "aws_iam_policy_document" "cognito_admin_auth_trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"
      values = [
        aws_cognito_identity_pool.admin_identity_pool.id
      ]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "cognito-identity.amazonaws.com:amr"
      values = [
        "authenticated"
      ]
    }
  }
}

resource "aws_iam_role" "cognito_admin_auth_role" {
  name               = "${module.label.tags["Product"]}_${var.label["Environment"]}_cognito_admin_auth_role_${random_id.ses_role_id.dec}"
  assume_role_policy = data.aws_iam_policy_document.cognito_admin_auth_trust.json
  tags               = merge(module.label.tags, { "role" = "cognito_admin_auth_role" })
}

resource "aws_iam_policy" "cognito_admin_auth_policy" {
  name        = "${module.label.tags["Product"]}_${var.label["Environment"]}_cognito_admin_auth_policy_${random_id.ses_role_id.dec}"
  description = "Identity Pool Authenticated role policy"
  policy      = data.aws_iam_policy_document.cognito_admin_auth_role.json
}

resource "aws_iam_role_policy_attachment" "cognito_admin_auth_policy_attachment" {
  role       = aws_iam_role.cognito_admin_auth_role.name
  policy_arn = aws_iam_policy.cognito_admin_auth_policy.arn
}

# Unauthenticated - required by the Identity Pool.

data "aws_iam_policy_document" "cognito_admin_unauth_role" {

  statement {
    effect = "Deny"
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = [
      "arn:aws:s3:::*"
      # "arn:aws:s3:::${data.terraform_remote_state.cdn.outputs.cdn_bucket_name}/*"
    ]
  }
}

data "aws_iam_policy_document" "cognito_admin_unauth_trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"
      values = [
        aws_cognito_identity_pool.admin_identity_pool.id
      ]
    }

    condition {
      test     = "ForAnyValue:StringLike"
      variable = "cognito-identity.amazonaws.com:amr"
      values = [
        "unauthenticated"
      ]
    }
  }
}

resource "aws_iam_role" "cognito_admin_unauth_role" {
  name               = "${module.label.tags["Product"]}_${var.label["Environment"]}_cgt_admn_unauth_role_${random_id.ses_role_id.dec}"
  assume_role_policy = data.aws_iam_policy_document.cognito_admin_unauth_trust.json
  tags               = merge(module.label.tags, { "role" = "cognito_admin_unauth_role" })
}

resource "aws_iam_policy" "cognito_admin_unauth_policy" {
  name        = "${module.label.tags["Product"]}_${var.label["Environment"]}_cognito_admin_unauth_policy_${random_id.ses_role_id.dec}"
  description = "Identity Pool Unauthenticated role policy"
  policy      = data.aws_iam_policy_document.cognito_admin_unauth_role.json
}

resource "aws_iam_role_policy_attachment" "cognito_admin_unauth_policy_attachment" {
  role       = aws_iam_role.cognito_admin_unauth_role.name
  policy_arn = aws_iam_policy.cognito_admin_unauth_policy.arn
}