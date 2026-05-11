+++
date = 2019-09-30T21:54:59+02:00
title = "Git collection of snippets"
slug = "git-collection-snippets-collected"
tags = ["Git"]
categories = ["Professional Development"]
+++

Just a bunch of essential snippets for Git I've collected over the years.

* Simple, but useful git config file.

```ini
[column]
	ui = auto
[branch]
	sort = -committerdate
[tag]
	sort = version:refname
[init]
	defaultBranch = main
[apply]
	# Detect whitespace errors when applying a patch
	whitespace = fix
[core]
	editor = nvim
	autocrlf = input
	safecrlf = true
	pager = diff-so-fancy | less --tabs=4 -RFX
[interactive]
	diffFilter = diff-so-fancy --patch
[color]
	ui = true
[color "branch"]
	current = yellow reverse
	local = yellow
	remote = green
[color "diff"]
	meta = 11
	frag = magenta bold
	old = red bold
	new = green bold
	func = 146 bold
	commit = yellow bold
	whitespace = red reverse
[color "diff-highlight"]
	oldNormal = red bold
	oldHighlight = red bold 52
	newNormal = green bold
	newHighlight = green bold 22
[color "status"]
	added = yellow
	changed = green
	untracked = cyan
[merge]
	keepBackup = false
	tool = p4merge
[mergetool]
	prompt = false
[mergetool "p4merge"]
	cmd = p4merge "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
	keepTemporaries = false
	trustExitCode = false
	keepBackup = false
[diff]
	algorithm = histogram
	colorMoved = plain
	mnemonicPrefix = true
	renames = true
[difftool]
	prompt = false
[difftool "p4merge"]
	cmd = p4merge "$LOCAL" "$REMOTE"
	keepTemporaries = false
	trustExitCode = false
	keepBackup = false
[web]
	browser = google-chrome
[push]
	default = simple
	autoSetupRemote = true
	followTags = true
[fetch]
	prune = true
	pruneTags = true
	all = true
[rebase]
	autoSquash = true
	autoStash = true
	updateRefs = true
[help]
	autocorrect = prompt
[filter "lfs"]
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
	clean = git-lfs clean -- %f
[commit]
	template = ~/git-commit-template.txt
	verbose = true
[rerere]
	enabled = true
	autoupdate = true
```

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

```ini
# Make sure you're adding under the [alias] block.
[alias]
    st = status
    s = status -s -b
    a = add
    ap = add -p
    c = commit --verbose
    ca = commit -a --verbose
    cm = commit -m
    cam = commit -a -m
    m = commit --amend --verbose
    d = diff
    ds = diff --staged
    dch = diff --name-status -r
    dca = diff --cached
    co = checkout
    cob = checkout -b
    fo = fetch origin
    po = push origin
    m = merge
    mstop = merge --no-commit
    mff = merge --no-ff
    mffstop = merge --no-ff --no-commit
    pi = cherry-pick -x
    pigo = cherry-pick --continue
    pistop = cherry-pick -x --no-commit

    # push all
    pushitgood = !echo 'Ah, push it' && git push -u origin --all && echo 'P-push it real good'
    # Undo clashes with git-extras
    rh = reset --hard
    unstage = reset HEAD --
    # delete merged branch
    cleanmerged = !git branch --merged | grep -v \"\\*\" | xargs -n 1 git branch -d
    # When used without any argument it will print all changes since the last tag (changelog clashes with git-extras)
    changes = "!f() { r=${1:-`git describe --tags --abbrev=0`..HEAD}; echo Changelog for $r; git log --reverse --no-merges --format='* %s' $r; }; f"
    ## Logs ##
    ##########
    # one-line log
    l = log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short
    hist = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative
    tree = log --oneline --decorate --graph
    last = log -1 HEAD
    new = !sh -c 'git log $1@{1}..$1@{0} "$@"'
    whois = "!sh -c 'git log -i -1 --pretty=\"format:%an <%ae>\n\" --author=\"$1\"' -"
    whatis = show -s --pretty='tformat:%h (%s, %ad)' --date=short
    # list branches sorted by last modified
    b = "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'"
    lg = !git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30
    br = branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate
    gone = ! "git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '$2 == \"[gone]\" {print $1}' | xargs -r git branch -D"

    # Git Commit, Add all and Push — in one step.
    cap = "!f() { git add .; git commit -m \"$@\"; git push; }; f"
    # NEW.
    new = "!f() { git cap \"📦 NEW: $@\"; }; f"
    # IMPROVE.
    imp = "!f() { git cap \"👌 IMPROVE: $@\"; }; f"
    # FIX.
    fix = "!f() { git cap \"🐛 FIX: $@\"; }; f"
    # RELEASE.
    rlz = "!f() { git cap \"🚀 RELEASE: $@\"; }; f"
    # DOC.
    doc = "!f() { git cap \"📖 DOC: $@\"; }; f"
    # TEST.
    tst = "!f() { git cap \"✅ TEST: $@\"; }; f"
```

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
