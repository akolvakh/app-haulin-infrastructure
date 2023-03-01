# IAM Terraform Module for phoenix #

This Terraform module creates the base iam infrastructure on AWS for phoenix App.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| aws  | n/a     |

## Resources

| Name |
|------|
|  |
|  |

## Structure
This module consists of next submodules (resources):
1. `submodule`
2. `resource`


## Usage

You can use this module to create a ...

### Example (resources)

This simple example creates a ... :

```
resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}
```


Example of Using Data Source for Assume Role Policy
```
data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance" {
  name               = "instance_role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}
```

Example of Exclusive Inline Policies
```
resource "aws_iam_role" "example" {
  name               = "yak_role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json # (not shown)

  inline_policy {
    name = "my_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["ec2:Describe*"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }

  inline_policy {
    name   = "policy-8675309"
    policy = data.aws_iam_policy_document.inline_policy.json
  }
}

data "aws_iam_policy_document" "inline_policy" {
  statement {
    actions   = ["ec2:DescribeAccountAttributes"]
    resources = ["*"]
  }
}
```

Example of Removing Inline Policies
```
resource "aws_iam_role" "example" {
  name               = "yak_role"
  assume_role_policy = data.aws_iam_policy_document.instance_assume_role_policy.json # (not shown)

  inline_policy {}
}
```

Example of Exclusive Managed Policies
```
resource "aws_iam_role" "example" {
  name                = "yak_role"
  assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json # (not shown)
  managed_policy_arns = [aws_iam_policy.policy_one.arn, aws_iam_policy.policy_two.arn]
}

resource "aws_iam_policy" "policy_one" {
  name = "policy-618033"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:Describe*"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_policy" "policy_two" {
  name = "policy-381966"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:ListAllMyBuckets", "s3:ListBucket", "s3:HeadBucket"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
```

Example of Removing Managed Policies
```
resource "aws_iam_role" "example" {
  name                = "yak_role"
  assume_role_policy  = data.aws_iam_policy_document.instance_assume_role_policy.json # (not shown)
  managed_policy_arns = []
}
```


This simple example creates an iam role policy attachment:

```
resource "aws_iam_role" "role" {
  name = "test-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy" {
  name        = "test-policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
```

### Example (module)

This more complete example creates an iam module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "td-execution-role" {
  source          = "../iam"

  app             = "phoenix"
  env             = "dev"
  region          = "us-east-1"
  inline_policy   = ""
}
```


## Inputs

| Name                               | Description                                                                                                                                                                                                                                                                                                                   | Type          | Default         | Required |
|------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-----------------|----------|
| app                                | App name                                                                                                                                                                                                                                                                                                                      | `string`      | "sytara"        | yes      |
| env                                | Environment                                                                                                                                                                                                                                                                                                                   | `string`      | "dev"           | yes      |
| region                             |                              Region                                                                                                                                                                                                                                                                                                 | `string`            | n/a             | yes       |
|description|Description of the role| `list(any)`            |"/"| no       |
|force_detach_policies|Whether to force detaching any policies the role has before destroying it. Defaults to false| `bool`            |`false`| no       |
|managed_policy_arns|Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource. When configured, Terraform will align the role's managed policy attachments with this set by attaching or detaching managed policies. Configuring an empty set (i.e., managed_policy_arns = []) will cause Terraform to remove all managed policy attachments Defaults to false| `list(string`            |["/"]| no       |
|max_session_duration|Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours| `number`            |3600| no       |
|name|Friendly name of the role. If omitted, Terraform will assign a random, unique name. See IAM Identifiers for more information| `string`            |"/"| yes       |
|name_prefix|Creates a unique friendly name beginning with the specified prefix. Conflicts with name| `string`            |"/"| no       |
|path|Path to the role. See IAM Identifiers for more information| `string`            |"/"| no       |
|permissions_boundary|ARN of the policy that is used to set the permissions boundary for the role| `string`            |"/"| no       |
|tags|Key-value mapping of tags for the IAM role| `map(string)`            |n/a| no       |
|*inline_policy| |             |n/a| no       |


## Outputs

| Name              | Description                                     |
|-------------------|-------------------------------------------------|
| arn      |Amazon Resource Name (ARN) specifying the role|
|created_date|Creation date of the IAM role|
|id|Name of the role|
|name|Name of the role|
|unique_id|Stable and unique string identifying the role|

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
