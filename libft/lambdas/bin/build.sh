#!/bin/sh
source ./config.sh
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
docker build -t $IMG_NAME src  -f python/Dockerfile