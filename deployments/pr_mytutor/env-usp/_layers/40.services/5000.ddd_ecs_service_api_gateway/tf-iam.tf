#--------------------------------------------------------------
# ECS Execution role
#--------------------------------------------------------------
resource "random_id" "exec_uniq" {
  byte_length = 8
}

resource "aws_iam_role" "task_execution_role" {
  name               = substr("${module.label.id}_${var.service_name}_task_execution_role_${random_id.exec_uniq.dec}", 0, 64)
  assume_role_policy = file("${path.module}/tpl/policy/task_execution_role_trust.json.tpl")
  tags               = module.label.tags
}

resource "aws_iam_policy" "task_execution_role_policy" {
  name        = "${module.label.id}_${var.service_name}_task_execution_role_policy_${random_id.exec_uniq.dec}"
  description = "${module.label.id}-${var.service_name} customized task_execution_role policy"

  policy      = templatefile("${path.module}/tpl/policy/task_execution_role.json.tpl", {
    aws_region   = var.label["Region"]
    environment  = var.label["Environment"]
    product      = var.label["Product"]
    service_name = var.service_name
    aws_account  = data.aws_caller_identity.current.account_id
  }
  )
  tags = module.label.tags
}

resource "aws_iam_role_policy_attachment" "task_execution_role_policy_attachment" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.task_execution_role_policy.arn
}

#--------------------------------------------------------------
# ECS Task role
#--------------------------------------------------------------
resource "random_id" "task_uniq" {
  byte_length = 8
}

resource "aws_iam_role" "task_role" {
  name               = substr("${module.label.id}_${var.service_name}_task_role_${random_id.task_uniq.dec}", 0, 64)
  assume_role_policy = file("${path.module}/tpl/policy/task_role_trust.json.tpl")
  tags               = module.label.tags
}

resource "aws_iam_policy" "task_role_policy" {
  name        = "${module.label.id}_${var.service_name}_task_role_policy_${random_id.task_uniq.dec}"
  description = "${module.label.id}-${var.service_name} task_role policy"
  policy      = templatefile("${path.module}/tpl/policy/task_role.json.tpl", {
    aws_region           = var.label["Region"]
    environment          = var.label["Environment"]
    product              = var.label["Product"]
    service_name         = var.service_name
    aws_account          = data.aws_caller_identity.current.account_id
    cognito_user_pool_id = var.outputs_cognito_cognito_app_pool_id
  }
  )
  tags = module.label.tags
}

resource "aws_iam_role_policy_attachment" "task_role_policy_attachment" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.task_role_policy.arn
}
