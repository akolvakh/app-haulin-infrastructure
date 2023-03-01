output "ecr_account" {
  value       = "776131206689"
  description = "AWS account id of account holding ECRs"
}
output "ecr_region" {
  value       = "us-east-1"
  description = "What region we keep out ECRs in?"
}
output "account_ids" {
  value       = { stage = "", staging = "", dev = "", prod = "", log = "", qa = "" , experimental="776131206689"}
  description = "Account ids"
}
output "backup_account" {
  value       = "776131206689"
  description = "AWS account id of account holding cross account backups. Should be AppendOnly and highly locked down"
}
output "organization_id" {
  value = "o-zqxlc2dcff"
}
output "audit_account_id" {
  value = "776131206689"
}