#!/bin/sh
# Does not computes github url for current folder, anymore.
# Why CI/CD mangles it?
# Just Branch, Tag(if any) and current relative path. 
# intended usage - for change mangement, to record what version of Infra as code was applied
u=$(git config remote.origin.url)
git_branch_or_tag=""
git_tag=$(git describe  --exact-match --tags $(git log -n1 --pretty='%h') 2>/dev/null)
if [ $? -ne 0 ]; then
git_tag="unknown"
fi
git_branch=$(git branch|grep '*'| cut -d' ' -f2 2>/dev/null)
if [ $? -ne 0 ]; then
	git_branch="unknown"
fi
git_branch=`echo $git_branch | tr -d '('`
git_tag=`echo $git_tag | tr -d '('`
# echo ${u%.git}/tree/${git_branch_or_tag}/$(git rev-parse --show-prefix)
echo "/branch:"${git_branch}"/tag:${git_tag}""/path:"$(git rev-parse --show-prefix)

