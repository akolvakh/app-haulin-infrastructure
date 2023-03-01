#!/usr/bin/env bash

set -e

if [ -z ${WORKSPACE} ]; then
    echo "WORKSPACE variable is not set"
    exit 1
fi

if [ -z ${S3_BUCKET} ]; then
    echo "S3_BUCKET variable is not set"
    exit 1
fi

if [ -z ${STATE_FILE} ]; then
    echo "STATE_FILE variable is not set"
    exit 1
fi

if [ -z ${REGION} ]; then
    echo "REGION variable is not set"
    exit 1
fi

if [ -z ${DYNAMODB_TABLE} ]; then
    echo "DYNAMODB_TABLE variable is not set"
    exit 1
fi

#    workspaces {
#      name = "${WORKSPACE}"
#    }

(cat <<-END
# Caution: Generated configuration - should not be edited directly.
terraform {
  backend "s3" {
    bucket  = "${S3_BUCKET}"
    key     = "${STATE_FILE}"
    region  = "${REGION}"
    encrypt = true
    dynamodb_table = "${DYNAMODB_TABLE}"
  }
}
END
)
