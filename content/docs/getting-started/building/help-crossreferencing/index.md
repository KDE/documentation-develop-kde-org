---
title: "Source code cross-referencing"
description: "How to search for examples in existing KDE software"
weight: 4
group: "help"
---

To search for a class, method, signal name or any other sort of code in all KDE repos, including QML and CMake, KDE provides a code referencing tool to index code in the various KDE repositories: the [KDE Source Code Cross Reference (LXR)](https://lxr.kde.org/) website.

By clicking on the `Branch group` menu at the top right, you can select whether you'd like to see KDE software in Qt5 or Qt6, and whether to search for code in the master branches or from the stable (released) branches.

LXR has two search modes:

1. On the "Identifier" search page, you can search for:
  * Class names, for example `RenameDialog`, `StatJob`, `QLatin1String`, or `QListWidget`.
  * Method names, for example `addConfigSources`, `setAboutData`, or `deleteLater`.
  * Signal names, for example `mimeTypeFound` or `errorOccurred`.

{{< figure class="text-center mr-5 pr-5" caption="The LXR identifier search." src="lxr-identifier.webp" >}}

2. On the "General search" page you can search for strings:
  * For example, if you'd like to find in which source file the string "Paste Clipboard Contents" from Dolphin's context menu is defined, type "Paste Clipboard Contents" in the `Or containing:` field. This search includes class, method, and signal names.

{{< figure class="text-center mr-5 pr-5" caption="The LXR general search." src="lxr-general.webp" >}}

Other ways to search across all of the KDE git repositories:

* By using [KDE's Gitlab instance](https://invent.kde.org): pressing `/` or clicking on the search bar from the home page will trigger a global search. You can also visit a specific project's repository and use the same mechanism to search in the project's code.
* By using a local checkout of several repositories with kde-builder: `kde-builder --src-only` will download the source code of more than 300 KDE git repositories in `~/kde/src`. You can then search inside this directory using any tool, like `grep "search query" --recursive --ignore-case`.
