#!/bin/bash
#
# This attempts to generate a klugey API history report of python
# modules. It does this my creating a revision of the docs for
# every tagged version of the source. With a simple text based
# docs, end result is a 'git log -p' in the docs history repo
# should give you readable api diff between versions.
#
# Checkout https://github.com/alikins/python-rhsm-docs and run
# 'git log -p' for an example. Or look at
#    python-rhsm-git-docs-example.txt
#
# Don't expect this to work without hacking.
#
# Checkout out every tag of a git repo of a python project, 
#  generate epydoc for it, and commit to git repo with tags
#
#
#
# git_docs.sh /git/repo/with/python/code /git/repo/to/check/docs/into /src /test

# path to a git repo to checkout revisions from
# currently it will checkout each tag
SRCDIR=$1
shift

# where to write the docs to
DOCS_DIR=$1
shift

# versions to compare
END=$1
shift

START=$1
shift

# subdirs where to find *.py where to find the code we are generating docs from
PYDIRS="$*"

EXCLUDES="lib/ansible/modules/"
gen_docs() {
    for py in $(git ls-files -x ${EXCLUDES} ${PYDIRS} | grep .py$);
    do
        echo "$py"

        DOC_EXCLUDES="object.__"
        # greps and sed's just to clean up some noise in the output
        DOC=$(epydoc --simple-term --parse-only --debug --text "$py" | \
            grep -v "${DOC_EXCLUDES}" | \
            sed 's/[[:space:]]\+$//' | \
            sed 's/|/ /' | \
            sed 's/^[[:space:]]*$//');
        #echo "$DOC"
        MODULENAME=$(echo "$DOC" |sed -n '/^MODULE NAME/{ N;; s/[ \t]*.*\n//p; }' | tr -d ' ');
        if [ -n "${MODULENAME}" ] ; then
            echo "$DOC" > "${DOCS_DIR}/${MODULENAME}";
        fi
        done;
}

SRCDIR="/home/adrian/src/doctest/subscription-manager"
#for tag in $(cat tags.txt);
TAGS=$(git tag -l | sort --version-sort | grep -v "^-")
TAGS="$TAGS master"

TAGS="$START $END"
for tag in $TAGS
do
    echo "$tag"; 
    git checkout "$tag";
    gen_docs
    cd "${DOCS_DIR}";

    echo "committing to git" "$(pwd)"
    git add -v "${DOCS_DIR}/*";
    git commit -a -m "$tag"; 
    git tag "$tag"; 
    cd "${SRCDIR}"
    echo
    pwd
done 
