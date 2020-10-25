#!/usr/bin/env python
#
# SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
#
# SPDX-License-Identifier: GPL-3.0-or-later

from xmljson import badgerfish as bf
from pathlib import Path
from json import dump
from xml.etree.ElementTree import fromstring
import os
import requests

TAG_FILES = [
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
        'tags': 'https://api.kde.org/frameworks/ktexteditor/html/KTextEditor.tags',
        'base_url': 'https://api.kde.org/frameworks/ktexteditor/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/kconfig/html/KConfig.tags',
        'base_url': 'https://api.kde.org/frameworks/kconfig/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/plasma-framework/html/Plasma.tags',
        'base_url': 'https://api.kde.org/frameworks/plasma-framework/html/'
    },
    {
        'tags': 'https://api.kde.org/kdecoration/html/KDecoration2.tags',
        'base_url': 'https://api.kde.org/kdecoration/html/'
    },
    {
        'tags': 'https://api.kde.org/frameworks/kirigami/html/Kirigami2.tags',
        'base_url': 'https://api.kde.org/frameworks/kirigami/html/',
        'default_prefix': 'org::kde::kirigami::',
    },
    {
        'tags': 'https://invent.kde.org/websites/quality-kde-org/-/raw/master/apidox/data/5.15/qtquickcontrols.tags',
        'base_url': 'https://doc.qt.io/qt-5/'
    }
]

components_map = {}

for tag_file in TAG_FILES:
    r = requests.get(tag_file['tags'])
    Path("_data").mkdir(parents=True, exist_ok=True)
    component_name = os.path.basename(os.path.splitext(tag_file['tags'])[0]).lower()
    with open('_data/' + component_name + '.json', 'w') as f:
        dump(bf.data(fromstring(r.content)), f)

    components_map[component_name] = {'url': tag_file['base_url']}
    if 'default_prefix' in tag_file:
        components_map[component_name]['default_prefix'] = tag_file['default_prefix']


with open('_data/components_map.json', 'w') as f:
    dump(components_map, f)


