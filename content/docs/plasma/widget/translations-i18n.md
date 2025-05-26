---
title: "Translations / i18n"
weight: 7
description: >
  Translate your widget
aliases:
  - /docs/plasma/widget/translations-i18n/
---

## ki18n

<!-- TODO: port the programmer's guide to QDoc -->

[Ki18n](docs:ki18n;ki18n-index.html) (**K**DE **i**nternationalizatio**n**) is the translation library for KDE. It has a [programmer's guide](https://api.kde.org/frameworks/ki18n/html/prg_guide.html) which you can read, but we'll cover the basics here.


## i18n()

{{< sections >}}
{{< section-left >}}

Translated strings need to be wrapped in the `i18n(...)` function. Note that single quotes `i18n('Test')` will be ignored by the tool that parses your code for all the translation strings. Always use double quotes `i18n("Test")`.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/configGeneral.qml</div>

```qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import org.kde.kirigami 2.4 as Kirigami

Kirigami.FormLayout {
    CheckBox {
        Kirigami.FormData.label: i18n("Feature:")
        text: i18n("Enabled")
    }
}
```
{{< /section-right >}}
{{< /sections >}}


## Variables in i18n()

{{< sections >}}
{{< section-left >}}

The `i18n(...)` is an overloaded function which allows you to pass values into the translation `i18n(format, variable1, variable2)`. Just place `%1` where you want the first variable to be substituted, and `%2` where the second should go.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
Item {
    id: showThing
    property int unreadEmailCount: 3
    Plasmoid.toolTipSubText: i18n("%1 unread emails", unreadEmailCount)
}
```
{{< /section-right >}}
{{< /sections >}}

## Plural in i18n()

{{< sections >}}
{{< section-left >}}

In English, a translated sentence is different when there's just 1 item from when there is 2 or more items. `i18np(...)` can be used in such a situation.

An example from the [Ki18n docs](https://api.kde.org/frameworks/ki18n/html/prg_guide.html) is:

```qml
i18np("One image in album %2", "%1 images in album %2", numImages, albumName)
```

```qml
i18np("One image in album %2", "More images in album %2", numImages, albumName)
```

Using `i18np(...)` can improve our previous example. When `unreadEmailCount` was `1`, the tooltip would have read `"1 unread emails"`.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">contents/ui/main.qml</div>

```qml
Item {
    id: showThing
    property int unreadEmailCount: 3
    Plasmoid.toolTipSubText: i18np("%1 unread email", "%1 unread emails", unreadEmailCount)
}
```
{{< /section-right >}}
{{< /sections >}}

## Translation Folder Structure

{{< sections >}}
{{< section-left >}}
After we've wrapped all the messages in our code with `i18n(...)` calls, we then need to extract all the messages for our translators into a `template.pot` file which they can then create a `fr.po` for their French translations.

We'll place the `template.pot` file under a `translate` folder inside the bundled package so that our users can easily translate our widget when they go poking into our code.

We'll also create a `merge.sh` script which will extract the messages from our code into a `template.pot`, then update the translated `fr.po` file with any changes.

Lastly, we'll make a `build.sh` script to convert the `fr.po` text files into the binary `.mo` files which are needed for KDE to recognize the translations.

{{< alert color="info" >}}
The latest copy of my `merge.sh` and `build.sh` can be found here:

* <a class="alert-link" href="https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/merge"><code>translate/merge.sh</code></a>
* <a class="alert-link" href="https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/build"><code>translate/build.sh</code></a>
{{< /alert >}}

A working example can be seen in the Tiled Menu widget:

* [Zren/plasma-applet-tiledmenu/.../translate/](https://github.com/Zren/plasma-applet-tiledmenu/tree/master/package/translate)

{{< /section-left >}}
{{< section-right >}}

```txt
└── ~/Code/plasmoid-helloworld/
    └── package
        ├── contents
        │   └── ...
        ├── translate
        │   ├── build.sh
        │   ├── fr.po
        │   ├── template.pot
        │   └── merge.sh
        └── metadata.desktop
```

After running `build.sh` we should end up with:

```txt
└── ~/Code/plasmoid-helloworld/
    └── package
        ├── contents
        │   └── locale
        │       └── fr
        │           └── LC_MESSAGES
        │               └── plasma_applet_com.github.zren.helloworld.mo
        └── ...
```


{{< /section-right >}}
{{< /sections >}}


## Install GetText

{{< sections >}}
{{< section-left >}}

After we've wrapped all the messages in our code with `i18n(...)` calls, we then need to extract all the messages for our translators into a `template.pot` file.

To do this, we need to install the `gettext` package.

{{< /section-left >}}
{{< section-right >}}
```bash
sudo apt install gettext
```
{{< /section-right >}}
{{< /sections >}}


## Generating template.pot

{{< sections >}}
{{< section-left >}}

First thing we need to do in our `merge.sh` script, is list all files we wish to get translated in our widgets code.

{{< alert color="info" >}}
The latest copy of my complete `merge.sh` script <a class="alert-link" href="https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/merge">can be found here</a>.
{{< /alert >}}

`DIR` is the directory (absolute path to `package/translate/`) since we may run the merge script from another directory.

We use `kreadconfig5` to grab the widget's namespace (`com.github.zren.helloworld`) and store it in `plasmoidName`. We then remove the beginning of the namespace so we are left with `helloworld` and store that in `widgetName`. We also grab the website which a link to the GitHub repo for use as the `bugAddress`.

After validating that `plasmoidName` is not an empty string with bash's `[ -z "$plasmoidName" ]` operator, we then list all `.qml` and `.js` files using `find` and store the results of the command in a temporary `infiles.list` file.

Then we generate a `template.pot.new` using the `xgettext` command. After generating it, we use `sed` to replace a few placeholder strings.

In [the complete `merge.sh`](https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/merge#L32), we also parse the widget name in `metadata.desktop` first with `xgettext --language=Desktop` and `--join-existing` in the 2nd `xgettext` call.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">translate/merge.sh</div>

```bash
#!/bin/sh

DIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
plasmoidName=`kreadconfig5 --file="$DIR/../metadata.desktop" --group="Desktop Entry" --key="X-KDE-PluginInfo-Name"`
widgetName="${plasmoidName##*.}" # Strip namespace
website=`kreadconfig5 --file="$DIR/../metadata.desktop" --group="Desktop Entry" --key="X-KDE-PluginInfo-Website"`
bugAddress="$website"
packageRoot=".." # Root of translatable sources
projectName="plasma_applet_${plasmoidName}" # project name

#---
if [ -z "$plasmoidName" ]; then
    echo "[merge] Error: Couldn't read plasmoidName."
    exit
fi

#---
echo "[merge] Extracting messages"
find "${packageRoot}" -name '*.cpp' -o -name '*.h' -o -name '*.c' -o -name '*.qml' -o -name '*.js' | sort > "${DIR}/infiles.list"

xgettext \
    --files-from=infiles.list \
    --from-code=UTF-8 \
    --width=400 \
    --add-location=file \
    -C -kde -ci18n -ki18n:1 -ki18nc:1c,2 -ki18np:1,2 -ki18ncp:1c,2,3 -ktr2i18n:1 -kI18N_NOOP:1 \
    -kI18N_NOOP2:1c,2  -kN_:1 -kaliasLocale -kki18n:1 -kki18nc:1c,2 -kki18np:1,2 -kki18ncp:1c,2,3 \
    --package-name="${widgetName}" \
    --msgid-bugs-address="${bugAddress}" \
    -D "${packageRoot}" \
    -D "${DIR}" \
    -o "template.pot.new" \
    || \
    { echo "[merge] error while calling xgettext. aborting."; exit 1; }

sed -i 's/"Content-Type: text\/plain; charset=CHARSET\\n"/"Content-Type: text\/plain; charset=UTF-8\\n"/' "template.pot.new"
sed -i 's/# SOME DESCRIPTIVE TITLE./'"# Translation of ${widgetName} in LANGUAGE"'/' "template.pot.new"
sed -i 's/# Copyright (C) YEAR THE PACKAGE'"'"'S COPYRIGHT HOLDER/'"# Copyright (C) $(date +%Y)"'/' "template.pot.new"
```
{{< /section-right >}}
{{< /sections >}}


## Updating template.pot

{{< sections >}}
{{< section-left >}}
Continuing our `merge.sh` script, we then check to see if an older `template.pot` file exists.

If it does, we'll replace the `POT-Creation-Date` in the new file with the older creation date, then run the `diff` command to detect if there's been any changes. If there has been changes, we fix the `POT-Creation-Date` and overwrite the old `template.pot` file. To make the changes more noticeable, we also list the added/removed translation messages.

If there hasn't been any changes, we simply delete the `template.pot.new` file.

Lastly, we delete the `infiles.list` to clean things up.
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">translate/merge.sh</div>

```bash
if [ -f "template.pot" ]; then
    newPotDate=`grep "POT-Creation-Date:" template.pot.new | sed 's/.\{3\}$//'`
    oldPotDate=`grep "POT-Creation-Date:" template.pot | sed 's/.\{3\}$//'`
    sed -i 's/'"${newPotDate}"'/'"${oldPotDate}"'/' "template.pot.new"
    changes=`diff "template.pot" "template.pot.new"`
    if [ ! -z "$changes" ]; then
        # There's been changes
        sed -i 's/'"${oldPotDate}"'/'"${newPotDate}"'/' "template.pot.new"
        mv "template.pot.new" "template.pot"

        addedKeys=`echo "$changes" | grep "> msgid" | cut -c 9- | sort`
        removedKeys=`echo "$changes" | grep "< msgid" | cut -c 9- | sort`
        echo ""
        echo "Added Keys:"
        echo "$addedKeys"
        echo ""
        echo "Removed Keys:"
        echo "$removedKeys"
        echo ""

    else
        # No changes
        rm "template.pot.new"
    fi
else
    # template.pot didn't already exist
    mv "template.pot.new" "template.pot"
fi

rm "${DIR}/infiles.list"
echo "[merge] Done extracting messages"
```
{{< /section-right >}}
{{< /sections >}}


## Examining template.pot

{{< sections >}}
{{< section-left >}}
Now that we've got a `template.pot`, let's take a look at it.

The messages we want to translate appear as `msgid "Show Thing"`, with the file it came from appearing in a comment in the line above. Underneath is an empty `msgstr ""` which is where the translator will place the translated messages.
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">translate/template.pot</div>

```python
# Translation of helloworld in LANGUAGE
# Copyright (C) 2018
# This file is distributed under the same license as the helloworld package.
# FIRST AUTHOR <EMAIL@ADDRESS>, YEAR.
#
#, fuzzy
msgid ""
msgstr ""
"Project-Id-Version: helloworld \n"
"Report-Msgid-Bugs-To: https://github.com/Zren/plasmoid-helloworldplugin\n"
"POT-Creation-Date: 2018-12-03 18:47-0500\n"
"PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
"Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
"Language-Team: LANGUAGE <LL@li.org>\n"
"Language: \n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: 8bit\n"

#: ../contents/configGeneral.qml
msgid "Show notification"
msgstr ""

#: ../contents/ui/configGeneral.qml
msgid "%1 unread emails"
msgstr ""

#: ../contents/ui/configGeneral.qml
msgid "%1 unread email"
msgid_plural "%1 unread emails"
msgstr[0] ""
msgstr[1] ""
```
{{< /section-right >}}
{{< /sections >}}


## fr.po

{{< sections >}}
{{< section-left >}}
Now that we've got a `template.pot`, our translators can copy it and rename it to `fr.po`.

We use `fr` since it is the locale code for French, which we'll be using later.

A full list of locale codes [can be found on StackOverflow](https://stackoverflow.com/questions/3191664/list-of-all-locales-and-their-short-codes#answer-28357857). Make sure you use underscores (`fr_CA`) instead of dashes (`fr-CA`) if the language you are translating is not reusable for the generic `fr` language.

Translators can then start filling out the empty `msgstr ""` with translations.
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">translate/fr.po</div>

```python
#: ../contents/configGeneral.qml
msgid "Show notification"
msgstr "Montrer les notifications"
```
{{< /section-right >}}
{{< /sections >}}


## Merging updates into fr.po

{{< sections >}}
{{< section-left >}}
Our `merge.sh` currently only extracts messages into `template.pot`. We should next merge any new messages extracted for translation into our `fr.po` file.

We'll first filter the translate directory for `.po` files.

Then for each `.po` file, we'll extract the locale code (`fr`) from the filename using the `basename` command then striping out the file extension.

We then use another GetText command `msgmerge` to generate a new `fr.po.new` file based on the old `fr.po` and the current `template.pot`.

Afterwards, we use `sed` to replace the `LANGUAGE` placeholder with our current locale code in case our translator left them as is.

When we're done, we overwrite the old `fr.po` with `fr.po.new`.

{{< /section-left >}}
{{< section-right >}}
<div class="filepath">translate/merge.sh</div>

```bash
#---
echo "[merge] Merging messages"
catalogs=`find . -name '*.po' | sort`
for cat in $catalogs; do
    echo "[merge] $cat"
    catLocale=`basename ${cat%.*}`
    msgmerge \
        --width=400 \
        --add-location=file \
        --no-fuzzy-matching \
        -o "$cat.new" \
        "$cat" "${DIR}/template.pot"
    sed -i 's/# SOME DESCRIPTIVE TITLE./'"# Translation of ${widgetName} in ${catLocale}"'/' "$cat.new"
    sed -i 's/# Translation of '"${widgetName}"' in LANGUAGE/'"# Translation of ${widgetName} in ${catLocale}"'/' "$cat.new"
    sed -i 's/# Copyright (C) YEAR THE PACKAGE'"'"'S COPYRIGHT HOLDER/'"# Copyright (C) $(date +%Y)"'/' "$cat.new"

    mv "$cat.new" "$cat"
done

echo "[merge] Done merging messages"
```
{{< /section-right >}}
{{< /sections >}}


## Building .mo

{{< sections >}}
{{< section-left >}}
Once our `fr.po` has been filled out, we can then convert it to a binary `.mo` file. So lets get started on our `build.sh` script.

{{< alert color="info" >}}
The latest copy of my complete `build.sh` script <a class="alert-link" href="https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/build">can be found here</a>.
{{< /alert >}}

We start with the same code that we used in our `merge.sh` script to parse our `metadata.desktop` file and get the widget's namespace. We also reuse the same code to iterate the `.po` files.

Then we use another GetText command `msgfmt` to convert the `fr.po` file into a `fr.mo` file.

We then make sure a `contents/locale/fr/LC_MESSAGES/` folder exists, creating it if it does not.

Then we copy the `fr.mo` to the `LC_MESSAGES` folder, renaming it to `plasma_applet_com.github.zren.helloworld.mo`. Notice that we put `plasma_applet_` in front of the widget's namespace.
{{< /section-left >}}
{{< section-right >}}
<div class="filepath">translate/build.sh</div>

```bash
#!/bin/sh

DIR=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`
plasmoidName=`kreadconfig5 --file="$DIR/../metadata.desktop" --group="Desktop Entry" --key="X-KDE-PluginInfo-Name"`
website=`kreadconfig5 --file="$DIR/../metadata.desktop" --group="Desktop Entry" --key="X-KDE-PluginInfo-Website"`
bugAddress="$website"
packageRoot=".." # Root of translatable sources
projectName="plasma_applet_${plasmoidName}" # project name

#---
if [ -z "$plasmoidName" ]; then
    echo "[build] Error: Couldn't read plasmoidName."
    exit
fi

#---
echo "[build] Compiling messages"

catalogs=`find . -name '*.po' | sort`
for cat in $catalogs; do
    echo "$cat"
    catLocale=`basename ${cat%.*}`
    msgfmt -o "${catLocale}.mo" "$cat"

    installPath="$DIR/../contents/locale/${catLocale}/LC_MESSAGES/${projectName}.mo"

    echo "[build] Install to ${installPath}"
    mkdir -p "$(dirname "$installPath")"
    mv "${catLocale}.mo" "${installPath}"
done

echo "[build] Done building messages"
```
{{< /section-right >}}
{{< /sections >}}


## Testing our translations

{{< sections >}}
{{< section-left >}}
First make sure you run our `build.sh` translation script.

Next we need to install the language pack we want to test. We'll be testing with `fr_CA` (Canadian French).

* **Kubuntu:** You'll need to [install the `language-pack-fr` package](https://packages.ubuntu.com/focal/language-pack-fr).
* **Manjaro:** You'll need to go to System Settings > Locale > Add > Français > Canada. Click Apply, enter your password, then wait for it to generate the language pack.
* **OpenSUSE:** You'll need to [install a secondary language using YaST](https://doc.opensuse.org/documentation/leap/archive/42.2/startup/html/book.opensuse.startup/cha.y2.lang.html#sec.y2.lang.primsec).

Then we need to override the locale environment variables just for our `plasmoidviewer` instance. If you run the `locale` command, it should list all the environment variables available to override.

In practice, we only need to override `LANG="fr_CA.UTF-8"` and another variable it didn't list `LANGUAGE="fr_CA:fr"`. If your widget is a clock, then you might also need to override `LC_TIME="fr_CA.UTF-8"`.
{{< /section-left >}}
{{< section-right >}}
```bash
sh package/translate/build.sh
LANGUAGE="fr_CA:fr" LANG="fr_CA.UTF-8" plasmoidviewer -a package
```

```bash
$ locale
LANG=en_CA.UTF-8
LC_CTYPE="en_CA.UTF-8"
LC_NUMERIC=en_CA.UTF-8
LC_TIME=en_US.UTF-8
LC_COLLATE="en_CA.UTF-8"
LC_MONETARY=en_CA.UTF-8
LC_MESSAGES="en_CA.UTF-8"
LC_PAPER=en_CA.UTF-8
LC_NAME=en_CA.UTF-8
LC_ADDRESS=en_CA.UTF-8
LC_TELEPHONE=en_CA.UTF-8
LC_MEASUREMENT=en_CA.UTF-8
LC_IDENTIFICATION=en_CA.UTF-8
LC_ALL=
```
{{< /section-right >}}
{{< /sections >}}


## Reusing other translations

{{< sections >}}
{{< section-left >}}
While it is bad practice to link to private code, if you know another widget has translated a string, you can use `i18nd(domain, string, ...)` to use translations from that domain. Note that a widget's domain starts with `plasma_applet_`, and ends with the widget's `X-KDE-PluginInfo-Name`.

Eg: `plasma_applet_com.github.zren.helloworld`

An example can be found in `org.kde.image`'s [main.qml](https://invent.kde.org/plasma/plasma-workspace/-/blob/master/wallpapers/image/imagepackage/contents/ui/main.qml) which reuses the same code for the `org.kde.slideshow`.

{{< /section-left >}}
{{< section-right >}}
```qml
CheckBox {
    text: i18nd("plasma_applet_org.kde.plasma.digitalclock", "Show date")
}
CheckBox {
    text: i18nd("plasma_applet_org.kde.plasma.digitalclock", "Show seconds")
}
Button {
    text: i18nd("plasma_wallpaper_org.kde.image", "Open Wallpaper Image")
}
```
{{< /section-right >}}
{{< /sections >}}




{{< readfile file="/content/docs/plasma/widget/snippet/plasma-doc-style.html" >}}
