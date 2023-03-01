#!/bin/sh
if [ -z $ver ]
then
 echo "env variable ver must exist and hold version to be assigned to the build"
 exit 1
fi
source ./config.sh
docker tag ${IMG_NAME}:latest ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/${IMG_NAME}:${ver}
docker push ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com/${IMG_NAME}:${ver}