output "mail_from_arn" {
  value = aws_ses_email_identity.mobile_mail_from.arn
}
output "mail_from_email" {
  value = aws_ses_email_identity.mobile_mail_from.email
}
