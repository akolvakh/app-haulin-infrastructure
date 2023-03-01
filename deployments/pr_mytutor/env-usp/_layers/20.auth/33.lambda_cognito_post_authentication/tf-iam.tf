#--------------------------------------------------------------
# Cognito endpoin protection
#--------------------------------------------------------------
# Add Lambda Assume Role
data "aws_iam_policy_document" "policy" {
  statement {
    sid = "ProxyLambdaCognitoAccess"
    actions = [
      "cognito-idp:AdminInitiateAuth",
      "cognito-idp:AdminRespondToAuthChallenge",
      "cognito-idp:*"
    ]
    resources = [
      # "arn:aws:cognito-idp:${var.aws_region}:${data.aws_caller_identity.current.account_id}:userpool/us-east-1_syKqUhcap"
      "*"
    ]
  }
  statement {
    sid = "RDSFullAccess"
    actions = [
      "rds:*",
      "application-autoscaling:DeleteScalingPolicy",
      "application-autoscaling:DeregisterScalableTarget",
      "application-autoscaling:DescribeScalableTargets",
      "application-autoscaling:DescribeScalingActivities",
      "application-autoscaling:DescribeScalingPolicies",
      "application-autoscaling:PutScalingPolicy",
      "application-autoscaling:RegisterScalableTarget",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DeleteAlarms",
      "ec2:DescribeAccountAttributes",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeCoipPools",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeLocalGatewayRouteTablePermissions",
      "ec2:DescribeLocalGatewayRouteTables",
      "ec2:DescribeLocalGatewayRouteTableVpcAssociations",
      "ec2:DescribeLocalGateways",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcs",
      "ec2:GetCoipPoolUsage",
      "sns:ListSubscriptions",
      "sns:ListTopics",
      "sns:Publish",
      "logs:DescribeLogStreams",
      "logs:GetLogEvents",
      "outposts:GetOutpostInstanceTypes"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid = "RDSPiAccess"
    actions = [
      "pi:*"
    ]
    resources = [
      "arn:aws:pi:*:*:metrics/rds/*"
    ]
  }
  statement {
    sid = "ServiceLinkedRole"
    actions = [
      "iam:CreateServiceLinkedRole"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid = "EC2Access"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeNetworkInterfaces"
    ]
    resources = [
      "*"
    ]
  }
  #TODO
  #Add account number + lambda naming
  statement {
    sid = "LogGroupAccess"
    actions = [
      "logs:CreateLogGroup"
    ]
    resources = [
      "arn:aws:logs:${var.label["Region"]}:${data.aws_caller_identity.current.account_id}:*"
    ]
  }
  statement {
    sid = "LogsAccess"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${var.label["Region"]}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.func_name}:*"
    ]
  }
}

data "aws_iam_policy_document" "trust_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "secrets_policy" {
  statement {
    sid = "SecretsAccess"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    resources = [
      "arn:aws:secretsmanager:${var.label["Region"]}:${data.aws_caller_identity.current.account_id}:secret:${aws_secretsmanager_secret.this.name}*"
    ]
  }
  statement {
    sid = "SecretsListAccess"
    actions = [
      "secretsmanager:ListSecrets"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "policy" {
  name   = "${module.label.id}_${var.lambda_name}_policy_${random_id.policy.dec}"
  policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_policy" "secrets_policy" {
  name   = "${module.label.id}_${var.lambda_name}_secrets_policy_${random_id.policy.dec}"
  policy = data.aws_iam_policy_document.secrets_policy.json
}

resource "aws_iam_role_policy_attachment" "policy" {
  role       = aws_iam_role.role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "secret_policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.secrets_policy.arn
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_role" "role" {
  name               = local.role_name
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.trust_policy.json
}











# data "aws_iam_policy_document" "cognito_proxy_secret_policy" {
#   statement {
#     sid    = "CognitoProxySecretAccess"
#     effect = "Allow"
#     actions = [
#       "secretsmanager:GetSecretValue"
#     ]
#     principals {
#       type        = "AWS"
#       identifiers = [aws_iam_role.cognito_proxy_lambda_role.arn]
#     }
#     # resources = [data.terraform_remote_state.secrets.outputs.cognito_proxy_secret_arn]
#     resources = ["*"]
#   }
# }

# resource "aws_secretsmanager_secret_policy" "cognito_proxy_secret" {
#   secret_arn = data.terraform_remote_state.secrets.outputs.cognito_proxy_secret_arn
#   policy     = data.aws_iam_policy_document.cognito_proxy_secret_policy.json
# }
