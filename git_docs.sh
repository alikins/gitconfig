#!/bin/bash


DOCS_DIR=/home/adrian/src/subscription-manager-docs/

gen_docs() {
    for py in $(git ls-files src/subscription_manager/ src/rct/ src/plugins/ src/subscription_manager/gui/| grep .py$);
    do
        echo "$py"

        DOC=$(epydoc --debug --text "$py");
        #echo "$DOC"
        MODULENAME=$(echo "$DOC" |sed -n '/^MODULE NAME/{ N;; s/[ \t]*.*\n//p; }' | tr -d ' ');
        if [ -n "${MODULENAME}" ] ; then
            echo "$DOC" > "${DOCS_DIR}/${MODULENAME}";
        fi
        done;
}


SRCDIR="/home/adrian/src/subscription-manager"
for tag in $(cat tags.txt);
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
