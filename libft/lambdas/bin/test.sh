#!/bin/bash
source config.sh
 docker run --rm -p 9000:8080 -e API_DNS_NAME=alb-new-be-zytara-dev-232418385.us-east-1.elb.amazonaws.com  ${IMG_NAME}