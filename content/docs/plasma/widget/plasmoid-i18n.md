---
title: "Making your plasmoid translatable"
weight: 5
description: >
  With KI18n
aliases:
  - /docs/plasma/widget/translations-i18n/
---

This page serves as an outline of what needs to be done to make your plasmoid translatable.
A more comprehensive guide is available in [Make KDE software translatable](#).

To translate your plasmoid, you use [KI18n](#) to mark translatable strings in your C++ and QML code.

If you are using KDE infrastructure, you may use [Messages.sh and Scripty](#) to automate extracting those translatable strings and sending it to translators.

If you are NOT using KDE infrastructure, then you may use [Zren's scripts](https://github.com/Zren/plasma-applet-lib/tree/master/package/translate
) for extracting strings into POT files, merging new changes to POT files into existing PO files, and generating the binary MO files that your plasmoid will access at runtime to choose translated strings. You can otherwise make your own script using `xgettext`, `msgmerge` and `msgfmt` for this process. Both [Overview: gettext and xgettext](#) and [Plasmoids and third party software](#) should assist you in making such a script.

In either case, the binary MO files are shipped in your [.plasmoid](#) package or together with the plasmoid's source code in the following structure:

```tree
<plasmoid-name>
├── contents/
│   ├── locale/
│   │   └── <language-code>
│   │       └── LC_MESSAGES
│   │           └── <plasmoid-name>.mo   # <--
│   └── ui/
│       ├── configGeneral.qml
│       └── main.qml
├── Messages.sh
├── metadata.json
└── po/                                  # <--
    ├── template.pot                     # <--
    └── <language-code>.po               # <--
```

