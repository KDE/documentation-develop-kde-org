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
the official Python bindings for the Qt framework, or
[PyQt](https://riverbankcomputing.com/software/pyqt/intro), a project by
Riverbank Computing that allows you to write Qt applications using Python.

You will need Python installed, and that will be the case in any major Linux
distribution. But instead of using `pip` to install PySide/PyQt and Kirigami, you will
need to install them from your distribution. This ensures PySide/PyQt and
Kirigami will have been built for the same Qt version, allowing you to package
it easily. Any other dependencies can be installed from `pip` in a
[Python virtual environment](https://docs.python.org/3/library/venv.html) later.

{{< installpackage
    opensuse="python3-qt6 python3-pyside6 kf6-kirigami-devel flatpak-builder qqc2-desktop-style AppStream-compose"
    fedora="python3-pyqt6 python3-pyside6 kf6-kirigami-devel flatpak-builder qqc2-desktop-style appstream-compose"
    arch="python-pyqt6 pyside6 kirigami flatpak-builder qqc2-desktop-style appstream"
>}}

This tutorial works with our tutorial about [building software with distrobox]({{< ref "containers-distrobox" >}}).

## Structure

The application will be a simple Markdown viewer called `simplemdviewer`.

By the end of the tutorial, the project will look like this:

```tree
simplemdviewer/
├── README.md
├── LICENSE.txt
├── MANIFEST.in                        # To add our QML file
├── pyproject.toml                     # The main file to manage the project
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

{{< alert title="💡 Tip" color="success" >}}

To quickly generate this folder structure, just run: `mkdir -p simplemdviewer/src/qml/`

{{< /alert >}}

## Setting up the project

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

A new virtual environment will be created in `env/`, pulling the required Python modules straight from your distribution packages. Activate it using the activate script:

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

{{< tabset >}}

{{< tab tabName="PySide6" >}}

{{< readfile file="/content/docs/getting-started/python/pyside-app/src/simplemdviewer_app.py" highlight="python" emphasize="6-8" >}}

{{< /tab >}}

{{< tab tabName="PyQt6" >}}

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/simplemdviewer_app.py" highlight="python" emphasize="6-8" >}}

{{< /tab >}}

{{< /tabset >}}

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

### First test run

We have just created a new QML-Kirigami-Python application. Run it:

```bash
python3 simplemdviewer_app.py
```

{{<figure src="simplemdviewer1.webp" class="text-center">}}

At the moment we have not used any interesting Python stuff. In reality,
the application can also run as a standalone QML app:

```bash
QT_QUICK_CONTROLS_STYLE=org.kde.desktop qml main.qml
```

It does not format anything; if we click on "Format" it just spits the
unformatted text into a text element.

{{<figure src="simplemdviewer2.webp" class="text-center">}}

### Adding Markdown functionality

Let’s add some Python logic: a simple Markdown converter in a
Python, [QObject](https://doc.qt.io/qtforpython-6/PySide6/QtCore/QObject.html)
derivative class.

We need this to be a QObject-derived class in order to make use of Qt's powerful
[signals and slots](https://doc.qt.io/qtforpython-6/overviews/signalsandslots.html).

Create a new `md_converter.py` file in the `simplemdviewer/src/` directory:

{{< tabset >}}

{{< tab tabName="PySide6" >}}

{{< readfile file="/content/docs/getting-started/python/pyside-app/src/md_converter.py" highlight="python" emphasize="12 18 22 27" >}}

{{< /tab >}}

{{< tab tabName="PyQt6" >}}

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/md_converter.py" highlight="python" emphasize="7 20-22 24" >}}

{{< /tab >}}

{{< /tabset >}}

The `MdConverter` class contains the `_source_text` member variable.
The `sourceText` property exposes `_source_text` to the QML system
by using a getter/accessor and a setter/modifier.

In the PySide6 case, we use a
[Property decorator](https://realpython.com/python-property/#using-property-as-a-decorator) 
(beginning with `@`) in lines 18 and 22. Note that the name of the
function needs to be the same for both getter and setter: the getter
is marked with `@Property` and the setter is marked as `functionName.setter`.

In the PyQt6 case, we use a
[Property as a function](https://realpython.com/python-property/#creating-attributes-with-property)
by creating a property with the `pyqtProperty()` function in lines 20-22.
Note that the name of the getter and setter needs to be different here.

When setting the `sourceText` property, the `sourceTextChanged`
[signal](https://doc.qt.io/qtforpython-6/overviews/signalsandslots.html#signals)
is emitted to let QML know that the property has changed. Note that
the `sourceTextChanged` needs to be marked with `notify=` before it can be
emitted with `.emit()`.

The `mdFormat()` function returns the Markdown-formatted
text and it has been declared as a
[slot](https://doc.qt.io/qtforpython-6/overviews/signalsandslots.html#slots)
so as to be invokable by the QML code.

The `markdown` Python package takes care of formatting. Let’s install
it in our virtual environment:

```bash
python3 -m pip install markdown
```

Now, update the `simplemdviewer_app.py` file to:

{{< tabset >}}

{{< tab tabName="PySide6" >}}

{{< readfile file="/content/docs/getting-started/python/pyside-app/src/simplemdviewer_app-2.py" highlight="python" emphasize="9" >}}

{{< /tab >}}

{{< tab tabName="PyQt6" >}}

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/simplemdviewer_app-2.py" highlight="python" emphasize="8-9 23" >}}

{{< /tab >}}

{{< /tabset >}}

The Python import `from md_converter import MdConverter` in
`simplemdviewer_app.py` takes care of making both Python and the QML engine
aware of the new `MdConverter`. In PySide we add `# noqa: F401` just so later on
linters don't complain about the unused import. In PyQt the import is used in line 23.

In PyQt, the `qmlRegisterType()` function registers the `MdConverter` type in the
QML system, under the import name `org.kde.simplemdviewer`, version 1.0.

In PySide, this registration is done in the file where the class is defined,
namely through the `@QmlElement` decorator in `md_converter.py`. Let's revisit it:

{{< readfile file="/content/docs/getting-started/python/pyside-app/src/md_converter.py" highlight="python" lines="10" emphasize="3 5-6 8" >}}

The import name and version of the `MdConverter` type is set through the variables `QML_IMPORT_NAME` and `QML_IMPORT_MAJOR_VERSION`.

Change `main.qml` to:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/main-2.qml" highlight="qml" emphasize="5 25-29 52" >}}

The updated QML code:

1. imports the `org.kde.simplemdviewer` library
2. creates an `MdConverter` object
3. updates the `onClicked` signal handler of the `Format` button to
call the `mdFormat()` function of the converter object

### Final test run

At last, test your new application:

```bash
python3 simplemdviewer_app.py
```

Play with adding some Markdown text:

{{<figure src="simplemdviewer3.webp" class="text-center">}}

Hooray!
