#!/bin/env python3

import os
import sys
import xml.dom.minidom
from xml.dom.minidom import parse
import configparser
import requests
import tarfile
import urllib.request as request

from yaml import safe_load, dump
try:
    from yaml import CLoader as Loader, CDumper as Dumper
except ImportError:
    from yaml import Loader, Dumper

########
# This application loops through installed applets and extracts the config XML file
# app should be kept flexible enough to port to a different format in future

DEBUG=False

def extractProjectDir(projectDir):
    r = request.urlopen(projectDir)
    tarfiles = tarfile.open(fileobj=r, mode="r|gz")
    a = tarfiles.extractall("./tmp/")
    tarfiles.close()


def nameForId(path, plasmoid):
    configPath = ""
    if os.path.exists(path + '/metadata.desktop'):
        configPath = path + '/metadata.desktop'
    elif os.path.exists(path + '/package/metadata.desktop'):
        configPath = path + '/package/metadata.desktop'
    else:
        return "BUG"

    config = configparser.ConfigParser()
    config.read(configPath)

    return config['Desktop Entry']['X-KDE-PluginInfo-Name']


def parseConfig(path, plasmoid, keys):
    if plasmoid == "CMakeLists.txt" or plasmoid == "Mainpage.dox":
        return
    configPath = ""
    if os.path.exists(path + "/contents/config/main.xml"):
        configPath = "/contents/config/main.xml"
    elif os.path.exists(path + "/package/contents/config/main.xml"):
        configPath = "/package/contents/config/main.xml"
    try:
        dom = xml.dom.minidom.parse(path + configPath).documentElement

        if "private" in nameForId(path, plasmoid):
            return

        applet_config = {}
        applet_config['id'] = str(nameForId(path, plasmoid))
        applet_config['groups'] = []
        for group in dom.getElementsByTagName("group"):
            group_config = {}
            group_config['name'] = group.getAttribute("name")
            group_config['entries'] = []

            for entry in group.getElementsByTagName("entry"):
                name = entry.getAttribute("name")
                type = entry.getAttribute("type")
                default = ""
                description = ""

                if entry.hasAttribute("hidden") and entry.getAttribute("hidden") == "true":
                    continue

                defaultTags = entry.getElementsByTagName("default")
                if (defaultTags.length > 0 and defaultTags[0].childNodes.length > 0):
                    default = defaultTags[0].childNodes[0].data

                if (default == ""):
                    if (type == "Bool"):
                        default = "false"
                    elif (type == "Int"):
                        default = "0"
                    elif (type == "StringList"):
                        default = "empty list"
                    elif (type == "String"):
                        default = "empty string"
                    else:
                        default = "null"

                labelTags = entry.getElementsByTagName("label")
                if (labelTags.length > 0 and labelTags[0].childNodes.length > 0):
                    description = labelTags[0].childNodes[0].data

                entry = {
                    'name': name,
                    'type': type,
                    'default': default,
                    'description': description
                }
                group_config['entries'].append(entry)
            applet_config['groups'].append(group_config)
        keys.append(applet_config)

    except IOError:
        if DEBUG:
            sys.stderr.write("No config in " + plasmoid +"\n")
    #abort on other errors so we can find them

def download_file(repo: str, path: str):
    content = requests.get('https://invent.kde.org/{}/-/raw/master/{}'.format(repo, path)).text
    os.makedirs(os.path.dirname('files/{}/{}'.format(repo, path)), exist_ok=True)
    with open('files/{}/{}'.format(repo, path), 'w+') as f:
        f.write(content)

if __name__ == "__main__":
    extractProjectDir('https://invent.kde.org/plasma/plasma-desktop/-/archive/master/plasma-desktop-master.tar.gz?path=applets')
    extractProjectDir('https://invent.kde.org/plasma/plasma-workspace/-/archive/master/plasma-workspace-master.tar.gz?path=applets')
    extractProjectDir('https://invent.kde.org/plasma/kdeplasma-addons/-/archive/master/kdeplasma-addons-master.tar.gz?path=applets')

    download_file('frameworks/karchive', 'examples/helloworld/main.cpp')
    download_file('frameworks/karchive', 'examples/bzip2gzip/main.cpp')

    download_file('frameworks/kidletime', 'examples/KIdleTest.cpp')

    projects = os.listdir("./tmp/")
    keys = []
    for project in projects:
        plasmoids = os.listdir("./tmp/{}/applets".format(project))
        plasmoids.sort()
        for plasmoid in plasmoids:
            path = "./tmp/{}/applets/{}".format(project, plasmoid)
            parseConfig(path, plasmoid, keys)
    with open('_data/keys.yaml', 'w+') as keys_file:
        keys_file.write(dump(keys, default_flow_style=False, allow_unicode=True))

