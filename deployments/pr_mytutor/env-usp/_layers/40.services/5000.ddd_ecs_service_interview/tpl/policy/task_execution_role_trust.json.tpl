{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "TaskExecutePolicyTrust",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }