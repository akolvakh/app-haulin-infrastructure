version: 0.2
phases:
  pre_build:
    commands:
      - cd ${LAMBDA_PATH}
      - make test
