#--------------------------------------------------------------
# Notes
#--------------------------------------------------------------
/**
we use and plan use, SMS sending from Cognit only
When we start marketing campaigns - we should use separated account for hosting marketing tooling or even 3rd party vendor
So - parking those SNS account wide setting in this Cognito module for now
*/

#--------------------------------------------------------------
# SNS
#--------------------------------------------------------------
resource "aws_sns_sms_preferences" "sms_prefs" {
  monthly_spend_limit                   = var.profile.sns_monthly_spend_limit
  default_sms_type                      = "Transactional"
  delivery_status_success_sampling_rate = "100"
  delivery_status_iam_role_arn          = aws_iam_role.sns_log.arn
}