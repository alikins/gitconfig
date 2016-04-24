my .gitconfig, see gitconfig for inline comments.

Some are stuff I use a lot. A lot are things I
use occasionally, so this just documents them. 

* General purpose tools


* Non general purpose tools

Note: Some of the tools here are pretty specific
to my workflow, the tools I use, and the projects
I work on. So not everything here is general purpose.

*** git-checkcommits

install git-checkcommits to somewhere in
the PATH. usage is "git checkcommits master feature"
which will show commits in feature that don't seem
to be in master. It's based on comparing the subject
line, and try's to ignore subjects that start
with "12345:" (how we indicate bug id's). 

** git-showbugs

git-showbugs also needs to go in PATH, and requires
python-bugzilla setup. It looks for the same bug
id as above.

git-bugbyrelease shows bugs fixed in each release.
This is kind of specific to http://http://rm-rf.ca/tito
based builds.

* License

If not otherwise specified, the License here is GPLv2 or later.
But check the source/comments about each tool to verify. For
the most part tools borrowed from elsewhere will have comments
pointing to the original source. In those cases, the license
chosen by the original author would apply.
