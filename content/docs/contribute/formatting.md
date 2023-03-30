---
title: Formatting your tutorial
description: Get to know the tools needed to write your own tutorials.
weight: 1
authors:
 - SPDX-FileCopyrightText: 2023 Thiago Masato Costa Sueto <thiago.sueto@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
group: contribute
---

## Creating a new article

You accept that your contributions are licensed under the CC-BY-SA-4.0.

Each page of the website is located in `content`, while documentation-specific pages are
located in `content/docs`.

 To create a new tutorial, you need to create a folder inside `content/docs`, for example, `content/docs/getting-started/installation/`, and inside it, create an `_index.md` file. This will be the index page for the tutorial, the **section**, which will group other pages inside.

 To add new pages to the tutorial, you can then create individual Markdown files containing the name of the tutorial page. For instance, you could have a `content/docs/getting-started/installation/howto.md` and a `content/docs/getting-started/installation/configuring.md`.

To add additional content like screenshots or example code for each individual page, you can create a folder containing the same name as the individual Markdown file, for example `content/docs/getting-started/installation/howto/` and `content/docs/getting-started/installation/configuring/`.

This is the structure of a typical page:

```
---
title: Installation of the development libraries # title of the page
linkTitle: Installation # title in the sidebar, no need to add if the same as `title`
description:
  > In this tutorial you will learn.... # Short summary of the page (displayed in the google description and as subtitle)
weight: 1 # ordering of the articles in the section
authors:
  - SPDX-FileCopyrightText: 2023 Your name <email@address>
SPDX-License-Identifier: CC-BY-SA-4.0
---

## Introduction

Normal markdown content
```

`title:`, `weight:`, `SPDX-FileCopyrightText:` and `SPDX-License-Identifier:` are the minimum requirements for a page.

Other available options are:

* `group:`, which lists sections with the same name under the same group. It can be seen in action in the [Kirigami tutorial](/docs/getting-started/kirigami), with the groups Introduction, Style, Components, and Advanced. The groups need to be listed in the `_index.md` file of the tutorial.
* `aliases:`, which creates aliases that can be used to shorten links. This is useful when linking to that page from elsewhere.

## Hugo shortcodes

There are some custom [shortcodes](https://gohugo.io/content-management/shortcodes/) that can be used to create more complex content.

They can be identified by their characteristic `{{</* */>}}`, which have HTML tags inside `<>`. Certain shortcodes require closing tags.

For readability, we add spaces between the `{{</* */>}}` and the tag, e.g. `{{</* myshortcode parameter="" */>}}`.

Do *not* add spaces between the `{` and `<`, or between `>` and `}` when using shortcodes. In other words, don't do `{{ <contenthere> }}`.

The most important shortcodes are as follows.

### readfile

Displays the contents of a file and applies syntax highlighting to it. It has two optional parameters:

**start**: Defines the first line that should be displayed. By default this is 1, which means starting from the first line.

**lines**: Defines how many lines should be displayed. By default this is 0, which displays all lines from **start** to the end of the file.

The path needs to be specified, starting from `content`.

```
{{</* readfile file="/content/docs/getting-started/main_window/mainwindow.h" highlight="cpp" start=41 lines=13 */>}}
```

Commonly used highlighting options are `cpp`, `qml`, `cmake`.

This shortcode is used once to display the file, so no closing tag is used.

### alert

Displays a block of text with optional title and background color.

If no title or color is specified, it defaults to no title and color "info".

```
{{</* alert title="Note" color="info" */>}}
Text you want to display in the alert
{{</* /alert */>}}
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

These shortcodes allow linking directly to a certain file without needing to pass its path, e.g. `{{</* ref "helloworld.md" */>}}`. This also works with anchors, e.g. linking to an `anchor` in the `helloworld.md` file would be `{{</* ref "helloworld.md#anchor" */>}}`, and linking to an `anchor` in the current file would be `{{</* #anchor */>}}`.

They also error out upon finding an invalid link, which protects you from merging broken links.

Do *not* use `rel`/`relref` for the `content/hig/_index.md` and `content/docs/use/kirigami/*.md` pages.

These shortcodes are used once to display the link, so no closing tag is used.

You can read more about `rel`/`relref` [here](https://gohugo.io/content-management/cross-references/).

### installpackage

We have a custom shortcode that can be used to list packages or commands that are specific to certain major distributions, the `{{</* installpackage */>}}` shortcode. This can be used at the beginning of a tutorial or page to make it convenient for the user to install the prerequisites for the project.

There are two types of attributes that can be passed: a distro name, and a distro command.

Here's an example taken from the Kirigami tutorial:

```
{{</* installpackage
  ubuntu="build-essential cmake extra-cmake-modules qtbase5-dev qtdeclarative5-dev qtquickcontrols2-5-dev kirigami2-dev libkf5i18n-dev gettext libkf5coreaddons-dev"
  arch="base-devel extra-cmake-modules cmake qt5-base qt5-declarative qt5-quickcontrols2 kirigami2 ki18n kcoreaddons breeze"
  opensuseCommand=`sudo zypper install --type pattern devel_C_C++
sudo zypper install cmake extra-cmake-modules libQt5Core-devel libqt5-qtdeclarative-devel libQt5QuickControls2-devel kirigami2-devel ki18n-devel kcoreaddons-devel qqc2-breeze-style`
  fedoraCommand=`sudo dnf groupinstall "Development Tools" "Development Libraries"
sudo dnf install cmake extra-cmake-modules qt5-qtbase-devel qt5-qtdeclarative-devel qt5-qtquickcontrols2-devel kf5-kirigami2-devel kf5-ki18n-devel kf5-kcoreaddons-devel qqc2-breeze-style` */>}}
```

Which looks like [this](/docs/getting-started/kirigami/introduction-getting_started).

## Add a line between shortcodes

We have tooling that parses through shortcodes.

Adding a line between shortcodes ensures that no parsing error occurs.

## Adding images

Images should be placed in a folder that has the same name as the Markdown file without the `.md` extension. This way, it is possible to link to the image without needing to specify its path.

You can embed images in the tutorial page using `![](imagefile.png)`. Optionally, you can add alt text inside the brackets, e.g. `![Alternative text that will be read by screen readers.](imagefile.png)`.

If you need captions or need to position the image in a specific way, like in the horizontal center of the page, you may also use the [figure shortcode](https://gohugo.io/content-management/shortcodes/#figure): `{{</* figure class="text-center" caption="Caption of the image" alt="Alternative text" src="image.png" */>}}`. The available options for positioning the image using `class=` can be found in the [Bootstrap documentation](https://getbootstrap.com/docs/4.0/).

Be careful not to leave empty attributes inside this shortcode, as this can lead to a parsing error by some of our tooling. Example: `{{</* figure src="image.png" caption="" */>}}`.

## Images in separate sections

Sometimes you'll need to display side-by-side images or images next to text for various reasons, like matching explanatory text to an example, comparing two images, for better use of space, or simply because it looks good. There are two shortcodes for this:

First, the `{{</* sections */>}}` shortcode. Use this to put one element on the left and another on the right.

It needs a closing shortcode `{{</* /sections */>}}`. Inside this shortcode, you may use `{{</* section-left */>}}` and `{{</* section-right */>}}`, both with corresponding closing versions. Here's an example:

```markdown
{{</* sections */>}}

{{</* section-left */>}}

Your fancy text!

{{</* /section-left */>}}

{{</* section-right */>}}

![Your fancy image!](image.png)

{{</* /section-right */>}}

{{</* /sections */>}}
```

Second, the `{{</* compare */>}}` shortcode. Use this only with images, to showcase bad and good behavior. You'll see this most commonly used in the HIG.

It needs a closing shortcode `{{</* /compare */>}}`. Inside this shortcode, you may use `{{</* dont src="bad-image.png" */>}}` and `{{</* do src="good-image.png" */>}}`, both with corresponding closing versions, with text in between. Here's an example:

```markdown
{{</* compare */>}}

{{</* dont src="bad-image.png" */>}}

Don't do this!

{{</* /dont */>}}

{{</* do src="good-image.png" */>}}

Do this instead!

{{</* /do */>}}

{{</* /compare */>}}
```

## Code blocks

You can specify the language to be used to highlight code blocks written in Markdown by writing the language name after the three backticks, e.g.:

    ```cmake
    cmake -B build
    cmake --build build
    ```

The most commonly used highlighting options are `c++`, `qml`, `cmake`.

## Code formatting

When creating new source code files to be displayed using the readfile shortcode, use 4 spaces for C++ and QML files. Do not use tabs.

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
