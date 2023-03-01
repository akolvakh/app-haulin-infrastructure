#!/usr/bin/env bash

set -e

# Variables
if [ -z ${AWS_BACKEND_REGION_REPLICATION} ]; then
    echo "AWS_BACKEND_REGION_REPLICATION variable is not set"
    echo "Run without replication mode"
    exit
fi

if [ -z ${S3_REPLICATION_BUCKET} ]; then
    echo "S3_REPLICATION_BUCKET variable is not set"
    exit 1
fi

if [ -z ${FILE_TRUST_POLICY} ]; then
    echo "FILE_TRUST_POLICY variable is not set"
    exit 1
fi

if [ -z ${FILE_POLICY} ]; then
    echo "FILE_POLICY variable is not set"
    exit 1
fi

if [ -z ${FILE_REPLICATION} ]; then
    echo "FILE_REPLICATION variable is not set"
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

# Creating Destination Bucket
echo "Checking for S3 bucket ${S3_REPLICATION_BUCKET}..."
if ! aws  s3api head-bucket --region ${AWS_BACKEND_REGION_REPLICATION} --bucket ${S3_REPLICATION_BUCKET}; then
echo "Creating S3 bucket ${S3_REPLICATION_BUCKET} Replication in ${AWS_BACKEND_REGION_REPLICATION}...";
aws  s3api create-bucket \
    --bucket ${S3_REPLICATION_BUCKET} \
    --acl private \
    --region ${AWS_BACKEND_REGION_REPLICATION} \
    --create-bucket-configuration LocationConstraint=${AWS_BACKEND_REGION_REPLICATION} && \
aws  s3api put-public-access-block \
    --bucket ${S3_REPLICATION_BUCKET} \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true" &&\
aws  s3api put-bucket-versioning \
    --bucket ${S3_REPLICATION_BUCKET} \
    --versioning-configuration Status=Enabled && \
aws  s3api put-bucket-encryption \
    --bucket ${S3_REPLICATION_BUCKET} \
    --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'
echo "S3 replication bucket ${S3_REPLICATION_BUCKET} created..."; \
else
    echo "S3 bucket ${S3_REPLICATION_BUCKET} exists..."; \
fi

# Check for existing policies, roles, iams and files
echo "Checking for IAM ${REPLICATION_ROLE}..."
if ! aws  iam get-role --role-name ${REPLICATION_ROLE}; then

echo "Generating trust policy..."
(cat <<-END
{
   "Version":"2012-10-17",
   "Statement":[
      {
         "Effect":"Allow",
         "Principal":{
            "Service":"s3.amazonaws.com"
         },
         "Action":"sts:AssumeRole"
      }
   ]
}
END
)>${FILE_TRUST_POLICY}

echo "Creating IAM role for S3 bucket ${S3_BUCKET} replication..."
aws iam create-role \
--role-name ${REPLICATION_ROLE} \
--assume-role-policy-document file://${FILE_TRUST_POLICY}


echo "Generatin Policy file for S3 bucket ${S3_BUCKET} replication..."
(cat <<-END
{
  "Version":"2012-10-17",
  "Statement":[
      {
         "Effect":"Allow",
         "Action":[
            "s3:GetObjectVersionForReplication",
            "s3:GetObjectVersionAcl",
            "s3:GetObjectVersionTagging"
         ],
         "Resource":[
            "arn:aws:s3:::${S3_BUCKET}/*"
         ]
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:ListBucket",
            "s3:GetReplicationConfiguration"
         ],
         "Resource":[
            "arn:aws:s3:::${S3_BUCKET}"
         ]
      },
      {
         "Effect":"Allow",
         "Action":[
            "s3:ReplicateObject",
            "s3:ReplicateDelete",
            "s3:ReplicateTags"
         ],
         "Resource":"arn:aws:s3:::${S3_REPLICATION_BUCKET}/*"
      }
  ]
}
END
)>${FILE_POLICY}

echo "Creating Policy and attaching it to IAM role for S3 bucket ${S3_BUCKET} replication..."
aws iam put-role-policy \
--role-name ${REPLICATION_ROLE} \
--policy-document file://${FILE_POLICY} \
--policy-name ${REPLICATION_ROLE_POLICY}


# Prepare IAM Role ARN var for replication configuration
REPLICATION_IAM_ROLE_ARN=$(aws iam get-role --role-name ${REPLICATION_ROLE} | grep "arn:aws:iam" | awk '{print $2}' | sed 's/\"//g' | sed 's/,$//')

echo "Adding replication configuration for S3 bucket ${S3_BUCKET} replication..."
(cat <<-END
{
   "Role": "${REPLICATION_IAM_ROLE_ARN}",
   "Rules": [
    {
      "Status": "Enabled",
      "Priority": 1,
      "DeleteMarkerReplication": { "Status": "Disabled" },
      "Filter" : {},
      "Destination": {
         "Bucket": "arn:aws:s3:::${S3_REPLICATION_BUCKET}"
      }
    }
   ]
}
END
)>${FILE_REPLICATION}

aws s3api put-bucket-replication \
--replication-configuration file://${FILE_REPLICATION} \
--bucket ${S3_BUCKET}


else
    echo "IAM replicationRole exists..."; \
fi

# Get bucket replication to be sure that it was created successfully
aws s3api get-bucket-replication --bucket ${S3_BUCKET}

# Clean up and delete all generated files
echo "Deleting .json replication files for IAM roles (policies)..."
rm -rf ${FILE_TRUST_POLICY} ${FILE_POLICY} ${FILE_REPLICATION}

echo "Finished!"
