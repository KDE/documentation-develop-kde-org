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
        'tags': 'https://doc.qt.io/qt-6/qtquick.tags',
        'base_url': 'https://doc.qt.io/qt-6/',
    },
    {
        'tags': 'https://doc.qt.io/qt-6/qtquickcontrols.tags',
        'base_url': 'https://doc.qt.io/qt-6/',
        'default_prefix': 'QtQuick.Controls',
    },
    {
        'tags': 'https://doc.qt.io/qt-6/qtwidgets.tags',
        'base_url': 'https://doc.qt.io/qt-6/',
    },
    {
        'tags': 'https://doc.qt.io/qt-6/qtgui.tags',
        'base_url': 'https://doc.qt.io/qt-6/',
    },
    {
        'tags': 'https://doc.qt.io/qt-6/qtcore.tags',
        'base_url': 'https://doc.qt.io/qt-6/',
    },
    {
        'tags': 'https://doc.qt.io/qt-6/qtqml.tags',
        'base_url': 'https://doc.qt.io/qt-6/',
    },
    {
        'tags': 'https://doc.qt.io/qt-6/qtdbus.tags',
        'base_url': 'https://doc.qt.io/qt-6/',
    },
    # ===== Frameworks API links =====
    {
        'tags': 'https://api-staging.kde.org/ki18n.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/kcoreaddons.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/kiocore.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/kxmlgui.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/kconfigwidgets.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/kwidgetsaddons.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/ktextwidgets.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/ktexteditor.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/kconfigcore.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/krunner.tags',
        'base_url': 'https://api-staging.kde.org/',
        'default_prefix': 'KRunner::',
    },
    {
        'tags': 'https://api-staging.kde.org/plasma.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/kcmutils.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/kcmutilsqml.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/kcmutilsquick.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/kirigami.tags',
        'base_url': 'https://api-staging.kde.org/',
    },
    {
        'tags': 'https://api-staging.kde.org/kitemmodels.tags',
        'base_url': 'https://api-staging.kde.org/',
    },
    # ===== Plasma API links
    {
        'tags': 'https://api-staging.kde.org/kdecoration.tags',
        'base_url': 'https://api-staging.kde.org/'
    },
    {
        'tags': 'https://api-staging.kde.org/plasma/libksysguard.tags',
        'base_url': 'https://api-staging.kde.org/',
        'default_prefix': 'KSysGuard',
    },
    {
        'tags': 'https://api-staging.kde.org/kpackage.tags',
        'base_url': 'https://api-staging.kde.org/',
        'default_prefix': 'KPackage',
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
    jsonFile = f'assets/_data/{component_name}.json'

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


with open('assets/_data/components_map.json', 'w') as destination:
    dump(components_map, destination)


