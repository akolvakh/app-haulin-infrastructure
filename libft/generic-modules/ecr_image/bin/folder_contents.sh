#!/bin/bash

# Fail fast
set -e

# List of arguments
build_context=$1

# Take md5 from each object inside the program and then take a md5 of that output
md5_output=$(eval md5sum ${build_context}/** | md5sum )

# Output result as JSON back to terraform
echo "{ \"md5\": \"${md5_output}\" }"