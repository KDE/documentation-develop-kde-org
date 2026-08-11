---
title: "Plasmoids and third party software"
weight: 4
description: >
  Internationalization without KDE infrastructure
---

Developers working on Plasmoids or third party software but not using KDE infrastructure cannot use Scripty, and therefore do not benefit from the automation described in [Scripty and string extraction](#).

Since Scripty mostly uses `xgettext` and `msgmerge` under the hood, projects not using Scripty can simply write a script to handle these processes themselves. One such example would look like so:

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

More information can be found on [i18n Build Systems: Outside KDE repositories](https://techbase.kde.org/Development/Tutorials/Localization/i18n_Build_Systems/Outside_KDE_repositories) (outdated, help needed :D).

A community member Zren wrote a ready-made version that can be used for Plasmoids specifically: 

* https://github.com/Zren/plasma-applet-lib/tree/master/package/translate

It consists of three scripts:
* [merge](https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/merge) to generate and update the POT file
* [build](https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/build) to turn the translated PO files into MO files
* [plasmoidlocaletest](https://github.com/Zren/plasma-applet-lib/blob/master/package/translate/plasmoidlocaletest) to test the plasmoid in the language that is currently set with `$LANG`/`$LANGUAGE`

When distributing plasmoids that have only QML files, the MO files can simply be delivered together with the plasmoid, either by pushing to the repository itself or by generating the MO files in your continuous integration system and generating a `.plasmoid` file with them. See the [Plasma Widgets Tutorial]({{< ref "widget" >}}) for how to generate a `.plasmoid` package.
