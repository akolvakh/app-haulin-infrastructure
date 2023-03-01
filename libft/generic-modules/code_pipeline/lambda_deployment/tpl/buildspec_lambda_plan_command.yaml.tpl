version: 0.2
phases:
  install:
    commands:
      - make install
  pre_build:
    commands:
      - export TF_VAR_lambda_slack_codepipeline_integration_version="\"${TAG}\""
      - export TF_VAR_lambda_pre_signup_version="\"${TAG}\""
      - export TF_VAR_lambda_pre_authorization_version="\"${TAG}\""
      - export TF_VAR_lambda_post_confirmation_version="\"${TAG}\""
      - cd deployments/phoenix-app-modularized/33.lambda
      - make ${ENV}-env
      - make init
      - make plan
      - make output

artifacts:
  files: ${LAMBDA_MODULE_PATH}/plan.tf
