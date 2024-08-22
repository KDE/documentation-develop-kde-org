---
title: Your first Python + Kirigami application
weight: 1
group: python
description: >
    Learn how to write an application with PyQt/PySide.
---

## Prerequisites

For the purposes of this tutorial, we will create the application on Linux.

To use Python together with QML, we can use either [PySide](https://doc.qt.io/qtforpython-6/),
the official Python bindings for the Qt framework or
[PyQt](https://riverbankcomputing.com/software/pyqt/intro), a project by
Riverbank Computing that allows you to write Qt applications using Python.

You will need Python installed, and that will be the case in any major Linux
distribution. But instead of using `pip` to install PySide/PyQt and Kirigami, you will
need to install them from your distribution. This ensures PySide/PyQt and
Kirigami will have been built for the same Qt version, allowing you to package
it easily. Any other dependencies can be installed from `pip` in a
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

{{< tabset-qt >}}
{{< tab-qt tabName="PyQt6" >}}
{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/simplemdviewer_app.py" highlight="python" >}}
{{< /tab-qt >}}
{{< tab-qt tabName="PySide6" >}}
{{< readfile file="/content/docs/getting-started/python/pyside-app/src/simplemdviewer_app.py" highlight="python" >}}
{{< /tab-qt >}}
{{< /tabset-qt >}}

We have just created a
[QGuiApplication](https://doc.qt.io/qtforpython-6/PySide6/QtGui/QGuiApplication.html#PySide6.QtGui.QGuiApplication)
object that initializes the application and contains the main event loop. The
[QQmlApplicationEngine](https://doc.qt.io/qtforpython-6/PySide6/QtQml/QQmlApplicationEngine.html#PySide6.QtQml.QQmlApplicationEngine)
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
Python, [QObject](https://doc.qt.io/qtforpython-6/PySide6/QtCore/QObject.html)
derivative class.

- Create a new `md_converter.py` file in the `simplemdviewer` directory:

{{< tabset-qt >}}
{{< tab-qt tabName="PyQt6" >}}
{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/md_converter.py" highlight="python" >}}
{{< /tab-qt >}}
{{< tab-qt tabName="PySide6" >}}
{{< readfile file="/content/docs/getting-started/python/pyside-app/src/md_converter.py" highlight="python" >}}
{{< /tab-qt >}}
{{< /tabset-qt >}}

The `MdConverter` class contains the `_source_text` member
variable. The `sourceText` property exposes `_source_text`
to the QML system through the `readSourceText()` getter and the
`setSourceText()` setter functions in PyQt. In PySide, Python-like
setters and getters are used for this purpose.

When setting the `sourceText` property, the `sourceTextChanged`
[signal](https://doc.qt.io/qtforpython-6/overviews/signalsandslots.html#signals)
is emitted to let QML know that the property has changed. The `mdFormat()`
function returns the Markdown-formatted text and it has been declared as a
[slot](https://doc.qt.io/qtforpython-6/overviews/signalsandslots.html#slots)
so as to be invokable by the QML code.

The `markdown` Python package takes care of formatting. Let’s install
it in our virtual environment:

```bash
python3 -m pip install markdown
```

It is worth noting that in PySide, the Python decorator `@QmlElement`, along with
the `QML_IMPORT_NAME` and `QML_IMPORT_MAJOR_VERSION` takes care of registering the
class `MdConveter` with QML. In PyQt, this is done through the function
`qmlRegisterType()` inside `simplemdviewer_app.py` as seen below.

Update the `simplemdviewer_app.py` file to:

{{< tabset-qt >}}
{{< tab-qt tabName="PyQt6" >}}
{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/simplemdviewer_app-2.py" highlight="python" >}}
{{< /tab-qt >}}
{{< tab-qt tabName="PySide6" >}}
{{< readfile file="/content/docs/getting-started/python/pyside-app/src/simplemdviewer_app-2.py" highlight="python" >}}
{{< /tab-qt >}}
{{< /tabset-qt >}}

In PyQt, the `qmlRegisterType()` function has registered the `MdConverter` type in the
QML system, in the library `org.kde.simplemdviewer`, version 1.0. In PySide, this registration is done in the
file where the class is defined i.e. `md_converter.py` through the `@QmlElement` decorator.
The import name and version of `MdConverter` type is set through the variables `QML_IMPORT_NAME` and
`QML_IMPORT_MAJOR_VERSION`. Finally, the Python import `from md_converter import MdConverter` in PySide's
`simplemdviewer_app.py` takes care of making Python and QML engine aware of the `@QmlElement` decorator.

Change `main.qml` to:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/main-2.qml" highlight="qml" >}}

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
