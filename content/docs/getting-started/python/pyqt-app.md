---
title: Your first PyQt + Kirigami application
weight: 1
group: python
description: >
    Learn how to write an application with PyQt.
---

## Prerequisites

For the purposes of this tutorial, we will create the application on Linux.

To use Python together with QML, we will be using
[PyQt](https://riverbankcomputing.com/software/pyqt/intro), a project by
Riverbank Computing that allows you to write Qt applications using Python.

You will need Python installed, and that will be the case in any major Linux
distribution. But instead of using Pip to install PyQt and Kirigami, you will
need to install them from your distribution. This ensures both PyQt and
Kirigami will have been built for the same Qt version, allowing you to package
it easily. Any other dependencies can be installed from Pip in a
[Python virtual environment](https://docs.python.org/3/library/venv.html) later.

{{< installpackage
    opensuse="python3-qt6 kf6-kirigami-devel flatpak-builder qqc2-desktop-style AppStream-compose"
    fedora="python3-pyqt6 kf6-kirigami-devel flatpak-builder qqc2-desktop-style appstream-compose"
    arch="python-pyqt6 kirigami flatpak-builder qqc2-desktop-style appstream"
>}}

## Structure

The application will be a simple Markdown viewer called `simplemdviewer`.

By the end of the tutorial, the project will look like this:

```
simplemdviewer/
├── README.md
├── LICENSE.txt
├── MANIFEST.in                        # To add our QML file
├── pyproject.toml                     # To declare the tools needed to build
├── setup.py                           # To import setuptools
├── setup.cfg                          # The setuptools metadata
├── org.kde.simplemdviewer.desktop
├── org.kde.simplemdviewer.json
├── org.kde.simplemdviewer.svg
├── org.kde.simplemdviewer.metainfo.xml
└── src/
    ├── __init__.py                    # To import the src/ directory as a package
    ├── __main__.py                    # To signal simplemdviewer_app as the entrypoint
    ├── simplemdviewer_app.py
    ├── md_converter.py
    └── qml/
        └── main.qml
```

All of the metadata will be in the root folder, while the actual code will be
in `src/`:

```
simplemdviewer/
└── src/
    ├── simplemdviewer_app.py
    ├── md_converter.py
    └── qml/
        └── main.qml
```

{{< alert title="Tip" color="success" >}}

To quickly generate this folder structure, just run: `mkdir -p simplemdviewer/src/qml/`

{{< /alert >}}

## Development

The UI will be created in QML and the logic in Python. Users will write some
Markdown text, press a button, and the formatted text will be shown below it.

It is recommended to use a virtual environment. The `venv` module provides
support for virtual environments with their own site directories,
optionally isolated from system site directories.

Create a directory and a virtual environment for the project:

```bash
mkdir simplemdviewer
cd simplemdviewer
python3 -m venv --system-site-packages env/
``` 

Activate it using the activate script:

```bash
source env/bin/activate
```

We can verify that we are working in a virtual environment by checking
the `VIRTUAL_ENV` environment variable with `env | grep VIRTUAL_ENV`.

It’s time to write some code. At first the application will consist of two files:
a file with the QML description of the user interface, and a Python file that
loads the QML file.

Create a new directory `simplemdviewer/src/` and add a new
`simplemdviewer_app.py` file in this directory:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/simplemdviewer_app.py" highlight="python" >}}

We have just created a
[QGuiApplication](https://www.riverbankcomputing.com/static/Docs/PyQt6/api/qtgui/qguiapplication.html)
object that initializes the application and contains the main event loop. The
[QQmlApplicationEngine](https://www.riverbankcomputing.com/static/Docs/PyQt6/api/qtqml/qqmlapplicationengine.html)
object loads the `main.qml` file.

Create a new `src/qml/main.qml` file that specifies the UI of the application:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/main.qml" highlight="qml" >}}

{{< alert title="Warning" color="warning">}}
Older distributions such as Debian or Ubuntu LTS that do not have an up-to-date Kirigami might require lowering the Kirigami import version from `3.20` to `3.15` to run. 
{{< /alert >}}

We have just created a new QML-Kirigami-Python application. Run it:

```bash
python3 simplemdviewer_app.py
```

{{<figure src="simplemdviewer1.webp" class="text-center">}}

At the moment we have not used any interesting Python stuff. In reality,
the application can also run as a standalone QML one:

```bash
QT_QUICK_CONTROLS_STYLE=org.kde.desktop qml main.qml
```

It does not format anything; if we click on "Format" it just spits the
unformatted text into a text element.

{{<figure src="simplemdviewer2.webp" class="text-center">}}

OK, let’s add some Python logic: a simple Markdown converter in a
Python, [QObject](https://doc.qt.io/qtforpython-5/PySide2/QtCore/QObject.html#qobject) 
derivative class.

- Create a new `md_converter.py` file in the `simplemdviewer` directory:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/md_converter.py" highlight="python" >}}

The `MdConverter` class contains the `_source_text` member
variable. The `sourceText` property exposes `_source_text`
to the QML system through the `readSourceText()` getter and the
`setSourceText()` setter functions.

When setting the `sourceText` property, the `sourceTextChanged`
[signal](https://www.riverbankcomputing.com/static/Docs/PyQt6/signals_slots.html#PyQt6.QtCore.pyqtSignal)
is emitted to let QML know that the property has changed. The `mdFormat()`
function returns the Markdown-formatted text and it has been declared as a
[slot](https://www.riverbankcomputing.com/static/Docs/PyQt6/signals_slots.html#the-pyqtslot-decorator)
so as to be invokable by the QML code.

The `markdown` Python package takes care of formatting. Let’s install
it in our virtual environment:

```bash
python3 -m pip install markdown
```

It is time to register the new `MdConverter` type.

Update the `simplemdviewer_app.py` file to:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/simplemdviewer_app-2.py" highlight="python" >}}

The `qmlRegisterType()` function has registered the `MdConverter` type in the
QML system, in the library `org.kde.simplemdviewer`, version 1.0.

Change `main.qml` to:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/main-2.qml" highlight="python" >}}

The updated QML code:

1. imports the `org.kde.simplemdviewer` library
2. creates an `MdConverter` object
3. updates the `onClicked` signal handler of the `Format` button to
call the `mdFormat()` function of the converter object

Finally, test your new application:

```bash
python3 simplemdviewer_app.py
```

Play with adding some Markdown text:

{{<figure src="simplemdviewer3.webp" class="text-center">}}

Hooray!
