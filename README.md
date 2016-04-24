my .gitconfig, see gitconfig for inline comments.

Some are stuff I use a lot. A lot are things I
use occasionally, so this just documents them. 

## General purpose tools

### git brage

Show a colorful list of git branches sorted by last commit date.

Think of it as the 'ls -lart' of 'git branch'. Supports 'git branch'
options (ala, '-a, '-r', etc)

### git checkout-tag 

Checkout a tag "FOO-1-0" into a branch called "FOO-1-0-branch".
```
$ git checkout-tag FOO-1-0
```

### git stat

Attempts to find untracked files that are likely to be candidates to be committed.

This uses 'ack' to build a list of things that look like source code. The idea
is to show a more focused list of candidates that 'git status -u' output.

### git unpushed

Alias for 'git cherry -v'. Shows a summary of commits in the local branch that have
not been pushed yet.

### git tagsort

List tags sorted by a version sort. Needs GNU sort (it uses 'sort --version-sort'). 
Useful if you tag releases with version info.

### git tagage

List tags sorted by the date they were created/tagged, ie, 'taggerdate'.
Useful if you work on multiple releases and are looking for 'the thing we
just released', which may not be the highest version (as used in tagsort).

### git cloneurl

Show the repo url of 'origin'.

```
16:34 $ git cloneurl
git://github.com/ansible/ansible.git
```

### git find

Search for a pattern in branch names, file names, or file contents.
A combo of 'find', 'git grep' plus branch search.

```
16:50 $ git find brage
  remotes/origin/add_dash_v_to_brage
bin/git-brage
bin/git-brage:    echo "git-brage [-v|--verbose] [extra for-each-ref options]"
gitconfig:    # brage = "!f() { git for-each-ref --sort=committerdate refs/heads $1  --format=\"%(refname:short)\" ; }; g() { for C in $(f $1) ; do git show -s --pretty=format:\"%Cgreen%ci %Cblue%cr%Creset  $C\" \"$C\" -- ; done; }; g "
gitconfig:    brageall = !git brage refs/remotes
gitconfig:    # TODO: make these options of 'git-brage' script
gitconfig:    tbrage = "!f() { git for-each-ref --sort=committerdate refs/heads $1  --format=\"%(refname:short)\" ; }; g() { for C in $(f $1) ; do UP=$(git rev-parse --symbolic-full-name --abbrev-ref $C@{upstream} 2> /dev/null); TRACKING=$?; UP=\"-> $UP \"; if [ $TRACKING -ne 0 ] ; then UP=\"\"; fi;  git show -s --pretty=format:\"%Cgreen%ci %Cblue%cr%Creset  $C $UP\" \"$C\" -- ; done; }; g "
gitconfig:    tbrageall = !git tbrage refs/remotes
```

### git churn

List the files in the repo with the most changes.

### git whatadded  $FILE

Show the commit that first added $FILE into the repo

### git list-by-type

Show a summary of files in the repo grouped by file extension.

### git ls-github

Show file/repo contents in a format similar to the github tree view.

```
16:22 $ git ls-github
LICENSE                1 year, 7 months ago Create LICENSE [Adrian Likins]
README.md              2 hours ago  README -> README.md [Adrian Likins]
gitattributes          3 years, 11 months ago Add config options to use po_diff/pot_diff for po files [Adrian Likins]
gitconfig              2 hours ago  Add epydoc diff viewer config [Adrian Likins]
```

### git burners

Provide a list of committers sorted by the number of lines of code committed by each.



## Non general purpose tools

Note: Some of the tools here are pretty specific
to my workflow, the tools I use, and the projects
I work on. So not everything here is general purpose.

###  git-checkcommits

install git-checkcommits to somewhere in
the PATH. usage is "git checkcommits master feature"
which will show commits in feature that don't seem
to be in master. It's based on comparing the subject
line, and try's to ignore subjects that start
with "12345:" (how we indicate bug id's). 

### git-showbugs

git-showbugs also needs to go in PATH, and requires
python-bugzilla setup. It looks for the same bug
id as above.

git-bugbyrelease shows bugs fixed in each release.
This is kind of specific to http://http://rm-rf.ca/tito
based builds.

## License

If not otherwise specified, the License here is GPLv2 or later.
But check the source/comments about each tool to verify. For
the most part tools borrowed from elsewhere will have comments
pointing to the original source. In those cases, the license
chosen by the original author would apply.
