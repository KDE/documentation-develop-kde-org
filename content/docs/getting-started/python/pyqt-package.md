---
title: Creating a Python package
weight: 2
group: python
description: >
    Understand the requirements to create your own Python package.
---

## Packaging the application

To distribute the application to users we have to package it. We
are going to use the [setuptools](https://pypi.org/project/setuptools/)
library.

If you'd like to learn more about Python packaging, you'll be interested in the
[Python Packaging User Guide](https://packaging.python.org/en/latest/guides/distributing-packages-using-setuptools/).

Let's recapitulate what the file structure of the project should be:

```
simplemdviewer
├── README.md
├── LICENSE.txt
├── MANIFEST.in                        # To add our QML file
├── pyproject.toml                     # To declare the tools used to build
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

Create a `simplemdviewer/pyproject.toml` to tell the Python build tools what is
needed to build our project:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/pyproject.toml" highlight="toml" >}}

Create a `simplemdviewer/setup.py` to call `setuptools`:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/setup.py" highlight="python" >}}

Add a new `simplemdviewer/setup.cfg` to describe the application:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/setup.cfg" highlight="ini" >}}

In the `metadata` section we have provided information about the application.

The `options` section contains the project dependencies and the
[import package](https://packaging.python.org/en/latest/glossary/#term-Import-Package)
that our [distribution package](https://packaging.python.org/en/latest/glossary/#term-Distribution-Package)
is going to provide. There is a lot of
[options](https://setuptools.readthedocs.io/en/latest/userguide/declarative_config.html)
and [classifiers](https://pypi.org/classifiers/) available.

For more details on dependency management in setuptools, check
[here](https://setuptools.pypa.io/en/latest/userguide/dependency_management.html).

Create an empty `simplemdviewer/src/__init__.py` file.
This file just needs to be present in order to import a directory as a package.

```bash
touch __init__.py
```

Since we are using a custom package directory, namely `src/`, we pass it as the
correct `package_dir` to find our `simplemdviewer` application.

It is good to have a `README.md` file as well.

Create a `simplemdviewer/README.md`:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/README.txt" highlight="markdown" >}}

Another important piece is the license of our project. Create a
`simplemdviewer/LICENSE.txt` and add the text of the
[license](https://www.gnu.org/licenses/gpl-3.0.txt) of our project.

Apart from the Python stuff, we have to add the QML code to the
distribution package as well.

Create a `simplemdviewer/MANIFEST.in` file with the following contents:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/MANIFEST.in" highlight="qml" >}}

## App metadata

Some last pieces and we are ready to build. We are going to add:

1. The [Appstream](https://www.freedesktop.org/wiki/Distributions/AppStream/)
metadata used to show the app in software stores.
2. A [Desktop Entry](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html)
file to add the application to the application launcher.
3. An application icon.

Create a new `simplemdviewer/org.kde.simplemdviewer.desktop`. This file is
used to show our Markdown Viewer in application menus/launchers.

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/org.kde.simplemdviewer.desktop" highlight="bash" >}}

Add a new `simplemdviewer/org.kde.simplemdviewer.metainfo.xml`. This file is
used to show the application in app stores.

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/org.kde.simplemdviewer.metainfo.xml" highlight="xml" >}}

For this tutorial the well known Markdown icon is okay.

Get the
[Markdown](https://en.wikipedia.org/wiki/Markdown#/media/File:Markdown-mark.svg)
icon and save it as `simplemdviewer/org.kde.simplemdviewer.svg`.

We need the icon to be perfectly squared, which can be accomplished with
[Inkscape](https://inkscape.org):

1. Open `Markdown-mark.svg` in Inkscape.
2. Type Ctrl+a to select everything.
3. On the top `W:` text field, type 128 and press Enter.
4. Go to File -> Document Properties...
5. Change the `Width:` text field to 128 and press Enter.
6. Save the file.

Now we have to let `setup.cfg` know about the new files. Let’s also
provide an easy way to open the application from the console by just
typing `simplemdviewer`.

Update `simplemdviewer/setup.cfg` to:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/setup-2.cfg" highlight="ini" >}}

The last step is to tinker with the way we import modules.

Update `simplemdviewer/src/simplemdviewer_app.py` to:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/simplemdviewer_app-3.py" highlight="python" >}}

Create a `__main__.py` file into the `src/` directory. Now that there's a
module, this tells the build tools what's the main function, the entrypoint
for running the application.

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/__main__.py" highlight="python" >}}

## Calling the app

This last step will facilitate the execution of the package during development
and let us call the application by its name.

From inside the `simplemdviewer/` directory, install the app locally as a
module and try running it:

```bash
python3 -m pip install -e .
python3 -m simplemdviewer
```

If you have put the required files in the right places, running the application
as a module should work.

It’s time to generate the package for our program.

Make sure that the latest version of `build` is installed:

```bash
python3 -m pip install --upgrade build
```

Execute from inside the `simplemdviewer/` directory:

```bash
python3 -m build
```

As soon as the build completes, two archives will be created in the
`dist/` directory:

1. the `org.kde.simplemdviewer-0.1.tar.gz` source archive
2. the `org.kde.simplemdviewer-0.1-py3-none-any.whl` package ready for
distribution in places such as PyPI

Install the newly-created package into the virtual environment:

```bash
python3 -m pip install dist/org.kde.simplemdviewer-0.1.tar.gz
```

Run:

```bash
simplemdviewer
```

At this point we can tag and release the source code. Linux distributions will
package it and the application will be added to their software repositories.

Well done.
