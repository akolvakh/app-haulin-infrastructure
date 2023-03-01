version: 0.2
phases:
  install:
    commands:
      - cd ${CODEBUILD_SRC_DIR_checked_out_terraform_code}
      - make install
  pre_build:
    commands:
      - cp -r ${CODEBUILD_SRC_DIR} /tmp/code_artifact
      - cd ${CODEBUILD_SRC_DIR_checked_out_terraform_code}/${TERRAFORM_MODULE_PATH}
      - export TF_VAR_appsync_admin_schema="\"/tmp/code_artifact/${APPSYNC_ADMIN_SCHEMA}\""
      - export TF_VAR_appsync_be_schema="\"/tmp/code_artifact/${APPSYNC_BE_SCHEMA}\""
      - export TF_VAR_be_resolvers_dir="\"/tmp/code_artifact/${BE_RESOLVERS_DIR}\""
      - export TF_VAR_config_resolvers_dir="\"/tmp/code_artifact/${CONFIG_RESOLVERS_DIR}\""
      - export TF_VAR_admin_resolvers_dir="\"/tmp/code_artifact/${ADMIN_RESOLVERS_DIR}\""
      - export TF_VAR_i2c_resolvers_dir="\"/tmp/code_artifact/${I2C_RESOLVERS_DIR}\""
      - export TF_VAR_notification_resolvers_dir="\"/tmp/code_artifact/${NOTIFICATION_RESOLVERS_DIR}\""
      - make ${ENV}-env
      - make init
      - make plan
      - make output

artifacts:
  files: ${CODEBUILD_SRC_DIR_checked_out_terraform_code}/${TERRAFORM_MODULE_PATH}/plan.tf
