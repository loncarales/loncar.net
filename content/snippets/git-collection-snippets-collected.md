+++
date = 2019-09-30T21:54:59+02:00
title = "Git collection of snippets"
slug = "git-collection-snippets-collected"
+++

Just a bunch of essential snippets for Git I've collected over the years.

* Simple, but useful git config file.

{{< snippet file="snippets/.gitconfig" lang="ini" >}}

* Git commit template to improve your project's commit messages.

```bash
# Type should be one of the following:
# * feat (new feature)
# * fix (bug fix)
# * docs (changes to documentation)
# * style (formatting, missing semi colons, etc; no code change)
# * refactor (refactoring production code)
# * test (adding missing tests, refactoring tests; no production code change)
# * chore (updating grunt tasks etc; no production code change)
# Scope is just the scope of the change. Something like (admin) or (teacher).
# Subject should use impertivite tone and say what you did.
# The body should go into detail about changes made.
# The footer should contain any JIRA (or other tool) issue references or actions.

# For a full example of how to write a good commit message, check out
# https://github.com/sparkbox/how_to/tree/master/style/git

# ---------------------------------------------------------------------------------
# Jira Issue Processing
# ISSUE_KEY #comment This is a comment
# ISSUE_KEY #done
# ---------------------------------------------------------------------------------
```

* Git Aliases

{{< snippet file="snippets/.git-aliases" lang="ini" >}}

* Git Hook to prevent direct push to master branch - just in case ;)

```bash
#!/bin/bash

protected_branch='master'
current_branch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

if [ $protected_branch = $current_branch ]
then
    read -p "You're about to push master, is that what you intended? [y|n] " -n 1 -r < /dev/tty
    echo
    if echo $REPLY | grep -E '^[Yy]$' > /dev/null
    then
        exit 0 # push will execute
    fi
    exit 1 # push will not execute
else
    exit 0 # push will execute
fi
```
