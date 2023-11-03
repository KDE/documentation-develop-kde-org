---
title: Formatting your tutorial
description: Get to know the tools needed to write your own tutorials.
weight: 1
authors:
 - SPDX-FileCopyrightText: 2023 Thiago Masato Costa Sueto <thiago.sueto@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
group: contribute
---

## Creating a new tutorial

You accept that your contributions are licensed under the CC-BY-SA-4.0.

Each page of the website is located in `content`, while documentation-specific pages are
located in `content/docs`.

To create a new tutorial, we use what the Hugo documentation calls a [branch bundle](https://gohugo.io/content-management/page-bundles/).

You will need to create a folder inside `content/docs`, for example, `content/docs/getting-started/installation/`, and inside it, create an `_index.md` file. This will be the index page for the tutorial, the **section**, which will group other pages inside.

So you would be creating the following, for example:

* **content/docs/getting-started/installation/_index.md**

To add new pages to the tutorial, you can then create individual Markdown files containing the name of the tutorial page. For example:

* **content/docs/getting-started/installation/howto.md**
* **content/docs/getting-started/installation/configuring.md**

To add additional content like screenshots or example code for each individual page, you can create a folder with the same name as the individual Markdown file and then add screenshots and code to it, for example:

* **content/docs/getting-started/installation/howto/code.qml**
* **content/docs/getting-started/installation/howto/image.png**
* **content/docs/getting-started/installation/configuring/code.qml**
* **content/docs/getting-started/installation/configuring/image.png**

It should look like so:

```
content/
└── docs/
    └── getting-started/
        ├── _index.md
        └── installation/       <-- Your new tutorial
            ├── _index.md       <-- Your main introduction page
            ├── configuring.md
            ├── howto.md
            ├── configuring/
            │   ├── code.qml
            │   └── image.png
            └── howto/
                ├── code.qml
                └── image.png
```

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

The minimum requirements for a page are:

* **title:**
* **weight:**
* **SPDX-FileCopyrightText:**
* **SPDX-License-Identifier:**

Other available options are:

* **group:**, which lists sections with the same name under the same group. It can be seen in action in the [Kirigami tutorial](/docs/getting-started/kirigami), with the groups Introduction, Style, Components, and Advanced. The groups need to be listed in the `_index.md` file of the tutorial.
* **aliases:**, which creates aliases that can be used to shorten links. This is useful when linking to that page from elsewhere, or to keep old links working when content is moved.

## Hugo shortcodes

There are some custom [shortcodes](https://gohugo.io/content-management/shortcodes/) that can be used to create more complex content.

They can be identified by their characteristic `{{</* */>}}`, which have HTML tags inside `<>`. Certain shortcodes require closing tags.

For readability, we add spaces between the `{{</* */>}}` and the tag, e.g. `{{</* myshortcode parameter="" */>}}`.

Do *not* add spaces between the `{` and `<`, or between `>` and `}` when using shortcodes. In other words, don't do `{{ <myshortcode parameter=""> }}`.

The most important shortcodes are as follows.

### readfile

Displays the contents of a file and applies syntax highlighting to it. It has two optional parameters:

* **start**: Defines the first line that should be displayed. By default this is 1, which means starting from the first line.

* **lines**: Defines how many lines should be displayed. By default this is 0, which displays all lines from **start** to the end of the file.

The path needs to be specified, starting from `content`.

```
{{</* readfile file="/content/docs/getting-started/kirigami/introduction-getting_started/src/contents/ui/main.qml" highlight="qml" start=17 lines=9 */>}}
```

The above example should look like so:

{{< readfile file="/content/docs/getting-started/kirigami/introduction-getting_started/src/contents/ui/main.qml" highlight="qml" start=17 lines=9 >}}

Commonly used highlighting options are:

* **cpp**
* **qml**
* **cmake**
* **python**
* **ini**

This shortcode is used once to display the file, so no closing tag is used.

### snippet

Displays the contents of a **remote** file and applies syntax highlighting to it.

It has mandatory parameters:

* **repo**: The repository as located on [Invent](https://invent.kde.org).
* **file**: The file in the repository that will be displayed.
* **part**: The section of the file in the repository that will be displayed. It requires special formatting. If it is not specified, the whole file will be shown.
* **lang**: The language of the snippet, for syntax highlighting.

For example:

ThreadWeaver belongs to the Frameworks group, so its **repo** value would be `frameworks/threadweaver`

The **file** `helloworld.cpp` which we want to display is located in `examples/HelloWorld/HelloWorld.cpp`

The **part** requires special formatting added to the example code in the remote repository, namely:

* `//@@snippet_begin(the-snippet-name)`
* `//@@snippet_end`

In the [ThreadWeaver repository](https://invent.kde.org/frameworks/threadweaver/-/blob/master/examples/HelloWorld/HelloWorld.cpp), we can see that the snippet is called "sample-helloworld", and that should be the value passed to the **part**.

We can see that the file is written in C++, so the **lang** value should be `cpp`.

The shortcode therefore is written like so:

```
{{</* snippet repo="frameworks/threadweaver" file="examples/HelloWorld/HelloWorld.cpp" part="sample-helloworld" lang="cpp" */>}}
```

The last requirement for this shortcode to work is to add `download_file('group-name/repo-name', 'path/to/file.cpp')` to the Python script in `scripts/extract-plasma-applet-config-keys.py`, and then following the instructions in the [KDE Developer Repository](https://invent.kde.org/documentation/develop-kde-org).

### alert

Displays a block of text with optional title and background color.

If no title or color is specified, it defaults to no title and color "info".

```html
{{</* alert title="Note" color="info" */>}}
Text you want to display in the alert.
{{</* /alert */>}}
```

Note that this shortcode requires a closing tag, or else it will envelop the whole page into an alert.

The available colors are `info`, `success`, `warning`, and `error`.

Usage suggestions:

* Use `info` to display general information or additional content.

{{< alert title="Note" color="info" >}}
Text you want to display in the alert.
{{< /alert >}}

* Use `success` to display advice or important pieces of information, such as tips or best practices.

{{< alert title="Tip" color="success" >}}
Did you know that you can collapse the contents of an alert?
{{< /alert >}}

* Use `warning` to warn the reader that a certain action can have dangerous results if misused.

{{< alert title="Warning" color="warning" >}}
Be careful with what you are doing here! You have been warned!
{{< /alert >}}

* Use `error` to display content that is of very high importance.

{{< alert title="Important" color="error" >}}
This WILL make your machine explode! 💣
{{< /alert >}}

In cases where your alert is too long and might disrupt the flow of the text, you can make it collapsible using [Markdown's details summary](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/organizing-information-with-collapsed-sections).

```html
{{</* alert title="Tip" color="success" */>}}
<details>
<summary>Click here to find more about this feature!</summary>
This content was hidden!
</details>
{{</* /alert */>}}
```

{{< alert title="Tip" color="success" >}}
<details>
<summary>Click here to find more about this feature!</summary>
This content was hidden!
</details>
{{< /alert >}}

### rel/ref links

Hugo provides the `relref` and `ref` shortcodes. Use them whenever you need to link to other pages or anchors.

These shortcodes allow linking directly to a certain file without needing to pass its path, for example:

`[This links to the Style Guidelines]({{</* ref "style.md" */>}})`

This would look like so:

[This links to the Style Guidelines]({{< ref "style.md" >}})

The shortcode also works with anchors. For example, linking to an `anchor` in the `helloworld.md` file would be:

`[This links to the #anchors section of the Style Guidelines]({{</* ref "style.md#anchors" */>}})`

This would look like so:

[This links to the #anchors section of the Style Guidelines]({{< ref "style.md#anchors" >}})

Linking to an `anchor` in the current file can be done this way:

`[This links to the #alert section of this page]({{</* #alert */>}})`

[This links to the #alert section of this page]({{< ref "#alert" >}})

They also error out upon finding an invalid link, which protects you from merging broken links.

Do *not* use `rel`/`relref` for the `content/hig/_index.md` and `content/docs/use/kirigami/*.md` pages, because they are translated and do not deal well with these shortcodes.

These shortcodes are used once to display the link, so no closing tag is used.

You can read more about `rel`/`relref` in the [Hugo Documentation](https://gohugo.io/content-management/cross-references/).

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

Which looks like so:

{{< installpackage
  ubuntu="build-essential cmake extra-cmake-modules qtbase5-dev qtdeclarative5-dev qtquickcontrols2-5-dev kirigami2-dev libkf5i18n-dev gettext libkf5coreaddons-dev"
  arch="base-devel extra-cmake-modules cmake qt5-base qt5-declarative qt5-quickcontrols2 kirigami2 ki18n kcoreaddons breeze"
  opensuseCommand=`sudo zypper install --type pattern devel_C_C++
sudo zypper install cmake extra-cmake-modules libQt5Core-devel libqt5-qtdeclarative-devel libQt5QuickControls2-devel kirigami2-devel ki18n-devel kcoreaddons-devel qqc2-breeze-style`
  fedoraCommand=`sudo dnf groupinstall "Development Tools" "Development Libraries"
sudo dnf install cmake extra-cmake-modules qt5-qtbase-devel qt5-qtdeclarative-devel qt5-qtquickcontrols2-devel kf5-kirigami2-devel kf5-ki18n-devel kf5-kcoreaddons-devel qqc2-breeze-style` >}}

## Add a line between shortcodes

We have tooling that parses through shortcodes.

Adding a line between shortcodes (for example, two alerts) ensures that no parsing error occurs.

```html
{{</* alert title="First note" color="info" */>}}
This is the first alert.
{{</* /alert */>}}

{{</* alert title="Second note" color="info" */>}}
This is the second alert. Notice the line between alerts.
{{</* /alert */>}}
```

As a bonus, this improves readability.

## Adding images

Images should be placed in a folder that has the same name as the Markdown file without the `.md` extension. This way, it is possible to link to the image without needing to specify its file path.

```
installation/
    ├── _index.md
    ├── configuring.md  <-- Same name
    ├── howto.md
    ├── configuring/    <-- Same name
    │   └── image.png
    └── howto/
        └── image.png
```

You can embed images in the tutorial page using `![](image.png)`.

Optionally, you can add alt text inside the brackets, e.g. `![Alternative text that will be read by screen readers.](imagefile.png)`.

If you need captions or need to position the image in a specific way, like in the horizontal center of the page, you may also use the [figure shortcode](https://gohugo.io/content-management/shortcodes/#figure):

```
{{</* figure class="text-center" caption="Caption of the image" alt="Alternative text" src="image.png" */>}}
```

The available options for positioning the image using `class=` can be found in the [Bootstrap documentation](https://getbootstrap.com/docs/4.0/).

Be careful not to leave empty attributes inside this shortcode, as this can lead to a parsing error by some of our tooling. Example: `{{</* figure src="image.png" caption="" */>}}`.

## Images in separate sections

Sometimes you'll need to display side-by-side images or images next to text for various reasons, like matching explanatory text to an example, comparing two images, for better use of space, or simply because it looks good. There are two shortcodes for this:

First, the `{{</* sections */>}}` shortcode. Use this to put one element on the left and another on the right.

It needs a closing shortcode `{{</* /sections */>}}`. Inside this shortcode, you may use `{{</* section-left */>}}` and `{{</* section-right */>}}`, both with corresponding closing versions. Here's an example:

```html
{{</* sections */>}}

{{</* section-left */>}}

Your fancy text!

{{</* /section-left */>}}

{{</* section-right */>}}

![Your fancy image!](image.png)

{{</* /section-right */>}}

{{</* /sections */>}}
```

An example of the sections shortcode can be seen in [Kirigami Tutorial: Controls and interactive elements]({{< ref "components-controls.md" >}}).

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

An example of the compare shortcode can be seen in [Kirigami Tutorial: Actions based components]({{< ref "components-actions.md#global-drawer" >}}).

## Code blocks

You can specify the language to be used to highlight code blocks written in Markdown by writing the language name after the three backticks, e.g.:

    ```cmake
    cmake -B build
    cmake --build build
    ```

The most commonly used highlighting options are:

* **c++**
* **qml**
* **cmake**
* **python**
* **ini**

## Code formatting

Use 4 spaces for source code files.

Do not use tabs.

## API links

Links to the [KDE API Documentation](https://api.kde.org) and the [Qt Documentation](https://doc.qt.io) can be generated as follows:

```
[text](docs:component;link)
```

* `text` is the text for the link
* `component` is the component group (e.g. `kirigami2`, `qtquickcontrols`)
* `link` is the item to link to (e.g. `QtQuick.Controls.Label`, `org::kde::kirigami::BasicListItem`, `KMessageBox`).

The `component` matches the name of the `.json` files in `_data`, in the root folder of the [KDE Developer Repository](https://invent.kde.org/documentation/develop-kde-org). Inside the corresponding `.json` file, searching for the name of the class or function you need will give you the name of the `link`.

Whenever you need to link to the main page for the documentation of a KDE component, you can omit the `link`, as in `[Kirigami](docs:kirigami2)`. This cannot be done for Qt components.

If the component you want to link to wasn't added to `scripts/doxygen_integration.py` yet, add it to the file and execute `python3 scripts/doxygen_integration.py`. After running the script, make sure to add the generated JSON files in the `_data/` folder and commit them together with your MR.

Examples:
 - `[AbstractCard](docs:kirigami2;AbstractCard)`
 - `[Kirigami.Units.devicePixelRatio](docs:kirigami2;Kirigami::Units::devicePixelRatio)`
 - `[KMessageBox](docs:kwidgetsaddons;KMessageBox)`
 - `[Label](docs:qtquickcontrols;QtQuick.Controls.Label)`
