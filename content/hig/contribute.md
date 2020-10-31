---
title: Contribute
weight: 10
---

The HIG is written in [markdown](https://commonmark.org/help/), a
lightweight markup language. For example the chapter heading together
with the first paragraph looks like this in markdown

``` {.rst}
---
title: Contribute
---

The HIG is written in [markdown](https://commonmark.org/help/), a
lightweight markup language. For example the chapter heading together
with the first paragraph looks like this in markdown
```

The restructuredText of the full HIG is organized into several source
files. You can view and modify these source files with any text editor.

The source files are hosted in a [Git
repo](https://cgit.kde.org/websites/hig-kde-org.git/).
[Sphinx](http://www.sphinx-doc.org) is used to generate HTML pages from
these source files. Tasks and changes are organized via
[https://invent.kde.org](https://invent.kde.org/websites/hig-kde-org).

::: {.note}
::: {.title}
Note
:::

On every page of the HIG, there is a *View page source* link in the top
right corner.
:::

For more information and help you can find us on
[Matrix](https://matrix.to/#/#kde_vdg:matrix.org),
[IRC](irc://chat.freenode.net/kde-vdg) or
[Telegram](https://telegram.me/vdgmainroom).

If you are new to KDE development, make sure to read [how to become a
KDE developer](https://community.kde.org/Get_Involved/development)
first.

::: {.contents depth="1" local="" backlinks="none"}
:::

Getting Started
---------------

1.  Install some tools with your distro\'s package manager:

  Distribution               Command
  -------------------------- ------------------------------------------------------
  Arch, Manjaro              `sudo pacman -S git make python`
  Debian, Ubuntu, KDE Neon   `sudo apt install git make python3`
  openSUSE                   `sudo zypper install git-core python3 python3-devel`
  Fedora                     `sudo dnf install git make python3`
  CentOS/RHEL                `sudo yum install git make python3`

1.  Clone the HIG source code repository into an empty folder:

    ``` {.sh}
    git clone https://invent.kde.org/websites/hig-kde-org.git
    cd hig-kde-org
    ```

2.  Create a Python 3 virtual environment, enable it and install the
    requirements from `requirements.txt` into it:

    ``` {.sh}
    python3 -m venv venv
    . venv/bin/activate
    pip install -r requirements.txt
    ```

Now you are ready to contribute to the HIG! To preview changes on your
local machine, enter the directory of a website (`HIG` or `Kirigami`)
and use `make` to generate the HTML version of the documentation. For
example:

``` {.sh}
cd HIG
make html
```

You will find the documentation inside `build/html` within the
corresponding website directory. Open `build/html/index.html` in your
browser (e.g. run `xdg-open build/html/index.html`)

Page Structure
--------------

This defines the structure that should be used for writing pattern and
component pages for the HIG.

### Pattern

    Pattern name
    ==============

    Give a short into into the pattern.

    Examples
    --------

    Showcase the pattern with videos or images.

    When to use
    -----------

    Describe when to use this pattern and when not to use it.

    How to use
    ----------

    Describe how to use this pattern.

Pages about patterns should not include any details on implementation,
about behavior or appearance, but rather link to the corresponding
components needed to implement a pattern.

Optional: you can add subsections for desktop and mobile.

    When to use
    -----------

    Desktop
    ^^^^^^^

    Mobile
    ^^^^^^

### Component

    Component name
    ==============

    Purpose
    -------

    A very short description on why and how to use the component. This should 
    primarily link to the corresponding pattern pages.

    Example
    -------

    Showcase the component with a video or image.

    Guidelines
    ----------

    Is this the right control?
    ~~~~~~~~~~~~~~~~~~~~~~~~~~

    Describe when to use a component and when not.

    Behavior
    ~~~~~~~~

    Describe the behavior of the component.

    Appearance
    ~~~~~~~~~~

    Describe the appearance of the component.

    Code
    ----

    Kirigami
    ~~~~~~~~

    Link to the API and example code how to use the component with QML and 
    Kirigami.

    Qt Widgets
    ~~~~~~~~~~

    Link to the API and example code how to use the component with Qt Widgets.

Optional: you can add subsections for desktop and mobile.

    Behavior
    ~~~~~~~~

    Desktop
    """""""

    Mobile
    """"""

Code Examples
-------------

Adding examples to the HIG is very easy.

1.  Add a file with source code in the `./examples/` folder.

2.  Add the following markup at the point you want to insert the
    example:

    ``` {.rst}
    .. literalinclude:: /../../examples/kirigami/InlineMessage.qml
       :language: qml
    ```

Creating media
--------------

See `media`{.interpreted-text role="doc"} on how to create media files
for the HIG.

Submitting your changes
-----------------------

The HIG uses GitLab for patch submissions:
<https://invent.kde.org/websites/hig-kde-org/-/merge_requests>.

For more information, see
<https://community.kde.org/Infrastructure/GitLab>.
