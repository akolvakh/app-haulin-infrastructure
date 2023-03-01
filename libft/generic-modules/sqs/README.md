# SQS Terraform Module for phoenix #

This Terraform module creates the base sqs infrastructure on AWS for phoenix App.

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

### Example (simple)

This simple example creates a sqs queue:

```
resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-example-queue"
  delay_seconds             = 90
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = 4
  })

  tags = {
    Environment = "production"
  }
}
```

FIFO queue
```
resource "aws_sqs_queue" "terraform_queue" {
  name                        = "terraform-example-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}
```

Server-side encryption (SSE)
```
resource "aws_sqs_queue" "terraform_queue" {
  name                              = "terraform-example-queue"
  kms_master_key_id                 = "alias/aws/sqs"
  kms_data_key_reuse_period_seconds = 300
}
```

This simple example creates a sqs queue policy:

```
resource "aws_sqs_queue" "q" {
  name = "examplequeue"
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.q.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.q.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.example.arn}"
        }
      }
    }
  ]
}
POLICY
}
```


### Example (complete)

This more complete example creates a sqs module using a detailed configuration. Please check the example folder to get the example with all options:

```
module "sqs" {
  source = "../sqs"

  app                       = "phoenix"
  env                       = "dev"
  queue_url                 = "some_url"
  sqs_queue_policy_policy   = "some_policy"
}
```



## Inputs

| Name                                 | Description                                                                                                                                                                                                                                                                                                                    | Type          | Default       | Required |
|--------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|---------------|----------|
| app                                  | App name                                                                                                                                                                                                                                                                                                                       | `string`      | "phoenix"      | yes      |
| env                                  | Environment                                                                                                                                                                                                                                                                                                                    | `string`      | "dev"         | yes      |
| name                                  | This is the human-readable name of the queue. If omitted, Terraform will assign a random name                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| name_prefix                                  | Creates a unique name beginning with the specified prefix. Conflicts with name                                                                                                                                                                                                                                                                                                                    | `string`      | "sqs"         | no      |
| visibility_timeout_seconds                                  | The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see AWS docs                                                                                                                                                                                                                                                                                                                    | `number`      | 30         | no      |
| message_retention_seconds                                  | The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days)                                                                                                                                                                                                                                                                                                                    | `number`      | 345600         | no      |
| max_message_size                                  | The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB)                                                                                                                                                                                                                                                                                                                    | `number`      | 262144         | no      |
| delay_seconds                                  | The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 seconds                                                                                                                                                                                                                                                                                                                    | `number`      | 0         | no      |
| receive_wait_time_seconds                                  | The time for which a ReceiveMessage call will wait for a message to arrive (long polling) before returning. An integer from 0 to 20 (seconds). The default for this attribute is 0, meaning that the call will return immediately                                                                                                                                                                                                                                                                                                                    | `number`      | 0         | no      |
| policy                                  | The JSON policy for the SQS queue. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide                                                                                                                                                                                                                                                                                                                    | `string`      | "{}"         | no      |
| redrive_policy                                  | The JSON policy to set up the Dead Letter Queue, see AWS docs. Note: when specifying maxReceiveCount, you must specify it as an integer (5), and not a string ('5')                                                                                                                                                                                                                                                                                                                    | `string`      | "{}"         | no      |
| fifo_queue                                  | Boolean designating a FIFO queue. If not set, it defaults to false making it standard                                                                                                                                                                                                                                                                                                                    | `bool`      | `false`         | no      |
| content_based_deduplication                                  | Enables content-based deduplication for FIFO queues                                                                                                                                                                                                                                                                                                                    | `bool`      | `true`         | no      |
| kms_master_key_id                                  | The ID of an AWS-managed customer master key (CMK) for Amazon SQS or a custom CMK. For more information, see Key Terms                                                                                                                                                                                                                                                                                                                    | `string`      | "/"         | no      |
| kms_data_key_reuse_period_seconds                                  | The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again. An integer representing seconds, between 60 seconds (1 minute) and 86,400 seconds (24 hours). The default is 300 (5 minutes)                                                                                                                                                                                                                                                                                                                    | `number`      | 300         | no      |
| tags                                  | A map of tags to assign to the queue                                                                                                                                                                                                                                                                                                                    | `map(string)`      | n/a         | no      |
| queue_url                                  | The URL of the SQS Queue to which to attach the policy                                                                                                                                                                                                                                                                                                                    | `string`      | n/a        | yes      |
| sqs_queue_policy_policy                                  | The JSON policy for the SQS queue. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide                                                                                                                                                                                                                                                                                                                    | `string`      | n/a         | yes      |



## Outputs

| Name                          | Description                                                                               |
|-------------------------------|-------------------------------------------------------------------------------------------|
| sqs_id                        | The URL for the created Amazon SQS queue                                                |
| sqs_arn                       | The ARN of the SQS queue                                                 |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
