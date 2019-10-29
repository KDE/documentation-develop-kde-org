"""Helpers and values for Sphinx configuration settings that are shared by two
or more Sphinx projects within this repository."""


from datetime import datetime
from os import makedirs, path
from string import digits

import requests
from sphinx.util.console import bold


_FRAMEWORKS = {
    'Kirigami2': {},
    'KNotifications': {},
    'KWidgetsAddons': {},
    'Plasma': {'url_slug': 'plasma-framework'},
}

html_theme_options = {
    'navigation_with_keys': True,
}


def _download_doxylink(base_url, filename):
    tag_dir = path.abspath('../../build/tags')
    file_path = path.join(tag_dir, filename)
    url = base_url + filename

    if path.exists(file_path):
        local_modified = datetime.fromtimestamp(path.getmtime(file_path))
        response = requests.head(url)
        date_string = response.headers['Last-Modified']
        remote_modified = datetime.strptime(date_string, '%a, %d %b %Y %X %Z')
        if local_modified > remote_modified:
            print(bold("{} is up to date".format(url, file_path)))
            return file_path

    makedirs(tag_dir, exist_ok=True)
    print(bold("Downloading file {} to {}".format(url, file_path)))
    response = requests.get(url)
    if response.status_code != 200:
        raise Exception('{} HTTP response received from {}'
                        .format(response.status_code, url))
    with open(file_path, "w") as tagFile:
        tagFile.write(response.text)
    return file_path


def get_doxylink():
    doxylinks = {}
    url_template = 'https://api.kde.org/frameworks/{}/html/'
    for framework, config in _FRAMEWORKS.items():
        slug = framework.rstrip(digits).lower()
        url_slug = config.get('url_slug', slug)
        base_url = url_template.format(url_slug)
        tag_filename = framework + '.tags'
        tag_file_path = _download_doxylink(base_url, tag_filename)
        directive = slug + 'api'
        doxylinks[directive] = (tag_file_path, base_url)
    return doxylinks
