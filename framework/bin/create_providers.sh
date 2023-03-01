#!/usr/bin/env bash

set -e

TARGET_DIR=`pwd`
BIN_DIR=`dirname $0`
#Git repo root.
ROOT_DIR=`dirname $BIN_DIR` # home/ec2-user/environment/phoenix-infrastructure
#dir where curent infra stack TF folders are kept
DEPLOYMENT_DIR=`dirname $TARGET_DIR` # /home/ec2-user/environment/phoenix-infrastructure/deployments/phoenix-app-modularized

. $BIN_DIR/functions.include

log_trace "create providers.tf"
#find template file. Order is
# 1. framework/templates/providers.tpl in current dir
# 2. <git repo>/deployments/<current_deployment>/framework/templates/providers.tpl
# 3. <git-repo>/framework/templates/providers.tpl
# where top in priority lists trumps out lowest ones

TEMPLATE_REL_PATH="/framework/templates/providers.tpl"

if [ -f $TARGET_DIR/$TEMPLATE_REL_PATH ] ; then
	TEMPLATE_FILE=$TARGET_DIR/$TEMPLATE_REL_PATH
elif [ -f $DEPLOYMENT_DIR/$TEMPLATE_REL_PATH ] ; then
	 TEMPLATE_FILE=$DEPLOYMENT_DIR/$TEMPLATE_REL_PATH
elif [ -f $ROOT_DIR/$TEMPLATE_REL_PATH ]; then
	TEMPLATE_FILE=$ROOT_DIR/$TEMPLATE_REL_PATH
else
	log_trace "No template for providers.tf found! Quetly step back for the sake of seamkess transition period/coexistence with old approach"
	exit 0
fi



cat $TEMPLATE_FILE >$TARGET_DIR/_generated_providers.tf
