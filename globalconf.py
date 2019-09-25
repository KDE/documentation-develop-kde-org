"""Helpers and values for Sphinx configuration settings that are shared by two
or more Sphinx projects within this repository."""

import requests
from sphinx.util.console import bold
from string import digits

_FRAMEWORKS = {
    'Kirigami2': {},
    'KNotifications': {},
    'KWidgetsAddons': {},
    'Plasma': {'url_slug': 'plasma-framework'},
}

html_theme_options = {
    'navigation_with_keys': True,
}


_DOXYLINK = {
    'kirigamiapi' : ('Kirigami2.tags', 'https://api.kde.org/frameworks/kirigami/html/'), # https://api.kde.org/frameworks/kirigami/html/Kirigami2.tags
    'kwidgetsaddonsapi' : ('KWidgetsAddons.tags', 'https://api.kde.org/frameworks/kwidgetsaddons/html/'), # https://api.kde.org/frameworks/kwidgetsaddons/html/KWidgetsAddons.tags
    'plasmaapi' : ('Plasma.tags', 'https://api.kde.org/frameworks/plasma-framework/html/') # https://api.kde.org/frameworks/plasma-framework/html/Plasma.tags
}


def _download_doxylink(base_url, filename):
    url = base_url + filename
    print(bold("Downloading file {} to {}".format(url, filename)))
    response = requests.get(url)
    if response.status_code != 200:
        raise Exception('{} HTTP response received from {}'
                        .format(response.status_code, url))
    with open('../' + filename, "w") as tagFile:
        tagFile.write(response.text)


def get_doxylink():
    doxylinks = {}
    url_template = 'https://api.kde.org/frameworks/{}/html/'
    for framework, config in _FRAMEWORKS.items():
        slug = framework.rstrip(digits).lower()
        url_slug = config.get('url_slug', slug)
        base_url = url_template.format(url_slug)
        tag_file = framework + '.tags'
        _download_doxylink(base_url, tag_file)
        directive = slug + 'api'
        doxylinks[directive] = (tag_file, base_url)
    return doxylinks
