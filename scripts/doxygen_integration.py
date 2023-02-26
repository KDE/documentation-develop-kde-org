#!/usr/bin/env python
#
# SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

from xmljson import badgerfish as bf
from pathlib import Path
from json import dump
from xml.etree.ElementTree import fromstring, ParseError
import os
from shutil import copyfile
import requests
import logging
import sys

TAG_FILES = [
    # ===== Qt API links ======
    {
        'tags': 'https://invent.kde.org/websites/quality-kde-org/-/raw/master/apidox/data/5.15/qtquick.tags',
        'base_url': 'https://doc.qt.io/qt-5/',
    },
    {
        'tags': 'https://invent.kde.org/websites/quality-kde-org/-/raw/master/apidox/data/5.15/qtquickcontrols.tags',
        'base_url': 'https://doc.qt.io/qt-5/',
        'default_prefix': 'QtQuick.Controls',
    },
    {
        'tags': 'https://invent.kde.org/websites/quality-kde-org/-/raw/master/apidox/data/5.15/qtwidgets.tags',
        'base_url': 'https://doc.qt.io/qt-5/',
    },
    {
        'tags': 'https://invent.kde.org/websites/quality-kde-org/-/raw/master/apidox/data/5.15/qtgui.tags',
        'base_url': 'https://doc.qt.io/qt-5/',
    },
    {
        'tags': 'https://invent.kde.org/websites/quality-kde-org/-/raw/master/apidox/data/5.15/qtcore.tags',
        'base_url': 'https://doc.qt.io/qt-5/',
    },
    {
        'tags': 'https://invent.kde.org/websites/quality-kde-org/-/raw/master/apidox/data/5.15/qtqml.tags',
        'base_url': 'https://doc.qt.io/qt-5/',
    },
    {
        'tags': 'https://invent.kde.org/websites/quality-kde-org/-/raw/master/apidox/data/5.15/qtdbus.tags',
        'base_url': 'https://doc.qt.io/qt-5/',
    },
    # ===== Frameworks API links =====
    {
        'tags': 'https://api.kde.org/frameworks/kdeclarative/html/KDeclarative.tags',
        'base_url': 'https://api.kde.org/frameworks/kdeclarative/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/ki18n/html/KI18n.tags',
        'base_url': 'https://api.kde.org/frameworks/ki18n/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/kcoreaddons/html/KCoreAddons.tags',
        'base_url': 'https://api.kde.org/frameworks/kcoreaddons/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/kio/html/KIO.tags',
        'base_url': 'https://api.kde.org/frameworks/kio/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/kxmlgui/html/KXmlGui.tags',
        'base_url': 'https://api.kde.org/frameworks/kxmlgui/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/kconfigwidgets/html/KConfigWidgets.tags',
        'base_url': 'https://api.kde.org/frameworks/kconfigwidgets/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/kwidgetsaddons/html/KWidgetsAddons.tags',
        'base_url': 'https://api.kde.org/frameworks/kwidgetsaddons/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/ktextwidgets/html/KTextWidgets.tags',
        'base_url': 'https://api.kde.org/frameworks/ktextwidgets/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/ktexteditor/html/KTextEditor.tags',
        'base_url': 'https://api.kde.org/frameworks/ktexteditor/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/kconfig/html/KConfig.tags',
        'base_url': 'https://api.kde.org/frameworks/kconfig/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/krunner/html/KRunner.tags',
        'base_url': 'https://api.kde.org/frameworks/krunner/html/',
        'default_prefix': 'Plasma::'
    },
    {
        'tags': 'https://api.kde.org/frameworks/plasma-framework/html/Plasma.tags',
        'base_url': 'https://api.kde.org/frameworks/plasma-framework/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/kcmutils/html/KCMUtils.tags',
        'base_url': 'https://api.kde.org/frameworks/kcmutils/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/kirigami/html/Kirigami2.tags',
        'base_url': 'https://api.kde.org/frameworks/kirigami/html/',
        'default_prefix': 'org::kde::kirigami::',
    },
    {
        'tags': 'https://api.kde.org/frameworks/kitemmodels/html/KItemModels.tags',
        'base_url': 'https://api.kde.org/frameworks/kitemmodels/html/',
    },
    # ===== Plasma API links
    {
        'tags': 'https://api.kde.org/plasma/kdecoration/html/KDecoration2.tags',
        'base_url': 'https://api.kde.org/plasma/kdecoration/html/'
    },
    {
        'tags': 'https://api.kde.org/plasma/plasma-workspace/html/Plasma-workspace.tags',
        'base_url': 'https://api.kde.org/plasma/plasma-workspace/html/'
    },
    {
        'tags': 'https://api.kde.org/plasma/libksysguard/html/Libksysguard.tags',
        'base_url': 'https://api.kde.org/plasma/libksysguard/html/',
        'default_prefix': 'KSysGuard',
    },
    {
        'tags': 'https://api.kde.org/frameworks/kpackage/html/KPackage.tags',
        'base_url': 'https://api.kde.org/frameworks/kpackage/html/',
        'default_prefix': 'KPackage',
    },
    # ===== KDEPim API links
    {
        'tags': 'https://api.kde.org/kdepim/akonadi/html/Akonadi.tags',
        'base_url': 'https://api.kde.org/kdepim/akonadi/html/',
        'default_prefix': 'Akonadi::',
    },
    {
        'tags': 'https://api.kde.org/kdepim/kmime/html/KMime.tags',
        'base_url': 'https://api.kde.org/kdepim/kmime/html/',
        'default_prefix': 'KMime::',
    },
    {
        'tags': 'https://api.kde.org/kdepim/mailcommon/html/Mailcommon.tags',
        'base_url': 'https://api.kde.org/kdepim/mailcommon/html/',
        'default_prefix': 'MailCommon::',
    }
]

components_map = {}

# initialize logging
if os.environ.get("DEBUG"):
    level=logging.DEBUG
else:
    level=logging.INFO
logging.basicConfig(stream=sys.stdout, level=level,
                    format = '%(asctime)s:%(levelname)s:%(message)s')


for tag_file in TAG_FILES:
    tagsURL = tag_file['tags']
    logging.debug("Checking: " + tagsURL)
    component_name = os.path.basename(os.path.splitext(tagsURL)[0]).lower()
    jsonFile = f'_data/{component_name}.json'

    content = None
    if 'path' in tag_file:
        with open(tag_file['path']) as inputStream:
            content = inputStream.read()
    else:
        req = requests.get(tagsURL)
        if req.status_code != 200:
            logging.warning(f"no content found for {component_name} (http code: {req.status_code})")
            # don't break and move to next
            continue
        content = req.text

    if content is None:
        logging.warning(f"no data for {component_name}")
        # don't break and move to next
        continue

    Path("_data").mkdir(parents=True, exist_ok=True)
    with open(jsonFile, 'w') as outputStream:
        try:
            dump(bf.data(fromstring(content)), outputStream, indent=2)
        except ParseError:
            logging.error(f"Failed to parse xml content for {component_name}")
            # don't break and move to next
            continue

    components_map[component_name] = {'url': tag_file['base_url']}
    if 'default_prefix' in tag_file:
        components_map[component_name]['default_prefix'] = tag_file['default_prefix']


with open('_data/components_map.json', 'w') as destination:
    dump(components_map, destination)


