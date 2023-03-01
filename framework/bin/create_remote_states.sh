#!/usr/bin/env bash
set -e
set -o pipefail

#precondition - every TF code layer is folder nameed as [0-9]+.[a-z]
#TF code in folders with higher numbers is/can be dependent on code with lover numbers.
#never opposite
#sample 10.vpc, 20.alb, 20.db , 30.ecs

BIN_DIR=`dirname $0`
. $BIN_DIR/functions.include

fail () {
    printf '%s\n' "$1" >&2
    exit "${2-1}"
}

if [ -z ${S3_BUCKET} ]; then
    echo "S3_BUCKET variable is not set"
    exit 1
fi

if [ -z ${REMOTE_STATE_PATH_PREFIX} ]; then
    echo "REMOTE_STATE_PATH_PREFIX variable is not set"
    exit 1
fi

if [ -z ${REMOTE_STATE_PATH_SUFFIX} ]; then
    echo "REMOTE_STATE_PATH_SUFFIX variable is not set"
    exit 1
fi

if [ -z ${REGION} ]; then
    echo "REGION variable is not set"
    exit 1
fi

if [ -z ${DYNAMODB_TABLE} ]; then
    echo "DYNAMODB_TABLE variable is not set"
    exit 1
fi



layer_get_current () {
  dir=${PWD##*/}
  regex="([0-9]+)\.*"
  if [[ $dir =~ $regex ]]
    then
        echo "${BASH_REMATCH[1]}"
    else
	    #assume user does not want us auto generate for him data.terraform_remote_state(s).Quietly step back
	exit 0
        #echo "current dir name must match regex $regex. Got $dir instead" >&2 # this could get noisy if there are a lot of non-matching files
        #return 2
    fi

}

cur_layer="$(layer_get_current)" || fail "can not get current layer"

layer_get_preceding () {
  local cur=$1
  local all_layers=$(cd .. && find  -maxdepth 1  -type d -regex '\./[0-9]+.+' )
  regex="./([0-9]+)\.*"
  for layer in $all_layers
  do
    if [[ $layer =~ $regex ]]
    then
        local layer_number=${BASH_REMATCH[1]}
        #is it preceding current one? i.e. number less?
        if [[ $layer_number -lt $cur ]]
        then
            echo ${layer#./}
        fi

    fi
  done
}



remote_state_generate () {
#TF module we (may) depend on, folder name. Sample: 20.rds
local module_path=$1
#Sample 'rds'
local module_friendly_name=$(echo $module_path |sed -e "s|^[0-9]\+\.||g")
local output_file="_generated_data_remote_state.${module_path}.tf"
#    key     = "env:/dev-us-west-1/phoenix-app-modularized/10.vpc/terraform.tfstate"

# TBD  - extract the file generation into fnction, included/reusable from create_remote_state/create_backend_config
# WHY terraform remote_state s3 backend is inconsistent with just S3 backend?
# their config looks almost identical, except that prefix env:/dev-us-west-1/ silently added by backend, but not assumed by remote_state....
(cat <<-END
# Caution: Generated configuration - should not be edited directly.
data "terraform_remote_state" "${module_friendly_name}" {
  backend = "s3"
  workspace = terraform.workspace # ref https://github.com/hashicorp/terraform/issues/17153
  config = {
    bucket  = "${S3_BUCKET}"
    key     = "${REMOTE_STATE_PATH_PREFIX}/${module_path}${REMOTE_STATE_PATH_SUFFIX}"
    region  = "${REGION}"
    encrypt = true
    dynamodb_table = "${DYNAMODB_TABLE}"
  }
}

END
)>$output_file

}


modules_we_may_depend_on="$(layer_get_preceding $cur_layer)"

for tf_module in $modules_we_may_depend_on
do
log_trace "generating remote_state for dependencies from $tf_module, if any"
$(remote_state_generate $tf_module)
done
