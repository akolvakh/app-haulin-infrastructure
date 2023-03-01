version: 0.2
phases:
  install:
    commands:
      - make install
  pre_build:
    commands:
      - cd ${TERRAFORM_MODULE_PATH}
      - make ${ECS_ENV}-env
      - make init
      - find ${CODEBUILD_SRC_DIR_tfplan} -type f -name *plan.tf | xargs -I {} terraform apply {}

# artifacts:
#   files: ${TERRAFORM_MODULE_PATH}/plan.tf
