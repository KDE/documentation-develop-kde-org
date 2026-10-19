---
title: "Scripty and string extraction"
weight: 3
description: >
  Preparing Messages.sh to KDE's automation tool
---

This page assumes you have read [Gettext and xgettext]({{< ref "gettext" >}}) and [KI18n]({{< ref "ki18n" >}}) first.

[KDE's automation tool Scripty](https://invent.kde.org/sysadmin/l10n-scripty) does multiple things:

* it scans multiple [Invent repositories](#) and extracts messages, generating new POT files
* if translatable strings in source code have changed, it will *merge* those POT files onto translated PO files with `msgmerge`
* it sends the relevant POT and PO files to KDE's SVN repositories, available in <https://websvn.kde.org>
* it checks that the translated PO files have changed in SVN, and sends them back to the relevant Invent repositories
* it follows this process for Docbooks, desktop files (with [intltool](https://www.freedesktop.org/wiki/Software/intltool/)), appstream files, and others
* and much more

Scripty will only scan Invent repositories that contain a `Messages.sh` file. This script determines which source code files have translatable strings in them by using simple `find` terminal commands and passing them to `xgettext`.

## Messages.sh

An example `Messages.sh` file for a QML project would look like this:

```bash
#! /usr/bin/env bash
# SPDX-FileCopyrightText: None
# SPDX-License-Identifier: CC0-1.0
$XGETTEXT `find . \( -name \*.cpp -o -name \*.h \)` -o $podir/yourappname.pot
$XGETTEXT --join-existing --language=JavaScript $(find . -name \*.qml -o -name \*.js) -o "$podir"/yourappname.pot
```

As mentioned in [Gettext and xgettext]({{< ref "gettext" >}}), `xgettext` is the terminal tool provided by the gettext project to extract strings from your application, and indeed it is what Scripty uses under the hood, replacing the `XGETTEXT` variable with its invocation.

In [KI18n]({{< ref "ki18n" >}}), you have learned about the existence of many `i18n()` functions. `xgettext` is actually searching the source code for the *keyword* `i18n()`, as well as `i18nc()`, `i18np()`, etc., and to do so with xgettext one needs to pass many terminal flags, one for each keyword, which can be cumbersome to do manually. The full 20+ lines command invocation can be seen in [l10n-scripty/extract-messages.sh](https://invent.kde.org/sysadmin/l10n-scripty/-/blob/master/extract-messages.sh).

The important part of the `Messages.sh` file is that xgettext runs on a list of files with translatable strings and outputs a *message catalog* under the form of a POT file.

For QML it is useful to parse QML files as JavaScript for better newlining behavior, but the `--language=JavaScript` flag shouldn't apply to `.cpp` and `.h` files, so it requires a second invocation. Multiple invocations of the xgettext command would typically overwrite the output POT file, so `--join-existing` is needed to output to the same message catalog.

You should change the `Messages.sh` file depending on the file extensions you use in your project (some projects prefer `.cxx` or `.hpp`), and depending on your chosen language too (for example, if using [Python bindings]({{< ref "python-bindings" >}}) or [Rust bindings]({{< ref "rust-bindings" >}}) for KI18n).
