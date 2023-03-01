version: 0.2
phases:
  install:
    commands:
      - cd ${CODEBUILD_SRC_DIR_checked_out_terraform_code}
      - make install
  pre_build:
    commands:
      - cp -r ${CODEBUILD_SRC_DIR_checked_out_code} /tmp/code_artifact
      - export TF_VAR_resolvers_dir="\"/tmp/code_artifact/${RESOLVERS_DIR}\""
      - cd ${CODEBUILD_SRC_DIR_checked_out_terraform_code}/${TERRAFORM_MODULE_PATH}
      - make ${ECS_ENV}-env
      - echo ${CODEBUILD_SRC_DIR_checked_out_terraform_code}
      - make init
      - find ${CODEBUILD_SRC_DIR} -type f -name *plan.tf | xargs -I {} terraform apply {}
