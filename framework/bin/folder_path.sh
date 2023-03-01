#!/bin/sh
#computes relative path to current git sorcee fodler, starting from git repo root
# with final "/" truncated
# for the sake of reusing in terraform apply time versino control. AWS SSM lets us put <path to current source>=<git tag/branch for current source>
# but SSM insists on no trailing "/" in the <path to current source>=
CURRENT_TF_FOLDER_PATH=$(git rev-parse --show-prefix)
echo ${CURRENT_TF_FOLDER_PATH%/*}
