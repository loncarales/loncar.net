+++ 
date = 2019-06-03T21:54:59+02:00
title = "Git for Windows: Filename too long"
slug = "git-for-windows-filename-too-long" 
+++

<script src="https://embed.cacher.io/81073fd10e64a915fba246945e2a4cf32c03ad44.js?a=b8c3f7ce58a948b7d98a7a69ed11dbb5&t=atom_one_dark"></script>

{{< figure src="https://s3.eu-central-1.amazonaws.com/loncar.net/filename-tool-long.png" alt="After applying core.longpats option the missing files are checked out" caption="After applying core.longpats option the missing files are checked out" >}}

## Note

With the above change, some of the scripts might fail. That's the reason for `core.longpaths` not enabled by default.

> 💡 Tip: Starting in Windows 10, version 1607, MAX_PATH limitations have been removed from common Win32 file and directory functions. However, you must opt-in to the new [behaviour](https://docs.microsoft.com/en-us/windows/desktop/fileio/naming-a-file).
