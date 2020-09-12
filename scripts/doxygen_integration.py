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

for tag_file in [
        'https://api.kde.org/frameworks/kdeclarative/html/KDeclarative.tags',
        'https://api.kde.org/frameworks/ki18n/html/KI18n.tags',
        'https://api.kde.org/frameworks/kcoreaddons/html/KCoreAddons.tags',
        'https://api.kde.org/frameworks/kio/html/KIO.tags',
        'https://api.kde.org/frameworks/kxmlgui/html/KXmlGui.tags',
        'https://api.kde.org/frameworks/kconfigwidgets/html/KConfigWidgets.tags',
        'https://api.kde.org/frameworks/kwidgetsaddons/html/KWidgetsAddons.tags',
        ]:
    r = requests.get(tag_file)
    Path("_data").mkdir(parents=True, exist_ok=True)
    with open('_data/' + os.path.basename(os.path.splitext(tag_file)[0]).lower() + '.json', 'w') as f:
        dump(bf.data(fromstring(r.content)), f)


