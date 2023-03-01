#!/usr/bin/env bash

BIN_DIR=`dirname $0`
. $BIN_DIR/functions.include

if [ -z ${S3_BUCKET} ]; then
    echo "S3_BUCKET variable is not set"
    exit 1
fi

if [ -z ${DYNAMODB_TABLE} ]; then
    echo "DYNAMODB_TABLE variable is not set"
    exit 1
fi

if [ -z ${REGION} ]; then
    echo "REGION variable is not set"
    exit 1
fi

if [ -z ${AWS_BACKEND_PROFILE} ]; then
    echo "AWS_BACKEND_PROFILE variable is not set"
    exit 1
fi

log_info "Checking for S3 bucket ${S3_BUCKET}..."
if ! aws s3api head-bucket --region ${REGION} --bucket ${S3_BUCKET}; then
    log_trace "Creating S3 bucket ${S3_BUCKET}...";
    if  [[ "$REGION" == "us-east-1" ]]; then
        log_trace "Creating S3 bucket WITHOUT LocationConstraint...";
    else
        log_trace "Creating S3 bucket WITH LocationConstraint...";
        LOCATIONCONSTRAINT="--create-bucket-configuration LocationConstraint=${REGION}"
    fi
        aws s3api create-bucket \
        --bucket ${S3_BUCKET} \
        --acl private \
        --region ${REGION} \
        ${LOCATIONCONSTRAINT}  && \
        aws s3api put-public-access-block \
            --bucket ${S3_BUCKET} \
            --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true" &&\
        aws s3api put-bucket-versioning \
            --bucket ${S3_BUCKET} \
            --versioning-configuration Status=Enabled && \
        if [ -z "${GUARDRAIL_MANAGED_S3_ENCRYPTION}" ]; then
	       	aws s3api put-bucket-encryption \
            	--bucket ${S3_BUCKET} \
            	--server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'
	fi
	log_trace "S3 bucket ${S3_BUCKET} created..."; \
else
    log_trace "S3 bucket ${S3_BUCKET} exists..."; \
fi

log_trace "Checking for DynamoDB table ${DYNAMODB_TABLE}..."
if ! aws --region ${REGION} dynamodb describe-table --table-name ${DYNAMODB_TABLE} > /dev/null 2>&1; then \
    log_trace "Creating DynamoDB table ${DYNAMODB_TABLE}..."; \
    aws dynamodb create-table \
       --region ${REGION} \
            --table-name ${DYNAMODB_TABLE} \
            --attribute-definitions AttributeName=LockID,AttributeType=S \
            --key-schema AttributeName=LockID,KeyType=HASH \
            --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5; \
        log_trace "DynamoDB table ${DYNAMODB_TABLE} created..."; \
        log_trace "Waiting for 10 seconds to allow DynamoDB state to propagate through AWS..."; \
        sleep 10; \
else
    log_trace "DynamoDB Table ${DYNAMODB_TABLE} exists..."; \
fi
