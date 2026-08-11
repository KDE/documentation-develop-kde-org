---
title: "Make KDE software translatable"
weight: 2
description: >
  Learn how KDE's translation infrastructure works
group: "getting-started"
---

KDE software is made with Qt, but does not use [Qt's internationalization framework](https://doc.qt.io/qt-6/i18n-source-translation.html). Instead, KDE uses [GNU gettext](https://www.gnu.org/software/gettext/).

The [KI18n](https://api.kde.org/ki18n-index.html) KDE library builds on top of gettext and provides many convenience functions that make strings context aware.

You can learn more about how to use KI18n with the [KI18n Programmer's Guide](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md). These tutorial pages instead provide a general overview to get you started in making your software translatable.

After you make your software *internationalized*, or translatable, [KDE's automation tool Scripty](https://invent.kde.org/sysadmin/l10n-scripty) processes it and sends it to translators, who can then *localize* it, that is, translate it. Scripty then sends the translations back to the original repository.

By looking into how Scripty processes translations, you can test whether your software was properly made translatable, and make your projects outside KDE infrastructure translatable as well.

If you experience any difficulties or have doubts on how to make your software translatable, be sure to consult the [KI18n Programmer's Guide](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md) and ask questions in the [main Localization room](https://go.kde.org/matrix/#/#kde-i18n:kde.org) on [Matrix](https://community.kde.org/Matrix).
