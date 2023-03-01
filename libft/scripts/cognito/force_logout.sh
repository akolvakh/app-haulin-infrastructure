#!/bin/bash

# Arguments
# - $1 - user pool id

# CloudWatch logs
# - log group should be created via terraform 60.cloudwatch in phoenix-app-modularized with name "force_logout"
# - per each run of script new log stream is created

set -e

function ft_arguments_checker {
    [[ $# -eq 0 ]] && { echo "-[FAIL]Error: No arguments supplied. User Pool ID is empty. To run script you should run script with next arguments: ${0} [user_pool_id]"; exit 1; }
    [[ -z "$1" ]] && { echo "-[FAIL]Error: User Pool ID is empty. To run script you should run script with argument: ${0} [user_pool_id]"; exit 1; }
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

function ft_is_empty {
    [[ -z "$1" ]] && { echo "-[FAIL]Error: User Pool is empty"; exit 1; }
    echo "-[OK]User Pool is seeded."
}

function ft_parse_users {
    
    users_string=$(aws cognito-idp list-users --user-pool-id $1)
    
    ft_error_checker "-[OK]List of users was successfully retrieved." "-[FAIL]Cannot get User Pool List. Something went wrong."
    
    users_string=$(grep "Username" <<< "$users_string" | awk '{print $2}' | tr -d '"' | tr -d ',')

}

function ft_seed_array_with_users {
    i=0
    for user in $1
        do
           array[$i]=$user
           i=$[i+1]
        done
    echo "-[OK]Array of users was successfully seeded."
}

function ft_logging {
    timestamp=$(date)
    logstream=$(date +"%Y/%m/%d/%H-%M-%S")
    loggroup="force_logout"
    
    echo "-[OK]Starting force logout user : $timestamp"
    
    # create logstream in log group in CloudWatch
    aws logs create-log-stream --log-group-name "$loggroup" --log-stream-name "$logstream"
    
    ft_error_checker "-[OK]CloudWatch Log Stream was successfully created." "-[FAIL]Cannot create Cloudwatch Log Stream. Something went wrong."
}

function ft_put_log_event {
    if [[ $1 -eq 0 ]] ; then
        sequenceToken=$(aws logs put-log-events --log-group-name "$2" --log-stream-name "$3" --log-events timestamp=$(date +%s%N | cut -b1-13),message="$4" | grep "nextSequenceToken" | awk '{print $2}' | tr -d '"')
    else
        sequenceToken=$(aws logs put-log-events --log-group-name "$2" --log-stream-name "$3" --log-events timestamp=$(date +%s%N | cut -b1-13),message="$4" --sequence-token "$sequenceToken" | grep "nextSequenceToken" | awk '{print $2}' | tr -d '"')
    fi
    ft_error_checker "-[OK]CloudWatch Log Stream was successfully created." "-[FAIL]Cannot create Cloudwatch Log Stream. Something went wrong."
}

# temporary disabled logging to confgiure Session Manager Logging
function ft_logout_all_users {
    for i in "${!array[@]}"
    do
        echo "->${array[i]}"
        if ($( aws cognito-idp admin-user-global-sign-out --user-pool-id $1 --username "${array[i]}" )) ; then
            # ft_put_log_event $i $loggroup $logstream "${array[i]}=>DONE"
            echo "-[OK]${array[i]}=>DONE"
        else
            # ft_put_log_event $i $loggroup $logstream "Cannot diasble user ${i}. Something went wrong."
            echo "-[FAIL]Cannot logout ${array[i]}. Something went wrong."
            exit 1
        fi
    done
}

array=()
IFS=$'\n';

# check stdin arguments
ft_arguments_checker $1

# parse users 
ft_parse_users $1

# check user pool users
ft_is_empty "$users_string"

# put users into array
ft_seed_array_with_users "$users_string"

# timestamp for logstreams and logs in CloudWatch
# temporary disabled to confgiure Session Manager Logging
# ft_logging

# force logout all users
ft_logout_all_users $1