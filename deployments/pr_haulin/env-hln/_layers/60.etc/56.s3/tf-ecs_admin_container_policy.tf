# #--------------------------------------------------------------
# # IAM
# #--------------------------------------------------------------
# resource "aws_iam_policy" "mobile_app_cdn_bucket_access" {
#   name   = "${module.this.s3_bucket_id}_rw_bucket_access" #!!!
#   policy = data.aws_iam_policy_document.mobile_app_cdn_bucket_access.json

#   tags = merge({
#     "role" = "${var.tag_role}",
#   })
# }

# data "aws_iam_policy_document" "mobile_app_cdn_bucket_access" {
#   statement {
#     sid = ""

#     actions = [
#       "s3:ListBucket",
#       "s3:ListBucketVersions",
#       "s3:PutObject"
#     ]

#     resources = [
#       module.this.s3_bucket_arn,
#       "${module.this.s3_bucket_arn}/*"
#     ]
#     effect = "Allow"
#   }
# }

# resource "aws_iam_role_policy_attachment" "mobile_app_cdn_bucket_access" {
#   role       = data.terraform_remote_state.ecs.outputs.ecs_service_name_2_task_role_name_map["be"]
#   policy_arn = join("", aws_iam_policy.mobile_app_cdn_bucket_access.*.arn)
# }

