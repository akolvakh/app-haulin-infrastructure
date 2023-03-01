#!/usr/bin/env bash

set -e

if [ -z ${AWS_BACKEND_REGION_REPLICATION} ]; then
    echo "AWS_BACKEND_REGION_REPLICATION variable is not set"
    echo "Delete without replication mode"
    exit
fi

if [ -z ${S3_REPLICATION_BUCKET} ]; then
    echo "S3_REPLICATION_BUCKET variable is not set"
    exit 1
fi

if [ -z ${REPLICATION_ROLE} ]; then
    echo "REPLICATION_ROLE variable is not set"
    exit 1
fi

if [ -z ${REPLICATION_ROLE_POLICY} ]; then
    echo "REPLICATION_ROLE_POLICY variable is not set"
    exit 1
fi

# Destroy S3 Replication Bucket

S3_OBJECT_VERSIONS=`aws  s3api list-object-versions \
                        --region ${AWS_BACKEND_REGION_REPLICATION} \
                        --bucket ${S3_REPLICATION_BUCKET} \
                        --output=json \
                        --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}'`
echo Versions: ${S3_OBJECT_VERSIONS}

if [ ! -z "${S3_OBJECT_VERSIONS}" ]; then
    echo "Deleting object versions..."
    aws  s3api delete-objects \
            --region ${AWS_BACKEND_REGION_REPLICATION} \
            --bucket ${S3_REPLICATION_BUCKET} \
            --delete "${S3_OBJECT_VERSIONS}" || \
        echo "Unable to delete objects in S3 bucket ${S3_REPLICATION_BUCKET}";
fi

S3_OBJECT_MARKERS=`aws  s3api list-object-versions \
                        --region ${AWS_BACKEND_REGION_REPLICATION} \
                        --bucket ${S3_REPLICATION_BUCKET} \
                        --output=json \
                        --query='{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}'`
echo Markers: ${S3_OBJECT_MARKERS}

if [ ! -z "${S3_OBJECT_MARKERS}" ]; then
    echo "Deleting object markers..."
    aws  s3api delete-objects \
            --region ${AWS_BACKEND_REGION_REPLICATION} \
            --bucket ${S3_REPLICATION_BUCKET} \
            --delete "${S3_OBJECT_MARKERS}" || \
        echo "Unable to delete markers in S3 bucket ${S3_REPLICATION_BUCKET}"; \
fi

if ! aws  s3api delete-bucket \
    --region ${AWS_BACKEND_REGION_REPLICATION} \
    --bucket ${S3_REPLICATION_BUCKET}; then \
        echo "Unable to delete S3 bucket ${S3_REPLICATION_BUCKET} itself"; \
else
    echo "Deleted s3 bucket ${S3_REPLICATION_BUCKET}"
fi

# Delete IAM Replication Role an Policies

echo "Deleting role policies..."
aws  iam delete-role-policy --role-name ${REPLICATION_ROLE} --policy-name ${REPLICATION_ROLE_POLICY}
echo "Finished..."

echo "Deleting role..."
aws  iam delete-role --role-name ${REPLICATION_ROLE}
echo "Finished..."
