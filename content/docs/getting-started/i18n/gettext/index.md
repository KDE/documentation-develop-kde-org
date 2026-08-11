---
title: "Overview: gettext and xgettext"
weight: 1
description: >
  Understanding how gettext is used
---

KDE software is made with Qt, but does not use [Qt's internationalization framework](https://doc.qt.io/qt-6/i18n-source-translation.html). Instead, KDE uses [GNU gettext](https://www.gnu.org/software/gettext/).

Gettext is a framework: it provides a C library to make software translatable (`libintl.h`), as well as terminal tools to process translations.

The `libintl.h` library is imported automatically by KI18n, so you won't ever need to handle it manually.

Among the many terminal tools gettext provides, the most important ones for KDE software are:

* xgettext
* msgfmt
* msgmerge

A simplified version of the suggested gettext workflow is as follows:

1. The developer marks strings for translation with `libintl.h` and its functions
2. `xgettext` extracts the strings marked for translation in your application (*messages*) and puts them in human-readable POT files, called *message catalogs*
3. If the source code was modified, generating a different POT file, the new POT file is used to update existing translated PO files with `msgmerge`
4. POT files, which are template files for translation, are copied and turned into PO files by translators
5. Translators translate these PO files
6. The translated PO file is sent back to the project
7. PO files are turned into machine-readable MO files using `msgfmt`
8. The generated MO files are installed to a directory the application will look into at runtime

A resource explaining how this workflow typically looks like for C++ beginners is [Getting started with GNU gettext for C++](https://erri120.github.io/posts/2022-05-05/).

KDE improves on this workflow:

* KI18n provides more conveniences than `libintl.h` and integrates certain steps with other KDE libraries, such as KAboutData
* Scripty reads a file called `Messages.sh` and extracts and merges messages for you
* KI18n provides a single-line CMake macro to automatically generate MO files at build time and install them in their right places

To make their software translatable, developers utilizing KDE infrastructure only need to:
* Set up KAboutData and KI18n
* Write a simple `Messages.sh` file
* Make sure that their application's user-facing strings are marked for translation

This is explained in the next pages, [KI18n](#) and [Scripty and string extraction](#).

Developers using KI18n but not KDE infrastructure (Scripty) should follow [Plasmoids and third party software](#).
