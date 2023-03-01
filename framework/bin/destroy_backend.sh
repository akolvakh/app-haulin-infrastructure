#!/usr/bin/env bash

set -e
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

if ! aws dynamodb delete-table \
        --region ${REGION} \
        --table-name ${DYNAMODB_TABLE}; then \
            echo "Unable to delete DynamoDB table ${DYNAMODB_TABLE}"; \
else
    echo "Deleted DynamoDB table ${DYNAMODB_TABLE}..."; \
fi

S3_OBJECT_VERSIONS=`aws s3api list-object-versions \
                        --region ${REGION} \
                        --bucket ${S3_BUCKET} \
                        --output=json \
                        --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}'`
echo Versions: ${S3_OBJECT_VERSIONS}

if [ ! -z "${S3_OBJECT_VERSIONS}" ]; then
    echo "Deleting object versions..."
    aws s3api delete-objects \
            --region ${REGION} \
            --bucket ${S3_BUCKET} \
            --delete "${S3_OBJECT_VERSIONS}" || \
        echo "Unable to delete objects in S3 bucket ${S3_BUCKET}";
fi

S3_OBJECT_MARKERS=`aws s3api list-object-versions \
                        --region ${REGION} \
                        --bucket ${S3_BUCKET} \
                        --output=json \
                        --query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}'`
echo Markers: ${S3_OBJECT_MARKERS}

if [ ! -z "${S3_OBJECT_MARKERS}" ]; then
    echo "Deleting object markers..."
    aws s3api delete-objects \
            --region ${REGION} \
            --bucket ${S3_BUCKET} \
            --delete "${S3_OBJECT_MARKERS}" || \
        echo "Unable to delete markers in S3 bucket ${S3_BUCKET}"; \
fi

if ! aws s3api delete-bucket \
    --region ${REGION} \
    --bucket ${S3_BUCKET}; then \
        echo "Unable to delete S3 bucket ${S3_BUCKET} itself"; \
else
    echo "Deleted s3 bucket ${S3_BUCKET}"
fi
