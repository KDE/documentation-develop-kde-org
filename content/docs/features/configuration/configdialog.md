---
SPDX-FileCopyrightText: 2006 Zack Rusin <zack@kde.org>
SPDX-LicenseRef: LGPL-2.0-or-later
title: KConfigDialog
description: The standard KDE QtWidgets configuration dialog
weight: 20
---

If you need a configuration dialog for your QtWidgets application, use
KConfigDialog.

KConfigDialog handles the enabling and disabling of buttons, creation of the
dialog, and deletion of the widgets. Because of KConfigDialogManager, this
class also manages: restoring the settings, resetting them to the default
values, and saving them.

This requires that the names of the widgets corresponding to configuration
entries have to have the same name plus an additional "kcfg_" prefix. For
example the widget named "kcfg_MyOption" would be associated with the
configuration entry "MyOption".

Here is an example usage of KConfigDialog:

```
void KCoolApp::showSettings(){
    if (KConfigDialog::showDialog(QStringLiteral("settings"))) {
      return;
    }
    KConfigDialog *dialog = new KConfigDialog(this, QStringLiteral("settings"), MySettings::self());
    dialog->setFaceType(KPageDialog::List);
    dialog->addPage(new General(0, "General"), i18n("General"));
    dialog->addPage(new Appearance(0, "Style"), i18n("Appearance"));
    connect(dialog, &KConfigDialog::settingsChanged, mainWidget, &Bar::loadSettings);
    connect(dialog, &KConfigDialog::settingsChanged, this, &Foo::loadSettings);
    dialog->show();
}
```

Other than the above code, each class that has settings in the dialog should
have a loadSettings() type slot to read settings and perform any necessary
changes.

For dialog appearance options (like buttons, default button, ...) please see
[KPageDialog](https://api.kde.org/frameworks/kwidgetsaddons/html/classKPageDialog.html).

For more information, consult the [api documentation of KConfigDialog](https://api.kde.org/frameworks/kconfigwidgets/html/classKConfigDialog.html)
