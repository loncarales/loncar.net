+++ 
date = 2019-06-03T21:54:59+02:00
title = "Git for Windows: Filename too long"
slug = "git-for-windows-filename-too-long" 
+++

<script src="https://embed.cacher.io/85073fd40935ac48f8fc1290037e49a02c5aff47.js?a=6ef8f37435077a74b000b049fbd321d4"></script>

{{< figure src="https://s3.eu-central-1.amazonaws.com/loncar.net/filename-tool-long.png" alt="After applying core.longpats option the missing files are checked out" caption="After applying core.longpats option the missing files are checked out" >}}

## Note

With the above change, some of the scripts might fail. That's the reason for `core.longpaths` not enabled by default.

> 💡 Tip: Starting in Windows 10, version 1607, MAX_PATH limitations have been removed from common Win32 file and directory functions. However, you must opt-in to the new [behaviour](https://docs.microsoft.com/en-us/windows/desktop/fileio/naming-a-file).
