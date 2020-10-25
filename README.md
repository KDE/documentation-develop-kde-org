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

You accept that your contributions are licensed under the CC-BY-SA-4.0.

Each page of the website is located in `content`, for the documentation specific pages, they are
located at `content/docs`. To add a new article just create a new markdown file called `_index.md`
at the location you want it to have, e.g. for
`https://developer.kde.org/docs/getting-started/installation`, you need to create a file called
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

There are also some custom commands that can be used to create more complex content. For the moment there are three of them available,
but more can be added if needed.

### alert

```
{{< alert title="Note" color="info" >}}
Text you want to display in the alert
{{< /alert >}}
```

Available colors are `success`, `warning`, `error` and `info`.

### readfile

Read a file and apply syntax highlight on it. There is two option argument:

**start:** Defines the first line that should be displayed 

**lines:** Defines how many lines should be displayed.

```
{{< readfile file="/content/docs/getting-started/main_window/mainwindow.h" highlight="cpp" start="41" lines="13" >}}
```

### Api links

Links to `api.kde.org` and `doc.qt.io` can be generated as follows:

```
[text](docs:component;link)
```

where `text` is the text for the link, `component` is the component (e.g. `kirigami2`, `qtquickcontrols`) and `link` is the item to link to (e.g. `QtQuick.Controls.Label`, `org::kde::kirigami::BasicListItem`, `KMessageBox`)

When you want to link to the main page of a component's documentation, you can omit the `link`, as in `[Kirigami](docs:kirigami2)`.

If the component you want to link to isn't added to `scripts/doxygen_integration.py` yet, add it there and execute `python scripts/doxygen_integration.py`.

Examples:
 - `[AbstractCard](docs:kirigami2;AbstractCard)`
 - `[KMessageBox](docs:kwidgetsaddons;KMessageBox)`
 - `[Label](docs:qtquickcontrols;QtQuick.Controls.Label)`
