/**
* # Intro
* - helper module for "makefile framework"
* - automaticaly records in AWS SSP name and versino of the current Infra as code module being deployed, for the sake of Change Management
*/
resource "aws_ssm_parameter" "cm_vcs_tag" {
  name        = "/${local.common.Product}/${local.common.Environment}/${var.module_name}"
  type        = "String"
  value       = var.module_version
  overwrite   = true
  description = "current VCS tag"
  tags        = local.common_tags

}
