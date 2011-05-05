#!/bin/bash

# try to find commits in $2 that are not in $1
# for example "check_commits.sh master feature" should show you any commits into 
# feature that didn't make it into master
# ignoring bugzilla id's

branch_1=$1
shift
branch_2=$1
shift
log_opts=
log_options=$*
if [ ! -z "$log_options" ] ; then
	log_opts=$log_options
fi
commits=$(git --no-pager rev-list $branch_1..$branch_2)

for commit in $commits
do
	# ignore tito and merge commits
	msg=$(git --no-pager log --pretty=format:"%s%n" -n1 $commit | grep -v Merge | grep -v Automatic | perl -pe "s/^[[:digit:]]+:\s*//g")
        match=$(git --no-pager log --oneline -n1 -F --grep "$msg" $1)

        if [ -z "$match" ] ; then
		git --no-pager log --oneline -n1 $log_opts "$commit"
	fi
done
