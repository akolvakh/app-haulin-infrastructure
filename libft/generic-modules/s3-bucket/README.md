# S3 bucket Terraform Module for phoenix #

This Terraform module creates the base s3 bucket infrastructure on AWS for phoenix App.

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

This simple example creates a s3 bucket:

Private Bucket w/ Tags
```
resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
```

Static Website Hosting
```
resource "aws_s3_bucket" "b" {
  bucket = "s3-website-test.hashicorp.com"
  acl    = "public-read"
  policy = file("policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}
```

Using CORS
```
resource "aws_s3_bucket" "b" {
  bucket = "s3-website-test.hashicorp.com"
  acl    = "public-read"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://s3-website-test.hashicorp.com"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
```

Using versioning
```
resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}
```

Enable Logging
```
resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-tf-log-bucket"
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
}
```

Using object lifecycle
```
resource "aws_s3_bucket" "bucket" {
  bucket = "my-bucket"
  acl    = "private"

  lifecycle_rule {
    id      = "log"
    enabled = true

    prefix = "log/"

    tags = {
      rule      = "log"
      autoclean = "true"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA" # or "ONEZONE_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }
  }

  lifecycle_rule {
    id      = "tmp"
    prefix  = "tmp/"
    enabled = true

    expiration {
      date = "2016-01-12"
    }
  }
}

resource "aws_s3_bucket" "versioning_bucket" {
  bucket = "my-versioning-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    prefix  = "config/"
    enabled = true

    noncurrent_version_transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 90
    }
  }
}
```

Using replication configuration
```
provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias  = "central"
  region = "eu-central-1"
}

resource "aws_iam_role" "replication" {
  name = "tf-iam-role-replication-12345"

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
  name = "tf-iam-role-policy-replication-12345"

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
      "Resource": "${aws_s3_bucket.destination.arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "replication" {
  role       = aws_iam_role.replication.name
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_s3_bucket" "destination" {
  bucket = "tf-test-bucket-destination-12345"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "bucket" {
  provider = aws.central
  bucket   = "tf-test-bucket-12345"
  acl      = "private"

  versioning {
    enabled = true
  }

  replication_configuration {
    role = aws_iam_role.replication.arn

    rules {
      id     = "foobar"
      prefix = "foo"
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.destination.arn
        storage_class = "STANDARD"
      }
    }
  }
}
```

Enable Default Server Side Encryption
```
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "mybucket"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
```

Using ACL policy grants
```
data "aws_canonical_user_id" "current_user" {}

resource "aws_s3_bucket" "bucket" {
  bucket = "mybucket"

  grant {
    id          = data.aws_canonical_user_id.current_user.id
    type        = "CanonicalUser"
    permissions = ["FULL_CONTROL"]
  }

  grant {
    type        = "Group"
    permissions = ["READ", "WRITE"]
    uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
  }
}
```

### Example (module)

This more complete example creates a s3 bucket module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "s3" {
  source                                        = "../s3/bucket"

  allowed_methods                               = ""
  allowed_origins                               = ""
  app                                           = ""
  apply_server_side_encryption_by_default       = ""
  default_retention                             = ""
  destination                                   = ""
  destination_bucket                            = ""
  env                                           = ""
  grant_permissions                             = []
  grant_type                                    = ""
  index_document                                = ""
  lifecycle_rule_enabled                        = false
  mode                                          = ""
  noncurrent_version_expiration_days            = 0
  noncurrent_version_transition_days            = 0
  noncurrent_version_transition_storage_class   = ""
  object_lock_enabled                           = ""
  owner                                         = ""
  role                                          = ""
  rules                                         = ""
  server_side_encryption_configuration_rule     = ""
  sse_algorithm                                 = ""
  sse_kms_encrypted_objects_enabled             = false
  status                                        = ""
  storage_class                                 = ""
  target_bucket                                 = ""
}
```


## Inputs

| Name                                 | Description                                                                                                                                                                                                                                                                                                                    | Type          | Default       | Required |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------|----------|
| app                                  | App name                                                                                                                                                                                                                                                                                                                       | `string`      | "phoenix"      | yes      |
| env                                  | Environment                                                                                                                                                                                                                                                                                                                    | `string`      | "dev"         | yes      |
| bucket                                  | The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be less than or equal to 63 characters in length                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| bucket_prefix                                  | Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be less than or equal to 37 characters in length                                                                                                                                                                                                                                                                                                                    | `string`      | "bucket"         | no      |
| acl                                  | The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write. Defaults to private. Conflicts with grant                                                                                                                                                                                                                                                                                                                    | `string`      | "private"         | no      |
| grant                                  | An ACL policy grant (documented below). Conflicts with acl                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| policy                                  | A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide                                                                                                                                                                                                                                                                                                                    | `string`      | "{}"         | no      |
| **s3_tags                                  | A map of tags to assign to the bucket                                                                                                                                                                                                                                                                                                                    | `map(string)`      | n/a         | no      |
| force_destroy                                  | A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| acceleration_status                                  | Sets the accelerate configuration of an existing bucket. Can be Enabled or Suspended                                                                                                                                                                                                                                                                                                                    | `string`      | "Enabled"         | no      |
| request_payer                                  | Specifies who should bear the cost of Amazon S3 data transfer. Can be either BucketOwner or Requester. By default, the owner of the S3 bucket would incur the costs of any data transfer. See Requester Pays Buckets developer guide for more information                                                                                                                                                                                                                                                                                                                    | `string`      | "BucketOwner"         | no      |
| index_document                                  | Amazon S3 returns this index document when requests are made to the root domain or any of the subfolders                                                                                                                                                                                                                                                                                                                    | `string`      | n/a         | yes      |
| error_document                                  | An absolute path to the document to return in case of a 4XX error                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| redirect_all_requests_to                                  | A hostname to redirect all website requests for this bucket to. Hostname can optionally be prefixed with a protocol (http:// or https://) to use when redirecting requests. The default is the protocol that is used in the original request                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| routing_rules                                  | A json array containing routing rules describing redirect behavior and when redirects are applied                                                                                                                                                                                                                                                                                                                    | `string`      | "{}"         | no      |
| allowed_headers                                  | Specifies which headers are allowed                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| allowed_methods                                  | Specifies which methods are allowed. Can be GET, PUT, POST, DELETE or HEAD                                                                                                                                                                                                                                                                                                                    | `string`      | n/a         | yes      |
| allowed_origins                                  | Specifies which origins are allowed                                                                                                                                                                                                                                                                                                                    | `string`      | n/a         | yes      |
| expose_headers                                  | Specifies expose header in the response                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| max_age_seconds                                  | Specifies time in seconds that browser can cache the response for a preflight request                                                                                                                                                                                                                                                                                                                    | `number`      | 60         | no      |
| versioning_enabled                                  | Enable versioning. Once you version-enable a bucket, it can never return to an unversioned state. You can, however, suspend versioning on that bucket                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| mfa_delete                                  | Enable MFA delete for either Change the versioning state of your bucket or Permanently delete an object version. Default is false. This cannot be used to toggle this setting but is available to allow managed buckets to reflect the state in AWS                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| target_bucket                                  | The name of the bucket that will receive the log objects                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| target_prefix                                  | To specify a key prefix for log objects                                                                                                                                                                                                                                                                                                                    | `string`      |"log/"| no      |
| id                                  | Unique identifier for the rule. Must be less than or equal to 255 characters in length                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| prefix                                  | Object key prefix identifying one or more objects to which the rule applies                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| lifecycle_rule_tags                                  | A map of tags to assign to the bucket                                                                                                                                                                                                                                                                                                                    | `map(string)`      |n/a| no      |
| lifecycle_rule_enabled                                  | Specifies lifecycle rule status                                                                                                                                                                                                                                                                                                                    | `bool`      |n/a| yes      |
| abort_incomplete_multipart_upload_days                                  | Specifies the number of days after initiating a multipart upload when the multipart upload must be completed                                                                                                                                                                                                                                                                                                                    | `number`      |7| no      |
| expiration                                  | Specifies a period in the object's expire (documented below)                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| transition                                  | Specifies a period in the object's transitions (documented below)                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| noncurrent_version_expiration                                  | Specifies when noncurrent object versions expire (documented below)                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| noncurrent_version_transition                                  | Specifies when noncurrent object versions transitions (documented below)                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| expiration_date                                  | Specifies the date after which you want the corresponding action to take effect                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| expiration_days                                  | Specifies the number of days after object creation when the specific rule action takes effect                                                                                                                                                                                                                                                                                                                    | `number`      |7| no      |
| expired_object_delete_marker                                  | On a versioned bucket (versioning-enabled or versioning-suspended bucket), you can add this element in the lifecycle configuration to direct Amazon S3 to delete expired object delete markers. This cannot be specified with Days or Date in a Lifecycle Expiration Policy                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| transition_date                                  | Specifies the date after which you want the corresponding action to take effect                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| transition_days                                  | Specifies the number of days after object creation when the specific rule action takes effect                                                                                                                                                                                                                                                                                                                    | `number`      |7| no      |
| storage_class                                  | Specifies the Amazon S3 storage class to which you want the object to transition. Can be ONEZONE_IA, STANDARD_IA, INTELLIGENT_TIERING, GLACIER, or DEEP_ARCHIVE                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| noncurrent_version_expiration_days                                  | Specifies the number of days noncurrent object versions expire                                                                                                                                                                                                                                                                                                                    | `number`      |n/a| yes      |
| noncurrent_version_transition_days                                  | Specifies the number of days noncurrent object versions transition                                                                                                                                                                                                                                                                                                                    | `number`      |n/a| yes      |
| noncurrent_version_transition_storage_class                                  | Specifies the Amazon S3 storage class to which you want the noncurrent object versions to transition. Can be ONEZONE_IA, STANDARD_IA, INTELLIGENT_TIERING, GLACIER, or DEEP_ARCHIVE                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| role                                  | The ARN of the IAM role for Amazon S3 to assume when replicating the objects                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| rules                                  | Specifies the rules managing the replication (documented below)                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| rules_id                                  | Unique identifier for the rule. Must be less than or equal to 255 characters in length                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| priority                                  | The priority associated with the rule                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| destination                                  | Specifies the destination for the rule (documented below)                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| source_selection_criteria                                  | Specifies special object selection criteria (documented below)                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| rules_prefix                                  | Object keyname prefix identifying one or more objects to which the rule applies. Must be less than or equal to 1024 characters in length                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| status                                  | The status of the rule. Either Enabled or Disabled. The rule is ignored if status is not Enabled                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| filter                                  | Filter that identifies subset of objects to which the replication rule applies (documented below)                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| destination_bucket                                  | The ARN of the S3 bucket where you want Amazon S3 to store replicas of the object identified by the rule                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| destination_storage_class                                  | The class of storage used to store the object. Can be STANDARD, REDUCED_REDUNDANCY, STANDARD_IA, ONEZONE_IA, INTELLIGENT_TIERING, GLACIER, or DEEP_ARCHIVE                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| replica_kms_key_id                                  | Destination KMS encryption key ARN for SSE-KMS replication. Must be used in conjunction with sse_kms_encrypted_objects source selection criteria                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| access_control_translation                                  | Specifies the overrides to use for object owners on replication. Must be used in conjunction with account_id owner override configuration                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| account_id                                  | The Account ID to use for overriding the object owner on replication. Must be used in conjunction with access_control_translation override configuration                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| sse_kms_encrypted_objects                                  | Match SSE-KMS encrypted objects (documented below). If specified, replica_kms_key_id in destination must be specified as well                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| sse_kms_encrypted_objects_enabled                                  | Boolean which indicates if this criteria is enabled                                                                                                                                                                                                                                                                                                                    | `bool`      |n/a| yes      |
| filter_prefix                                  | Object keyname prefix that identifies subset of objects to which the rule applies. Must be less than or equal to 1024 characters in length                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| filter_tags                                  | A map of tags that identifies subset of objects to which the rule applies. The rule applies only to objects having all the tags in its tagset                                                                                                                                                                                                                                                                                                                    | `map(string)`      |n/a| no      |
| server_side_encryption_configuration_rule                                  | A single object for server-side encryption by default configuration. (documented below)                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| apply_server_side_encryption_by_default                                  | A single object for setting server-side encryption by default. (documented below)                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| sse_algorithm                                  | The server-side encryption algorithm to use. Valid values are AES256 and aws:kms                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| kms_master_key_id                                  | The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms                                                                                                                                                                                                                                                                                                                    | `string`      | "aws/s3"         | no      |
| grant_id                                  | Canonical user id to grant for. Used only when type is CanonicalUser                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| grant_type                                  | Type of grantee to apply for. Valid values are CanonicalUser and Group. AmazonCustomerByEmail is not supported                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| grant_permissions                                  | List of permissions to apply for grantee. Valid values are READ, WRITE, READ_ACP, WRITE_ACP, FULL_CONTROL                                                                                                                                                                                                                                                                                                                    | `list(string)`      |n/a| yes      |
| grant_uri                                  | Uri address to grant for. Used only when type is Group                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| owner                                  | The override value for the owner on replicated objects. Currently only Destination is supported                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| object_lock_enabled                                  | Indicates whether this bucket has an Object Lock configuration enabled. Valid value is Enabled                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| object_lock_rule                                  | The Object Lock rule in place for this bucket                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| default_retention                                  | The default retention period that you want to apply to new objects placed in this bucket                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| mode                                  | The default Object Lock retention mode you want to apply to new objects placed in this bucket. Valid values are GOVERNANCE and COMPLIANCE                                                                                                                                                                                                                                                                                                                    | `string`      |n/a| yes      |
| default_retention_days                                  | The number of days that you want to specify for the default retention period                                                                                                                                                                                                                                                                                                                    | `number`      |20| no      |
| default_retention_years                                  | The number of years that you want to specify for the default retention period                                                                                                                                                                                                                                                                                                                    | `number`      |1| no      |




## Outputs

| Name | Description |
|------|-------------|
| s3\_bucket\_id |The name of the bucket|
| s3\_bucket\_arn |The ARN of the bucket. Will be of format arn:aws:s3:::bucketname|
| s3\_bucket\_domain\_name |The bucket domain name. Will be of format bucketname.s3.amazonaws.com|
| s3\_bucket\_regional\_domain\_name |The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL|
| s3\_hosted\_zone\_id |The Route 53 Hosted Zone ID for this bucket's region|
| s3\_bucket\_region |The AWS region this bucket resides in|
| s3\_bucket\_website\_endpoint |The website endpoint, if the bucket is configured with a website. If not, this will be an empty string|
| s3\_bucket\_website\_domain |The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records|


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
