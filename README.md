# KDE Developer website

## Before running the website

Download the latest Hugo release (extended version) from [here](https://github.com/gohugoio/hugo/releases) and clone this repo. Once you've cloned the site repo, enter the repo root folder.

Certain tutorials fetch examples directly from their respective repositories (library-specific ones, like KArchive or KAuth); to display them, you'll need to run a Python script.
Make sure you have the required dependencies installed on your system. We suggest using `venv` for this:

```
python3 -m venv .
source bin/activate
pip install -r requirements.txt
```

Then, run this Python script:

```
python3 scripts/extract-plasma-applet-config-keys.py
```

## Running the website locally

From the repo's root folder, run:

```
hugo server
```

And open [http://localhost:1313](http://localhost:1313)


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

## Creating a new article

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
authors:
  - SPDX-FileCopyrightText: Your name <email@address>
SPDX-License-Identifier: CC-BY-SA-4.0
---

## Introduction

Normal markdown content
```

`title:` and `weight:` are the minimum requirements for a page.

Other available options are:

* `group:`, which lists sections with the same name under the same group. It can be seen in action in the [Kirigami tutorial](https://develop.kde.org/docs/use/kirigami/), with the groups Introduction, Style, Components, and Advanced. The groups need to be listed in the `_index` file of the tutorial.
* `aliases:`, which creates aliases which can be used to shorten links. This is useful when linking to that page from elsewhere.

## Hugo shortcodes

There are also some custom [shortcodes](https://gohugo.io/content-management/shortcodes/) that can be used to create more complex content.

They can be identified by their characteristic `{{< >}}`, which have HTML tags inside `<>`. Certain shortcodes require closing tags.

For readability, we add spaces between the `{{< >}}` and the tag, e.g. `{{< myshortcode parameter="" >}}`.

Do *not* add spaces between the `{` and `<`, or between `>` and `}` when using shortcodes.

The most important ones are as follows.

### readfile

Displays the contents of a file and applies syntax highlighting to it. There are two optional parameters:

**start**: Defines the first line that should be displayed. By default this is 1, which means starting from the first line.

**lines**: Defines how many lines should be displayed. By default this is 0, which displays all lines from **start** to the end of the file.

The path needs to be specified, starting from `content`.

```
{{< readfile file="/content/docs/getting-started/main_window/mainwindow.h" highlight="cpp" start=41 lines=13 >}}
```

Commonly used highlighting options are `cpp`, `qml`, `cmake`.

This shortcode is used once to display the file, so no closing tag is used.

### alert

Displays a block of text with optional title and background color.

If no title or color is specified, it defaults to no title and color "info".

```
{{< alert title="Note" color="info" >}}
Text you want to display in the alert
{{< /alert >}}
```

Note that this shortcode requires a closing tag, or else it will envelop the whole page into an alert.

The available colors are `success`, `warning`, `error`, and `info`.

Usage suggestions:

* Use `info` to display general information or additional content.

* Use `warning` to warn the reader that a certain action can have dangerous results if misused.

* Use `error` to display content that is critical to the tutorial and must not be forgotten.

* Use `success` to display advice or important pieces of information.

### rel/ref links

Hugo provides the `relref` and `ref` shortcodes. Use them whenever you need to link to other pages or anchors.

These shortcodes allow linking directly to a certain file without needing to pass its path, e.g. `{{< ref "helloworld.md" >}}`. This also works with anchors, e.g. linking to an `anchor` in the `helloworld.md` file would be `{{< ref "helloworld.md#anchor" >}}`, and linking to an `anchor` in the current file would be `{{< #anchor >}}`.

They also error out upon finding an invalid link, which protects you from merging broken links.

Do *not* use `rel`/`relref` for the `content/hig/_index.md` and `content/docs/use/kirigami/*.md` pages.

These shortcodes are used once to display the link, so no closing tag is used.

You can read more about `rel`/`relref` [here](https://gohugo.io/content-management/cross-references/).

## Adding images

Images should be placed in a folder that has the same name as the Markdown file without the `.md` extension. This way, it is possible to link to the image without needing to specify its path.

You can embed images in the tutorial page using `![](imagefile.png)`. Optionally, you can add alt text inside the brackets, e.g. `![Alternative text that will be read by screen readers.](imagefile.png)`.

If you need captions or need to position the image in a specific way, like in the horizontal center of the page, you may also use the [figure shortcode](https://gohugo.io/content-management/shortcodes/#figure): `{{< figure class="text-center" caption="Caption of the image" alt="Alternative text" src="image.png" >}}`. The available options for positioning the image using `class=` can be found in the [Bootstrap documentation](https://getbootstrap.com/docs/4.0/).

## Code blocks

You can specify the language to be used to highlight code blocks written in Markdown by writing the language name after the three backticks, e.g.:

    ```cmake
    cmake -B build
    cmake --build build
    ```

The most commonly used highlighting options are `c++`, `qml`, `cmake`.

## Code formatting

When creating new source code files to be displayed using the readfile shortcode, use 2 spaces for C++ files and 4 spaces for QML files. Do not use tabs.

## API links

Links to `api.kde.org` and `doc.qt.io` can be generated as follows:

```
[text](docs:component;link)
```

where `text` is the text for the link, `component` is the component group (e.g. `kirigami2`, `qtquickcontrols`) and `link` is the item to link to (e.g. `QtQuick.Controls.Label`, `org::kde::kirigami::BasicListItem`, `KMessageBox`).

The `component` matches the name of the `.json` files in `_data`. Inside the corresponding `.json` file, searching for the name of the class or function you need will give you the name of the `link`.

When you want to link to the main page for the documentation of a KDE component, you can omit the `link`, as in `[Kirigami](docs:kirigami2)`. This cannot be done for Qt components.

If the component you want to link to wasn't added to `scripts/doxygen_integration.py` yet, add it there and execute `python3 scripts/doxygen_integration.py`. After running the script, make sure to add the generated JSON files in the `_data/` folder and commit them together with your MR.

Examples:
 - `[AbstractCard](docs:kirigami2;AbstractCard)`
 - `[KMessageBox](docs:kwidgetsaddons;KMessageBox)`
 - `[Label](docs:qtquickcontrols;QtQuick.Controls.Label)`

## I18n
The Kirigami tutorials are internationalized and localized using [hugoi18n](https://invent.kde.org/websites/hugo-i18n).

## kde-hugo theme
This website uses a theme shared among KDE websites that are Hugo-based. If you have some issue that you think is not inside this repo, or if you just want to know more about the theme, have a look at [kde-hugo wiki](https://invent.kde.org/websites/aether-sass/-/wikis/Hugo).
