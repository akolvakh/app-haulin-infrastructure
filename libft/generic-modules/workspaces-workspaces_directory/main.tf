resource "aws_workspaces_directory" "main" {
  directory_id = var.directory_id
  subnet_ids   = var.subnets

  tags = var.tags

  self_service_permissions {
    change_compute_type  = var.self_service_permissions.change_compute_type
    increase_volume_size = var.self_service_permissions.increase_volume_size
    rebuild_workspace    = var.self_service_permissions.rebuild_workspace
    restart_workspace    = var.self_service_permissions.restart_workspace
    switch_running_mode  = var.self_service_permissions.switch_running_mode
  }

  workspace_access_properties {
    device_type_android    = var.workspace_access_properties.device_type_android
    device_type_chromeos   = var.workspace_access_properties.device_type_chromeos
    device_type_ios        = var.workspace_access_properties.device_type_ios
    device_type_linux      = var.workspace_access_properties.device_type_linux
    device_type_osx        = var.workspace_access_properties.device_type_osx
    device_type_web        = var.workspace_access_properties.device_type_web
    device_type_windows    = var.workspace_access_properties.device_type_windows
    device_type_zeroclient = var.workspace_access_properties.device_type_zeroclient
  }

  workspace_creation_properties {
    default_ou                          = var.default_ou
    enable_internet_access              = true
    enable_maintenance_mode             = true
    user_enabled_as_local_administrator = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.workspaces_default_service_access,
    aws_iam_role_policy_attachment.workspaces_default_self_service_access
  ]
}