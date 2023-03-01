version: 0.2
phases:
  install:
    commands:
      - cd ${CODEBUILD_SRC_DIR}
      - make install
  pre_build:
    commands:
      - cd ${CODEBUILD_SRC_DIR}/${TERRAFORM_MODULE_PATH}
      - export TF_VAR_be_resolvers_dir="\"${CODEBUILD_SRC_DIR_checked_out_code}/deploy/be/appsync/resolvers\""
      - export TF_VAR_config_resolvers_dir="\"${CODEBUILD_SRC_DIR_checked_out_code}/deploy/config/appsync/resolvers\""
      - export TF_VAR_admin_resolvers_dir="\"${CODEBUILD_SRC_DIR_checked_out_code}/deploy/admin/appsync/resolvers\""
      - export TF_VAR_i2c_resolvers_dir="\"${CODEBUILD_SRC_DIR_checked_out_code}/deploy/i2c/appsync/resolvers\""
      - export TF_VAR_notification_resolvers_dir="\"${CODEBUILD_SRC_DIR_checked_out_code}/deploy/notification/appsync/resolvers\""
      - make ${ECS_ENV}-env
      - make init
      - make output
      - terraform apply plan.tf
