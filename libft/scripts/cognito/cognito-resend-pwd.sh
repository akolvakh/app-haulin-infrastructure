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
    
    users_string=$(aws cognito-idp list-users --user-pool-id $1 --filter 'cognito:user_status="FORCE_CHANGE_PASSWORD"')
    
    ft_error_checker "-[OK]List of users was successfully retrieved." "-[FAIL]Cannot get User Pool List. Something went wrong."
    
    users_string=$(grep "Value" <<< "$users_string" | awk '{print $2}' | tr -d '"' | tr -d ',')

}

function ft_seed_array_with_users {
    i=0
    for user in $1
    do
        if echo $user | grep "@"
        then
            array[$i]=$user
            i=$[i+1]
        else
            echo "NOTHING."
        fi
    done
    echo "-[OK]Array of users was successfully seeded."
    
    
    # i=0
    # j=2
    # for user in "${array[@]}"
    #     do
    #       arr[$i]="${array[$j]}"
    #       echo "${arr[$i]}"
    #       printf "> %d \n" $i
    #       i=$[i+1]
    #       j=$[j+3]
    #     done
    # echo "-[OK]Array of users was successfully seeded."
    
    
    
    
    # # get length of an array
    # length=${#array[@]}
     
    # # use C style for loop syntax to read all values and indexes
    # for (( j=2; j<length; j=$[j+3] ));
    # do
    #   printf "Current index %d with value %s\n" $j "${array[$j]}"
      
    # done
    
    
    
    
    
    
    
    
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
        sequenceToken=$(aws logs put-log-events --log-group-name "$2" --log-stream-name "$3" --log-events timestamp=$(date +%s%N | Qcut -b1-13),message="$4" --sequence-token "$sequenceToken" | grep "nextSequenceToken" | awk '{print $2}' | tr -d '"')
    fi
    ft_error_checker "-[OK]CloudWatch Log Stream was successfully created." "-[FAIL]Cannot create Cloudwatch Log Stream. Something went wrong."
}

# temporary disabled logging to confgiure Session Manager Logging
function ft_resend_pwd {
    for i in "${!array[@]}"
    do
        echo "->${array[i]}"
        aws cognito-idp admin-create-user --region us-east-1 --user-pool-id $1 --username "${array[i]}" --message-action RESEND
        # if ($( aws cognito-idp admin-create-user --region us-east-1 --user-pool-id $1 --username "${array[i]}" --message-action RESEND )) ; then
        #     # ft_put_log_event $i $loggroup $logstream "${array[i]}=>DONE"
        #     echo "-[OK]${array[i]}=>DONE"
        # else
        #     # ft_put_log_event $i $loggroup $logstream "Cannot diasble user ${i}. Something went wrong."
        #     echo "-[FAIL]Cannot resend pwd for ${array[i]}. Something went wrong."
        #     exit 1
        # fi
    done
}

array=()
IFS=$'\n';

echo "Bash version ${BASH_VERSION}..."

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
 ft_resend_pwd $1
 
#  aws cognito-idp admin-create-user --region us-east-1 --user-pool-id us-east-1_0DcuU6kuk --username sundae4@gmail.com --message-action RESEND