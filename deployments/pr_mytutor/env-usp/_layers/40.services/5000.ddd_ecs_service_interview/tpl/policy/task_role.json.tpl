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
		"Sid": "AllowEcsToCallParameterStore",
		"Effect": "Allow",
		"Action": [
		    "ssm:GetParameters",
			"ssm:GetParameter"
		],
		"Resource": [
		    "arn:aws:ssm:${aws_region}:${aws_account}:parameter/${product}/${environment}/service_interview/*"
		]
	}
  ]
}
