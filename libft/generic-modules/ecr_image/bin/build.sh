#!/bin/bash
ME=`basename $0`

# Fail fast
set -e

function usage() {
    echo ""
    echo "Usage ${ME} OPTIONS"
    echo "  Options:"
    echo "    -f Dockerfile path"
    echo "    -c Docker build context"
    echo "    -t Docker image tag (repo_url:image_tag)"
    echo "    -r AWS region"
    exit 1
}

while getopts f:c:t:r: flag
do
    case "${flag}" in
        f) dockerfile_path=${OPTARG};;
        c) build_context=${OPTARG};;
        t) aws_ecr_repository_url_with_tag=${OPTARG};;
        r) aws_region=${OPTARG};;
    esac
done

if [[ -z "${dockerfile_path}" ]] || [[ -z "${build_context}" ]] || [[ -z "${aws_ecr_repository_url_with_tag}" ]]; then
    usage
fi

# Allow overriding the aws region from system
if [ "${aws_region}" != "" ]; then
    aws_extra_flags="--region ${aws_region}"
  else
    aws_extra_flags=""
fi

# Check that aws is installed
which aws > /dev/null || { echo 'ERROR: aws-cli is not installed' ; exit 1; }

# Check that docker is installed and running
which docker > /dev/null && docker ps > /dev/null || { echo 'ERROR: docker is not running' ; exit 1; }

# Connect into aws
aws ecr get-login-password ${aws_extra_flags} | docker login --username AWS --password-stdin ${aws_ecr_repository_url_with_tag}

# Some Useful Debug
echo "Building ${aws_ecr_repository_url_with_tag} from ${build_context} with ${dockerfile_path}"

# Build image
docker build -f ${dockerfile_path} -t ${aws_ecr_repository_url_with_tag} ${build_context}

# Push image
docker push ${aws_ecr_repository_url_with_tag}
