version: 0.2
phases:
  install:
    commands:
      - cd ${CODEBUILD_SRC_DIR_checked_out_terraform_code}
      - make install
  pre_build:
    commands:
      - cp -r ${CODEBUILD_SRC_DIR_checked_out_lambda_code} /tmp/code_artifact
      - cd ${CODEBUILD_SRC_DIR_checked_out_terraform_code}/${LAMBDA_MODULE_PATH}
      - make ${ENV}-env
      - echo ${CODEBUILD_SRC_DIR_checked_out_terraform_code}
      - make init
      - find ${CODEBUILD_SRC_DIR} -type f -name *plan.tf | xargs -I {} terraform apply {}
