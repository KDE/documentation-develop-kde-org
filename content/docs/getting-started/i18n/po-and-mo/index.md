---
title: "Testing translations locally"
weight: 5
description: >
  Checking that your internationalization is correct
---

## Making a new POT file {#new-pot-file}

Clone the [Scripty repository](https://invent.kde.org/sysadmin/l10n-scripty) and run `extract-messages.sh`:

```bash
git clone https://invent.kde.org/sysadmin/l10n-scripty ~/kde/i18n/scripty
cd <project-to-test>
PATH=~/kde/i18n/scripty/:$PATH extract-messages.sh
```

This will generate a new POT file for your project in `po/yourappname.pot`.

## Testing a new translation {#testing-a-new-translation}

To check that your application is properly internationalized, you can open the new POT file in [Lokalize](https://apps.kde.org/lokalize/), translate it yourself, and then add the translation to `po/<langcode>/yourappname.po`.

After that, just build **and install** your application as normal:

```bash
# If you're using kde-builder
kde-builder <project>
# If you're using manual CMake builds
cmake -B build/ --install-prefix ~/.local/
cmake --build build/
cmake --install build/
```

The installation step is required for translations to be detected by applications at runtime.

Running the newly installed application will show the translations for your current locale. If the translation differs from your current locale, you may override it with `$LANG` or `$LANGUAGE`.

## Testing changes to an existing translation {#testing-an-existing-translation}

If the project already has translations, in addition to the `extract-messages.sh` script mentioned in [Making a new POT file]({{< ref "#new-pot-file" >}}), you need to run `merge.sh` on the locale you want to test as well.

```bash
PATH=~/kde/i18n/scripty/:$PATH extract-messages.sh
PATH=~/kde/i18n/scripty/:$PATH merge.sh po/pt_BR/yourappname.po po/yourappname.pot
```

The first argument is the existing translated PO file, the second argument is the new POT file.

## Third party applications and plasmoids

Third party applications may use Scripty's extract-messages.sh and merge.sh, as described above. Both of these scripts are simple conveniences on top of `msgfmt` and `msgmerge` that perform the task without boilerplate.

Plasmoids can be prepared and tested differently, especially with [Zren's scripts](https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/). See [Plasmoids and third party software](#).
