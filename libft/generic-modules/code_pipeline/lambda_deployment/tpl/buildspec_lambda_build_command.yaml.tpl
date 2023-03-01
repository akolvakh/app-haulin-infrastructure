version: 0.2
phases:
  pre_build:
    commands:
      - echo Logging in to Amazon ECR...
      - aws ecr get-login-password --region $ECR_REGION | docker login --username AWS --password-stdin $ECR_ACCOUNT_ID.dkr.ecr.$ECR_REGION.amazonaws.com
  build:
    commands:
      - env
      - cd ${LAMBDA_PATH}
      - echo Build started on `date`
      - echo Building the Docker image...
      - docker build --build-arg PRIVATE_CERT_BASE64=${PRIVATE_CERT_BASE64} -f $DOCKERFILE_NAME -t $IMAGE_REPO_NAME:$TAG .
      - docker tag $IMAGE_REPO_NAME:$TAG $IMAGE_REPO_NAME:$TAG
  post_build:
    commands:
      - echo Build completed on `date`
      - echo Pushing the Docker image...
      - docker push $IMAGE_REPO_NAME:$TAG
      - echo $IMAGE_REPO_NAME:$TAG
