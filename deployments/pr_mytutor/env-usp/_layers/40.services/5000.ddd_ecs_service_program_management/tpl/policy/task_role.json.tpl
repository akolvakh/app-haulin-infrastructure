{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Sid": "AllowXRayWrite2Daemon",
        "Effect": "Allow",
        "Action": [
            "xray:PutTraceSegments",
            "xray:PutTelemetryRecords",
            "xray:GetSamplingRules",
            "xray:GetSamplingTargets",
            "xray:GetSamplingStatisticSummaries"
        ],
        "Resource": [
            "*"
        ]
    },
    {
	    "Sid": "AllowEcsExecTroubleshootingTool",
        "Effect": "Allow",
        "Action": [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel"
        ],
        "Resource": "*"
    },
    {
	    "Sid": "AllowAccessToS3",
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": "*"
    },
    {
		"Sid": "AllowEcsToCallParameterStore",
		"Effect": "Allow",
		"Action": [
		    "ssm:GetParameters",
			"ssm:GetParameter"
		],
		"Resource": [
		    "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_program-management/*"
		]
	},
	{
		"Sid": "AllowEcsExecCognitoCommands",
		"Effect": "Allow",
		"Action": [
		    "cognito-idp:AdminSetUserMFAPreference",
		    "cognito-idp:AdminCreateUser",
		    "cognito-idp:*"
		],
		"Resource": [
		    "arn:aws:cognito-idp:${aws_region}:${aws_account}:userpool/${cognito_user_pool_id}"
		]
	}
  ]
}
