{
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "ServiceBETaskRoleTrust",
        "Effect": "Allow",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }