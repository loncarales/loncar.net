+++
date = 2019-06-03T21:54:59+02:00
title = "Git for Windows: Filename too long"
slug = "git-for-windows-filename-too-long"
+++

```bash
$ git clone ssh://git@some-git-repo
Cloning into 'SOME_GIT_REPO'...
remote: Counting objects: 16307, done.
remote: Compressing objects: 100% (6522/6522), done.
remote: Total 16307 (delta 12659), reused 12167 (delta 9480)
Receiving objects: 100% (16307/16307), 3.99 MiB | 1.21 MiB/s, done.
Resolving deltas: 100% (12659/12659), done.
error: unable to create file src/app/custom-components/main-application-components/ke-profile-management/assign-restrictions-and-limitations/assign-restrictions-limitations-main-screen/assign-restrictions-limitations-main-screen.component.html: Filename too long
error: unable to create file src/app/custom-components/main-application-components/ke-profile-management/assign-restrictions-and-limitations/assign-restrictions-limitations-main-screen/assign-restrictions-limitations-main-screen.component.spec.ts: Filename too long
Checking out files: 100% (342/342), done.
fatal: unable to checkout working tree
warning: Clone succeeded, but checkout failed.
You can inspect what was checked out with 'git status'
and retry the checkout with 'git checkout -f HEAD'

# This command only applies `longpaths` to the current project
$ git config core.longpaths true
$ git checkout -f HEAD
```

{{< figure src="https://cdn.loncar.net/filename-tool-long.png" alt="After applying core.longpats option the missing files are checked out" caption="After applying core.longpats option the missing files are checked out" >}}

## Note

With the above change, some of the scripts might fail. That's the reason for `core.longpaths` not enabled by default.

> 💡 Tip: Starting in Windows 10, version 1607, MAX_PATH limitations have been removed from common Win32 file and directory functions. However, you must opt-in to the new [behaviour](https://docs.microsoft.com/en-us/windows/desktop/fileio/naming-a-file).
