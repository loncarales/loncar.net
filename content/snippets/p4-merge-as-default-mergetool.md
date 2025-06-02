+++
date = "2019-05-12"
title = "Git for Windows: Set up P4Merge as default mergetool"
slug = "p4-merge-as-default-mergetool"
+++

Open `git-bash` and type

```bash
git config --global merge.tool p4merge
git config --global mergetool.p4merge.cmd "p4merge \"$BASE\" \"$LOCAL\" \"$REMOTE\" \"$MERGED\""
git config --global mergetool.p4merge.trustExitCode false
git config --global mergetool.keepBackup false
git config --global diff.tool p4merge
git config --global difftool.p4merge.cmd "p4merge \"$LOCAL\" \"$REMOTE\""
```

The `.gitconfig` should look like this

```ini
[merge]
    keepBackup = false
    tool = p4merge
[mergetool]
    prompt = false
[mergetool "p4merge"]
    cmd = p4merge \"$BASE\" \"$LOCAL\" \"$REMOTE\" \"$MERGED\"
    keepTemporaries = false
    trustExitCode = false
    keepBackup = false
[diff]
    tool = p4merge
[difftool]
    prompt = false
[difftool "p4merge"]
    cmd = p4merge \"$LOCAL\" \"$REMOTE\"
    keepTemporaries = false
    trustExitCode = false
    keepBackup = false
```

### Related Post

* [Resolve Git merge conflicts the unpainful way]({{< ref "resolve-git-merge-conflicts.md" >}})
