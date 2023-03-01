#!/bin/bash

# Arguments
# - $1 - user pool id
# - $2 - username

# CloudWatch logs
# - log group should be created via terraform 60.cloudwatch in phoenix-app-modularized with name "disable_user"
# - per each run of script new log stream is created

set -e

function ft_arguments_checker {
    [[ $# -eq 0 ]] && { echo "-[FAIL]Error: No arguments supplied. User Pool ID and Username are empty. To run script you should run script with next arguments: ${0} [user_pool_id] [username]"; exit 1; }
    [[ -z "$1" ]] && { echo "-[FAIL]Error: User Pool ID is empty. To run script you should run script with next arguments: ${0} [user_pool_id] [username]"; exit 1; }
    [[ -z "$2" ]] && { echo "-[FAIL]Error: Username is empty. To run script you should run script with next arguments: ${0} [user_pool_id] [username]"; exit 1; }
    echo "-[OK]Arguments were successfully passed to the script."
}

function ft_error_checker {
    if [ $? -eq 0 ]; then
        echo $1
    else
        echo $2
        exit 1
    fi
}

function ft_logging {
    timestamp=$(date)
    logstream=$(date +"%Y/%m/%d/%H-%M-%S")
    loggroup="disable_user"
    
    echo "-[OK]Starting disable user : $timestamp"
    
    # create logstream in log group in CloudWatch
    aws logs create-log-stream --log-group-name "$loggroup" --log-stream-name "$logstream"
    
    ft_error_checker "-[OK]CloudWatch Log Stream was successfully created." "-[FAIL]Cannot create Cloudwatch Log Stream. Something went wrong."
}

# temporary disabled logging to confgiure Session Manager Logging
function ft_disable_user {
    if ($( aws cognito-idp admin-disable-user --user-pool-id $1 --username $2  )) ; then
        # aws logs put-log-events --log-group-name "$loggroup" --log-stream-name "$logstream" --log-events timestamp=$(date +%s%N | cut -b1-13),message="$2=>DONE"
        echo "-[OK]$2=>DONE"
    else
        # aws logs put-log-events --log-group-name "$loggroup" --log-stream-name "$logstream" --log-events timestamp=$(date +%s%N | cut -b1-13),message="Cannot diasble user ${2}. Something went wrong."
        echo "-[FAIL]Cannot diasble user ${2}. Something went wrong."
        exit 1
    fi
}

# check stdin arguments
ft_arguments_checker $1 $2

# timestamp for logstreams and logs in CloudWatch
# temporary disabled to confgiure Session Manager Logging
# ft_logging

# disable user script with logging
ft_disable_user $1 $2