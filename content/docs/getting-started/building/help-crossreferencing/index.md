---
title: "Source code cross-referencing"
description: "How to search for examples in existing KDE software"
weight: 4
group: "help"
---

To search for a class, method, signal name or any other sort of code in all KDE repos, including QML and CMake, KDE provides a code referencing tool to index code in the various KDE repositories: the [KDE Source Code Cross Reference (LXR)](https://lxr.kde.org/) website.

By clicking on the "Branch group" menu at the top right, you can select whether you'd like to see KDE software in Qt5 or Qt6, and whether to search for code in the master branches or from the stable (released) branches.

LXR has two search modes:

1. On the "Identifier" search page, you can search for:
  * Class names such as `RenameDialog`, `StatJob`, and of course any Qt class (used in KDE code, which is pretty much all of them), `QLatin1String`, `QListWidget`
  * Method names such as `addConfigSources()` (from the KConfig framework) and signal names like `mimeTypeFound()`

{{< figure class="text-center mr-5 pr-5" caption="The LXR identifier search." src="lxr-identifier.webp" >}}

2. On the "General search" page you can search for strings:
  * For example, if you'd like to find in which source file the string "Paste Clipboard Contents" from Dolphin's context menu (accessed by right-clicking any empty space) is defined, type "Paste Clipboard Contents" in the `Or containing:` field. This search includes classes/methods/signals names.

{{< figure class="text-center mr-5 pr-5" caption="The LXR general search." src="lxr-general.webp" >}}

Other ways to search across all of the KDE git repositories:

* By using KDE's Gitlab instance, [Invent](https://invent.kde.org): pressing `/` or clicking on the search bar from the home page will trigger global search and show global code search **only if you are logged in**. Otherwise, you may also visit a specific project repository and use the same mechanism to search in the project's code (**this does not require you to be logged in**).
* By using a local checkout of several repositories with kdesrc-build: `kdesrc-build --src-only` will download the source code of more than 300 KDE git repositories in ~/kde/src. You can then search inside this directory using any tool. For example: `grep "search query" --recursive --ignore-case`.
