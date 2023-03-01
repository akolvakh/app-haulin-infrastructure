{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "TaskExcutionRoleBasics",
			"Effect": "Allow",
			"Action": [
				"ecr:GetAuthorizationToken",
				"ecr:BatchCheckLayerAvailability",
				"ecr:GetDownloadUrlForLayer",
				"ecr:BatchGetImage",
				"logs:CreateLogStream",
				"logs:PutLogEvents",
				"logs:CreateLogGroup"
			],
			"Resource": "*"
		},
		{
			"Sid": "TaskExcutionRoleEncryptedECR",
			"Effect": "Allow",
			"Action": [
				"kms:Decrypt"
			],
			"Resource": [
				"arn:aws:kms:${aws_region}:${aws_account}:key/ecr-${product}-${environment}"
			]
		},
		{
			"Sid": "GenericTaskExcutionRoleSecretsManager",
			"Effect": "Allow",
			"Action": [
				"secretsmanager:GetSecretValue"
			],
			"Resource": [
				"arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/db/service_be/credentials*",
				"arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/db/credentials*",
				"arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/${product}/${environment}/booknook*",
				"arn:aws:secretsmanager:${aws_region}:${aws_account}:secret:/*"
			]
		},
		{
			"Sid": "GenericTaskExcutionRoleParameterStore",
			"Effect": "Allow",
			"Action": [
				"ssm:GetParameters",
				"ssm:GetParameter"
			],
			"Resource": [
			    "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_import/*"
			]
		}
	]
}
