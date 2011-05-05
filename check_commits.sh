#!/bin/bash

# try to find commits in $2 that are not in $1
# for example "check_commits.sh master feature" should show you any commits into 
# feature that didn't make it into master
# ignoring bugzilla id's
commits=$(git --no-pager rev-list $1..$2)

for commit in $commits
do
	# ignore tito and merge commits
	#msg=$(git --no-pager log --pretty=format:"%s%n" -n1 $commit | grep -v Merge | grep -v Automatic | perl -pe "s/^[[:digit:]]+://g")
	msg=$(git --no-pager log --pretty=format:"%s%n" -n1 $commit |  perl -pe "s/^[[:digit:]]+://g")
	# ignore the first couple chars
	echo $msg
        match=$(git --no-pager log --oneline -n1 -F "$msg" $1)
        if [ -z "$match" ] ; then
		echo "$commit" $(git --no-pager log --oneline -n1 "$commit")
	fi
done
