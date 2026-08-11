---
title: "Plasmoids and third party software"
weight: 4
description: >
  Internationalization without KDE infrastructure
---

Developers working on third party software or plasmoids may not use KDE infrastructure, and therefore do not benefit from the automation described in [Scripty and string extraction](#) that every official KDE project has access to.

The first step to making either translatable consists of following our [KI18n](#) guide, just like official KDE software. From then on, the required steps to generate translations and ship them differ:

* [Using Zren's scripts](#)
* [Using Scripty manually](#)
* [Using gettext tools manually](#)

And may depend on the type of project:

* [QML and C++ third party applications](#)
* [QML and C++ Plasmoids](#)
* [QML-only Plasmoids](#)

This page assumes that you have already followed our [KI18n tutorial](#) and have marked your project's code strings for translation.

Let's first discuss the different methods available, then proceed to explain what can be done for each type of project.

## Ways to generate translations

All three ways to generate translation files rely internally on the gettext tools `xgettext`, `msgfmt` and `msgmerge`, hence one may be used in place of another depending on how much control the developer wants to have over translation file generation.

Typically, plasmoids use [Zren's scripts](#) while third party applications write their own scripts by [Using gettext tools manually](#), because it is generally more advantageous to have scripts local to the project's repository.

### Using Zren's scripts

Since Scripty mostly uses `xgettext` and `msgmerge` under the hood, projects not using Scripty can simply write a script to handle these processes themselves.

A community member Zren wrote a ready-made script that can be used for plasmoids specifically: 

* https://github.com/Zren/plasma-applet-lib/tree/master/package/translate

It consists of three scripts:

* [merge](https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/merge) to generate and update the POT file
* [build](https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/build) to turn the translated PO files into MO files
* [plasmoidlocaletest](https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/plasmoidlocaletest) to test the plasmoid in the language that is currently set with `$LANG`/`$LANGUAGE`

To get a better understanding of how these sorts of scripts operate, see [Using gettext tools manually](#).

When distributing plasmoids that have only QML files, the MO files can simply be delivered together with the plasmoid, either by pushing to the repository itself or by generating the MO files in your continuous integration system and generating a `.plasmoid` file with them. See the [Plasma Widgets Tutorial]({{< ref "widget" >}}) for how to generate a `.plasmoid` package.

### Using Scripty manually

It is possible to use [Scripty and string extraction](#) even for third party applications or plasmoids. This is usually not done because it requires cloning the [Scripty repository](#) first, which might not fit into your project's continuous integration (CI) system.

The steps required are:

1. Create a `Messages.sh` file, as detailed in [Scripty and string extraction](#)
2. Clone Scripty and run `extract-messages.sh`, as detailed in [Testing translations locally: Making a new POT file](#)
3. If there is an existing translated PO file, run `merge.sh` to update it, as detailed in [Testing translations locally: Testing changes to an existing translation](#)

This process does not cover turning PO files into binary MO files, as under KDE infrastructure the actual generation would be in charge of the Scripty *bot* entirely. See the next section for how to use `msgfmt` for this purpose.

### Using gettext tools manually

Let's take a look at a sample script provided in [i18n Build Systems: Outside KDE repositories](https://techbase.kde.org/Development/Tutorials/Localization/i18n_Build_Systems/Outside_KDE_repositories) originally intended for any third party software:

<details>
<summary>Click here to view the sample</summary>

```bash
#!/bin/sh
BASEDIR="../rkward/"	# root of translatable sources
PROJECT="rkward"	# project name
BUGADDR="http://sourceforge.net/tracker/?group_id=50231&atid=459007"	# MSGID-Bugs
WDIR=`pwd`		# working dir


echo "Preparing rc files"
cd ${BASEDIR}
# we use simple sorting to make sure the lines do not jump around too much from system to system
find . -name '*.rc' -o -name '*.ui' -o -name '*.kcfg' | sort > ${WDIR}/rcfiles.list
xargs --arg-file=${WDIR}/rcfiles.list extractrc > ${WDIR}/rc.cpp
# additional string for KAboutData
echo 'i18nc("NAME OF TRANSLATORS","Your names");' >> ${WDIR}/rc.cpp
echo 'i18nc("EMAIL OF TRANSLATORS","Your emails");' >> ${WDIR}/rc.cpp
cd ${WDIR}
echo "Done preparing rc files"


echo "Extracting messages"
cd ${BASEDIR}
# see above on sorting
find . -name '*.cpp' -o -name '*.h' -o -name '*.c' | sort > ${WDIR}/infiles.list
echo "rc.cpp" >> ${WDIR}/infiles.list
cd ${WDIR}
xgettext --from-code=UTF-8 -C -kde -ci18n -ki18n:1 -ki18nc:1c,2 -ki18np:1,2 -ki18ncp:1c,2,3 -ktr2i18n:1 \
	-kI18N_NOOP:1 -kI18N_NOOP2:1c,2 -kaliasLocale -kki18n:1 -kki18nc:1c,2 -kki18np:1,2 -kki18ncp:1c,2,3 \
	--msgid-bugs-address="${BUGADDR}" \
	--files-from=infiles.list -D ${BASEDIR} -D ${WDIR} -o ${PROJECT}.pot || { echo "error while calling xgettext. aborting."; exit 1; }
echo "Done extracting messages"


echo "Merging translations"
catalogs=`find . -name '*.po'`
for cat in $catalogs; do
  echo $cat
  msgmerge -o $cat.new $cat ${PROJECT}.pot
  mv $cat.new $cat
done
echo "Done merging translations"


echo "Cleaning up"
cd ${WDIR}
rm rcfiles.list
rm infiles.list
rm rc.cpp
echo "Done"
```

</details>
<br>

There are four general steps:

1. Preparing rc files
2. Extracting messages
3. Merging translations
4. Cleaning up

The first step, "Preparing rc files", creates additional C++ files with a couple of strings to be added to the generated translation files, "NAME OF TRANSLATORS" and "EMAIL OF TRANSLATORS", purely there for translators to be able to include their credit information. This is a convention in KDE software to ensure a standard way of defining credits, but this can be entirely replaced by using [KMainWindow](#) (if your project uses QtWidgets) or using [KAboutData::setTranslator(i18nc("NAME OF TRANSLATORS", "Your names"), i18nc("EMAIL OF TRANSLATORS", "Your emails"))](#) in C++ code instead.

The second step, "Extracting messages", uses a `find` call to compile a list of files to have their strings extracted, and another for running `xgettext` followed by many flags, outputing (`-o`) a POT file at the end (`${PROJECT}.pot`).

In other words, this step is done with:

```bash
xgettext <list of sources to extract strings from> <lots of flags> --output <projectid>.pot
```

Or:

```bash
find <lots of flags> > list-of-sources.txt
xgettext <lots of flags> --files-from=list-of-sources.txt --output <projectid>.pot
```

Under KDE infrastructure, this `find` call would be found in a [Messages.sh file](#), and the flags would be in Scripty's [extract-messages.sh](#) file. Outside KDE infrastructure, these need to be defined manually.

The third step, "Merging translations", checks if there are any translated PO files (in other words, *catalogs*) that need to be updated with new code strings, and runs `msgmerge` on them using the POT file that gets generated after string extraction.

In other words, this step is done with:

```bash
msgmerge <po-to-be-updated>.po <projectid>.pot
```

The fourth step simply removes the additional files created during the first step.

The above sample does not cover the last, fifth step needed to ship the translation to users, which is done using `msgfmt`. This tool turns a plain text PO file into a binary MO file, and is used as such:

```bash
msgfmt po/<projectid>.po --output-file anydirectory/<projectid>.mo
```

This fifth step creates one of the main differences between third party applications and plasmoids.

## Types of software

### QML and C++ third party applications

Whether the application in question is using only C++ or using C++ and QML, the process is straightforward and similar to that explained in our [KI18n](#) tutorial:

1. Set up KI18n (including its translation domain)
2. Mark strings as translatable with `i18n()` functions
3. Use `ki18n_install()` in CMake
4. Extract and merge translations using any of the [methods](#) mentioned in this page, **but not running `msgfmt` manually**

The [ki18n_install()](https://invent.kde.org/frameworks/ki18n/-/blob/master/cmake/KF6I18nMacros.cmake.in#L80) call automatically turns any PO files in its specified directory (usually `po/`) into MO files and installs them for you.

### QML and C++ Plasmoids

Plasmoids that use both QML and C++ are expected to be installed with CMake. The only difference between this method and third party applications comes in the form of [plasma_add_applet](#):

1. Set up KI18n (including its translation domain)
2. Mark strings as translatable with `i18n()` functions
3. Use `plasma_add_applet()` and `ki18n_install()` in CMake
4. Extract and merge translations using any of the [methods](#) mentioned in this page, **but not running `msgfmt` manually**

Using this method, the Plasmoid is compiled into a C++ library with `plasma_add_applet` and installed to `/usr/lib64/plugins/plasma/applets/`. Its corresponding translations are turned into MO files and installed to `/usr/share/locale/LC_MESSAGES/<lang-code>/`.

<!--
TODO needs to explain KPLUGIN_WITH_JSON and how metadata.json needs to not have Id or KPackageStructure
TODO mention that po/<projectid>.pot should not exist
-->

### QML-only Plasmoids

QML-only plasmoids have a couple of constraints:

* They cannot use `ki18n_install()` to turn PO files into MO files because they include no CMake files
* They cannot set their own translation domains via C++ because they include no C++ files; as mentioned in our [KI18n tutorial](#), translation domains end up as the names of the generated POT files

To address the lack of `ki18n_install()`, Plasma deliberately looks into `/usr/share/plasma/plasmoids` and `~/.local/share/plasma/plasmoids/` for any QML-only plasmoids and loads them at runtime, **including its binary MO files containing translations**, which **need** to be in the Plasmoid's directory under `contents/locale/<lang-code>/LC_MESSAGES/<translation-domain>.mo`.

For example, if a Plasmoid `org.kde.plasma.tutorial` ends up installed from the KDE Store via Discover, the respective binary MO would be sent to: `~/.local/share/plasma/plasmoids/org.kde.plasma.tutorial/contents/locale/<lang-code>/LC_MESSAGES/<translation-domain>.mo`

The location of the original POT and PO files do not matter, as long as the MO files are in the correct place. Third party plasmoids have conventionally stored their POT and PO files in a `translations/` folder.

This can be done manually with the following, as mentioned in [Using gettext tools manually](#):

```bash
msgfmt po/<lang-code>/<projectid>.po --output-file contents/locale/<lang-code>/LC_MESSAGES/<translation-domain>.mo
```

This means plasmoids should ship with MO files *in some way* so that they can be installed directly to the specified directory above. The easiest way to do so is to add them to the project's repository, but the best way to do so is by [creating a .plasmoid file](#) that includes the generated binary MO files.

Either way, in addition to extracting strings and merging them, it is necessary to generate the MO files yourself using either [Zren's scripts](#) or [a manual script of your own](#).

To address the inability to set a translation domain from C++, you may:

* Use `i18n()` functions + Plasma's default generated translation domain `plasma_applet_<projectid>` for plasmoids
* Use `KI18n.i18n()` functions + a custom defined [KI18nContext.translationDomain](https://api.kde.org/qml-org-kde-ki18n-ki18ncontext.html)

For example, if a project has a project id of `org.kde.plasma.tutorial`, then in QML code you may use:

```qml
import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents

PlasmoidItem {
    id: root
    Plasmoid.title: i18n("My first plasmoid")
    PlasmaComponents.Label {
        anchors.centerIn: parent
        text: i18n("Hello World!")
    }
}
```

And, after extracting the POT file and getting it translated to a PO file in Brazilian Portuguese, generate the MO files and send them to the appropriate location (**with** the `plasma_applet_` prefix):

```bash
msgfmt po/pt_BR/org.kde.plasma.tutorial.po --output-file contents/locale/pt_BR/LC_MESSAGES/plasma_applet_org.kde.plasma.tutorial.mo
```

Remember to change the `po/pt_BR/` directory to whatever directory you use for PO files and to the correct language code directory that you want to generate.

This method is well established and common among existing plasmoids. A script is usually made for this task to iterate through every language code directory, among other things.

Whereas the new method is done in this way:

```qml
import QtQuick
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents
import org.kde.ki18n

PlasmoidItem {
    id: root
    readonly property KI18nContext someContext: KI18nContext {
        translationDomain: "org.kde.plasma.tutorial"
    }
    Plasmoid.title: someContext.i18n("My first plasmoid")
    PlasmaComponents.Label {
        anchors.centerIn: parent
        text: someContext.i18n("Hello World!")
    }
}
```

You may replace `someContext` with a shorter name.

And, after extracting the POT file and getting it translated to a PO file in Brazilian Portuguese, generate the MO files and send them to the appropriate location (**without** the `plasma_applet_` prefix):

```bash
msgfmt po/pt_BR/org.kde.plasma.tutorial.po --output-file contents/locale/pt_BR/LC_MESSAGES/org.kde.plasma.tutorial.mo
```

