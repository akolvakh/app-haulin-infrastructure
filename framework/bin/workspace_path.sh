#!/bin/sh -e

# SCRIPT LOCATION is ROOT/bin
BIN_DIR_REL_PATH=`dirname $0`
# This is the same as ROOT_DIR
ROOT_ABS_PATH=`realpath ${BIN_DIR_REL_PATH}/../..`
DEPLOYMENTS_PATH=${ROOT_ABS_PATH}/deployments/

echo $PWD | sed -e "s|$DEPLOYMENTS_PATH||g"