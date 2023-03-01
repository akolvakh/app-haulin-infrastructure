#!/bin/sh
if [ -z $ver ]
then
echo "set version in ver variable"
exit
fi
source build.sh
source deploy.sh