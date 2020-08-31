# KDE Developer website

## Running the website locally

Download the latest Hugo release (extended version) from [here](https://github.com/gohugoio/hugo/releases)
 and clone this repo.

Once you've cloned the site repo, from the repo root folder, run:

```
hugo server
```

## Extract icon metadata

Data for the icon galleries (i.e. `/frameworks/breeze-icons/`) must be downloaded and extracted via `scripts/icon_extractor.py`.
The script is configured with the correct paths for this repository and therefore may be executed without additional arguments.

```
usage: icon_extractor.py [-h] [-j OUTPUT_METADATA_DIR] [-d OUTPUT_ICONS_DIR] [-w WORK_DIR] [-p] [-v]

optional arguments:
  -h, --help            show this help message and exit
  -j OUTPUT_METADATA_DIR, --output-metadata-dir OUTPUT_METADATA_DIR
                        Path to directory where to write json metadata (default: data/icons)
  -d OUTPUT_ICONS_DIR, --output-icons-dir OUTPUT_ICONS_DIR
                        Path to directory where to copy icons (default: assets/icons)
  -w WORK_DIR, --work-dir WORK_DIR
                        Path to directory used as script workdir (default: ./workdir)
  -p, --pretty          Pretty write output json metadata (default: False)
  -v, --verbose         Increase logging to debug (default: False)
```

## Creating an new article

Your accept that your contribution are licensed under the CC-BY-SA-4.0.

Each page of the website is located in `content`, for the documentation specific pages, there are
located at `content/docs`. To add a new articles just create a new makrdown file called `_index.md`
there at the location there you want to have it. e.g. for
https://developer.kde.org/docs/getting-started/installation, you need to create a file called
`content/docs/getting-started/installation/_index.md`.

This is the structure of a file:

```
---
title: Installation of the development libraries # title of the page
titleLink: Installation # title in the sidebar
description:
  > In this tutorial you will learn.... # Short summary of the page (displayed in the google description and as subtitle)
weight: 1 # ordering of the articles in the section
---

## Introduction

Normal markdown content
```

## Hugo shortcodes

There is also some custom commands that can be used to create more complex content. For the moment there is three of them available,
but more can be added if needed.

### alert

```
{{< alert title="Note" color="info" >}}
Text you want to display in the alert
{{< /alert >}}
```

Availble colors are `success`, `warning`, `error` and `info`.

### readfile

Read a file and apply syntax highlight on it. There is two option argument:

**start:** Defines the first line that should be displayed 

**lines:** Defines how many lines should be displayed.

```
{{< readfile file="/content/docs/getting-started/main_window/mainwindow.h" highlight="cpp" start="41" lines="13" >}}
```

### api-link

Currently does nothing but in the future should be able to create a link to the api documentation.

```
{{< api-link module="kxmlgui" link="KXmlGuiWindow" >}}
```
