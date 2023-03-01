# ECR Terraform Module for phoenix #

This Terraform module creates the base ecr infrastructure on AWS for phoenix App.

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
resource "aws_ecr_repository" "foo" {
  name                 = "bar"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
```

This simple example creates a repository policy:

```
resource "aws_ecr_repository" "foo" {
  name = "bar"
}

resource "aws_ecr_repository_policy" "foopolicy" {
  repository = aws_ecr_repository.foo.name

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}
```


### Example (module)

This more complete example creates an ecr module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "ecr_be" {
  source                  = "../ecr"

  app                     = "phoenix"
  env                     = "dev"
  ecr_name                = "${var.app}-${var.env}-ecr-be" //"${var.app}-${var.env}-ecr-be-${random_string.suffix.result}"
  ecr_kms_key             = module.ecr_kms_key.kms_arn
}
```


## Inputs

| Name                        | Description                                                                                                           | Type          | Default      | Required |
|-----------------------------|-----------------------------------------------------------------------------------------------------------------------|---------------|--------------|----------|
| app                         | App name                                                                                                              | `string`      | "phoenix"     | yes      |
| env                         | Environment                                                                                                           | `string`      | "dev"        | yes      |
| ecr\_name                   | Name of the repository                                                                                                | `string`      | "ecr-phoenix" | no      |
| ecr\_image\_tag\_mutability | The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`. Defaults to `MUTABLE`        | `string`      | "MUTABLE"    | no       |
| ecr\_tags                   | A map of tags to assign to the resource tags                                                                          | `map(string)` | n/a          | no       |
| isc\_scan\_on\_push         | Indicates whether images are scanned after being pushed to the repository (`true`) or not scanned (`false`)           | `bool`        | `false`      | no      |
| ecr\_encryption\_type       | The encryption type to use for the repository. Valid values are `AES256` or `KMS`                                     | `string`      | "AES256"     | no       |
| ecr\_kms\_key               | The ARN of the KMS key to use when encryption_type is KMS. If not specified, uses the default AWS managed key for ECR | `string`      | n/a          | yes       |

## Outputs

| Name               | Description               |
|--------------------|---------------------------|
| ecr_repository_url | URL of the ECR repository |
| ecr_repository_arn | ARN of the ECR repository |
| ecr_registry_id    | ID of the ECR registry    |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
