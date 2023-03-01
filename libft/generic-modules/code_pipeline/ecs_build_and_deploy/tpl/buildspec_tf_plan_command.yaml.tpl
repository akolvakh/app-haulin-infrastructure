version: 0.2
phases:
  install:
    commands:
      - cd ${CODEBUILD_SRC_DIR_checked_out_terraform_code}
      - make install
  pre_build:
    commands:
      - export TF_VAR_service_version="\"${VERSION}\""
      - cd ${CODEBUILD_SRC_DIR_checked_out_terraform_code}/${TERRAFORM_MODULE_PATH}
      - make ${ECS_ENV}-env
      - make init
      - make plan
      - make output

artifacts:
  files: ${CODEBUILD_SRC_DIR_checked_out_terraform_code}/${TERRAFORM_MODULE_PATH}/plan.tf
