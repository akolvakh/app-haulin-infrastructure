version: 0.2
phases:
  install:
    commands:
      - cd ${CODEBUILD_SRC_DIR}
      - make install
  pre_build:
    commands:
      - cd ${CODEBUILD_SRC_DIR}/${TERRAFORM_MODULE_PATH}
      - export TF_VAR_claims_resolvers_dir="\"${CODEBUILD_SRC_DIR_checked_out_code}/deploy/claims/appsync/resolvers\""
      - export TF_VAR_users_resolvers_dir="\"${CODEBUILD_SRC_DIR_checked_out_code}/deploy/users/appsync/resolvers\""
      - export TF_VAR_trade_resolvers_dir="\"${CODEBUILD_SRC_DIR_checked_out_code}/deploy/trade/appsync/resolvers\""
      - make ${ECS_ENV}-env
      - make init
      - make output
      - terraform apply plan.tf