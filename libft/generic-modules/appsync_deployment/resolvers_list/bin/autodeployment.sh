#!/bin/bash

# Array indexes
# a0 => datasource waitListLambda 
# a1 => kind  unit 
# a2 => type  mutation 
# a3 => field  requestEarlyAccess 
# a4 => request/response 
# a5 => file format

# Problems
# naming convention for appsyn kind should be uppercase: unit => UNIT
# naming convention for appsyn data sources should the same as in filename: rest => rest_endpoint

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

array=()

# get list of resolver files in folder
filenames=`cd $1 && ls *request.txt`

# put 
i=0
for eachfile in $filenames
do
   array[$i]=$eachfile
   i=$[i+1]
done

count=$i
c=0

# reset resolvers.list for terraform module
> $SCRIPT_DIR/resolvers.list

# prepare env variables
#printf 'variable "aws_region" {} \nvariable "environment" {}\n' >> $SCRIPT_DIR/resolvers.list

# generate list(object) $SCRIPT_DIR/resolvers.list for terraform module
#printf 'variable "array" { \n default = [\n' >> $SCRIPT_DIR/resolvers.list

printf '[' >> $SCRIPT_DIR/resolvers.list

for item in ${array[*]}
do
    IFS='.' read -r -a variables <<< "$item"
    echo "{" >> $SCRIPT_DIR/resolvers.list
    i=0
    for element in "${variables[@]}"
    do
    if [ $i == 5 ]; then 
        echo \"a$i\" : \"$element\" >> $SCRIPT_DIR/resolvers.list
    else 
        echo \"a$i\" : "\"$element\"," >> $SCRIPT_DIR/resolvers.list
    fi
    i=$[i+1]
    done
    if [ $c == $[count-1] ]; then
        echo "}" >> $SCRIPT_DIR/resolvers.list
    else
        echo "}," >> $SCRIPT_DIR/resolvers.list
    fi
    c=$[c+1]
done

printf "]" >> $SCRIPT_DIR/resolvers.list
# printf "}" >> $SCRIPT_DIR/resolvers.list
#printf "]\n}" >> $SCRIPT_DIR/resolvers.list
