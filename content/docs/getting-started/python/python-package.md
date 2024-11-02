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

Currently, the project can only be run as a script directly, that is, by running the files directly with `python3 /path/to/simplemdviewer_app.py`. This is not a convenient way to run a desktop application.

The goal in this page is to make the project available as a console script and as a module:

* You'll know it is a console script when you are able to run it with `simplemdviewer`
* You'll know it is a module when you are able to run it with `python3 -m simplemdviewer`

If you'd like to learn more about Python packaging, you'll be interested in the
[Python Packaging User Guide](https://packaging.python.org/en/latest/).

## General structure

Let's recapitulate what the file structure of the project should be:

```tree
simplemdviewer
├── README.md
├── LICENSE.txt
├── MANIFEST.in                # To add our QML file to the Python module
├── pyproject.toml             # The main file to manage the project
├── org.kde.simplemdviewer.desktop
├── org.kde.simplemdviewer.json
├── org.kde.simplemdviewer.svg
├── org.kde.simplemdviewer.metainfo.xml
└── src/
    ├── __init__.py            # To import the src/ directory as a package
    ├── __main__.py            # To signal simplemdviewer_app as the entrypoint
    ├── simplemdviewer_app.py
    ├── md_converter.py
    └── qml/
        └── main.qml
```

Create a `simplemdviewer/pyproject.toml`:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/pyproject.toml" highlight="toml" emphasize="1 5 23 35" >}}

Don't worry about the details for now. We will revisit each part as necessary.

The following four sections of the pyproject.toml are fairly straightforward:

* `[build-system]` tells Python to fetch and use setuptools to build the project
* `[project]` contains the general metadata for the project
* `[project.readme]` specifies a default README file for the project in Markdown
* `[tool.setuptools.data-files]` mentions where setuptools should install additional data files that are not typically present in a Python package

{{< alert title="Note" color="info" >}}

Previously, this tutorial used a combination of `setup.py` to initialize setuptools,
`setup.cfg` to manage metadata and package information, and `pyproject.toml`
to specify dependencies. However, [PEP 621](https://peps.python.org/pep-0621/)
has defined `pyproject.toml` as the main way to specify a project's metadata,
and setuptools has transitioned to
[using pyproject.toml as a declarative way to define package information](https://setuptools.pypa.io/en/latest/userguide/quickstart.html#transitioning-from-setup-py-to-declarative-config).

It is no longer necessary to initialize setuptools with a `setup.py` script,
and all metadata, package information, and dependencies are listed
in the `pyproject.toml` instead.

{{< /alert >}}

## App metadata

Let's start with the metadata first so we can get it out of the way, namely the ones listed in the sections `[project.readme]` and `[tool.setuptools.data-files]`.

Create a `simplemdviewer/README.md`:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/README.txt" highlight="markdown" >}}

Another important piece is the license of our project. Create a
`simplemdviewer/LICENSE.txt` and add the text of the
[license](https://www.gnu.org/licenses/gpl-3.0.txt) of our project.

```bash
wget https://www.gnu.org/licenses/gpl-3.0.txt --output-document LICENSE.txt
```

Create a `simplemdviewer/MANIFEST.in` file with the following contents:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/MANIFEST.in" highlight="qml" >}}

This file is simply a declaration of additional source code files that should be present in the package when the application runs.

Some last pieces and we are ready to start changing the code. We are going to add:

1. The [Appstream](https://www.freedesktop.org/wiki/Distributions/AppStream/)
metadata used to show the app in software stores.
2. A [Desktop Entry](https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html)
file to add the application to the application launcher.
3. An application icon.

Create a new `simplemdviewer/org.kde.simplemdviewer.desktop`. This file is
used to show our Markdown Viewer in application menus/launchers.

<!-- Note for translators: please do not translate the org.kde.simplemdviewer.desktop file. -->

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/org.kde.simplemdviewer.desktop" highlight="bash" >}}

Add a new `simplemdviewer/org.kde.simplemdviewer.metainfo.xml`. This file is
used to show the application in app stores.

<!-- Note for translators: please do not translate the org.kde.simplemdviewer.metainfo.xml file. -->

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/org.kde.simplemdviewer.metainfo.xml" highlight="xml" >}}

For this tutorial the well known Markdown icon is okay.

Get the
[Markdown](https://en.wikipedia.org/wiki/Markdown#/media/File:Markdown-mark.svg)
icon and save it as `simplemdviewer/org.kde.simplemdviewer.svg`:

```
wget https://upload.wikimedia.org/wikipedia/commons/4/48/Markdown-mark.svg --output-document org.kde.simplemdviewer.svg
```

We need the icon to be perfectly squared, which can be accomplished with
[Inkscape](https://inkscape.org):

1. Open `org.kde.simplemdviewer.svg` in Inkscape.
2. Type Ctrl+a to select everything.
3. On the top `W:` text field, type 128 and press Enter.
4. Go to File -> Document Properties...
5. Change the `Width:` text field to 128 and press Enter.
6. Save the file.

## Code changes

Before creating a console script or module, we first need to turn our existing code into a package.

Create an empty `simplemdviewer/src/__init__.py` file.
This file just needs to be present in order to import a directory as a package.

```bash
touch __init__.py
```

Usually, Python packages keep their package source code directly in the root folder. Since we are using a custom package directory, namely `src/`, we pass it as the correct `package-dir` for our `simplemdviewer` application in the `pyproject.toml`:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/pyproject.toml" highlight="toml" start=30 lines=4 emphasize="2-3" >}}

Here, the package name is `simplemdviewer`, and its source code is located in `simplemdviewer/src/` instead of the root folder. Now that we have a package name, we can use that for the way we import modules in our code.

Update `simplemdviewer/src/simplemdviewer_app.py` to:

{{< tabset-qt >}}
{{< tab-qt tabName="PySide6" >}}
{{< readfile file="/content/docs/getting-started/python/pyside-app/src/simplemdviewer_app-3.py" highlight="python" emphasize="9-10 34-35" >}}
{{< /tab-qt >}}
{{< tab-qt tabName="PyQt6" >}}
{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/simplemdviewer_app-3.py" highlight="python" emphasize="9-10 36-37" >}}
{{< /tab-qt >}}
{{< /tabset-qt >}}

Create a `__main__.py` file in the `simplemdviewer/src/` directory:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/__main__.py" highlight="python" >}}

This simply adds the contents of the current directory (`src/`) and imports it as a module named `simplemdviewer_app`, then immediately run the `main()` function of the application.

Make sure that you have a project script in your `pyproject.toml`:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/pyproject.toml" highlight="toml" start=27 lines=2 emphasize="2" >}}

Now the application should run as an executable package and as a module.

## Running directly, as a module, and as a console script

When you run the script directly with `python3 src/simplemdviewer_app.py`, under the hood you are first running `__main__`. If the same script were imported instead of run, it would be running `simplemdviewer_app`, the name of the module. The `if` condition is there so `main()` will only run when the script is run, not every time it is imported by another script:

{{< readfile file="/content/docs/getting-started/python/pyside-app/src/simplemdviewer_app-3.py" highlight="python" start=34 lines=2 >}}

That's it for running scripts directly. On top of that, we use setuptools to specify the *package*:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/pyproject.toml" highlight="toml" start=30 lines=3 >}}

We have specified a package called `simplemdviewer` in line 31 whose source code is found in `simplemdviewer/src/` in line 32. This is necessary because we don't want to call the application as `simplemdviewer_app` every time for either module or console script, we want the friendlier name `simplemdviewer`.

Now, to allow the application to run as a module like in `python3 -m simplemdviewer`, all we need to do is have a `__main__.py` to the same folder where the code is:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/__main__.py" highlight="python" emphasize="3" >}}

When attempting to run the package `simplemdviewer` as a module, setuptools will simply look for a `__main__.py`, which in turn points to the `main()` function in our `simplemdviewer_app.py`:

{{< readfile file="/content/docs/getting-started/python/pyside-app/src/simplemdviewer_app-3.py" highlight="python" start=12 lines=4 emphasize="1" >}}

Under the hood of the module, `__name__` is actually set to `simplemdviewer_app` unlike with when running the script directly, but `main()` is executed anyway.

{{< alert title="Note" color="info" >}}

`setuptools` is not necessarily involved in the process of running a script directly or running a module as a script. However, in the case of modules, it specifies the package, which in turn matters for the module name.

{{< /alert >}}

Now, to create a console script:

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/pyproject.toml" highlight="toml" start=27 lines=2 >}}

In line 28, we specify a *project script*, namely the entrypoint to run the application. This is functionality provided directly by `setuptools`. In this case it's a console script because it can run on a terminal; a GUI script would always run without a terminal, but this only matters on Windows. A project script is simply a wrapper that setuptools creates on top of the application so it can be run easily like an executable.

We want that, when attempting to run the command `simplemdviewer` in the terminal, setuptools searches inside the `simplemdviewer` package for the module `simplemdviewer_app`, and runs the function `main()` directly:

{{< readfile file="/content/docs/getting-started/python/pyside-app/src/simplemdviewer_app-3.py" highlight="python" start=12 lines=4 emphasize="1" >}}

Doing things this way, we bypass the `__main__` check entirely.

This is how the console script is created.

In other words:

| Method         |  | Tool      |  |               |  |        | Runs with |
|----------------|--|-----------|--|---------------|--|--------|-----------|
| run directly   |->|Python     |->|`__main__`     |->|`main()`| python3 simplemdviewer_app.py |
| module         |->|Setuptools |->|`__main__.py`  |->|`main()`| python3 -m simplemdviewer |
| console script |->|Setuptools |->|project script |->|`main()`| simplemdviewer |

## Running the app

From inside the `simplemdviewer/` directory, we can install it in development mode and then run it:

```bash
python3 -m pip install --editable .
# As a module
python3 -m simplemdviewer
# As a console script
simplemdviewer
```

If you have put the required files in the right places, running the application
as a module and as a console script should work.

Now that we know it works, let's generate the package for our program.

Make sure that the latest version of `build` is installed:

```bash
python3 -m pip install --upgrade build
```

From inside the `simplemdviewer/` directory, run:

```bash
python3 -m build
```

As soon as the build completes, two archives will be created in the
`dist/` directory:

1. The `org.kde.simplemdviewer-0.1.tar.gz` source archive
2. The `org.kde.simplemdviewer-0.1-py3-none-any.whl` package ready for
distribution in places such as PyPI

To test the application properly, we can try installing it in a clean virtual environment that has PySide/PyQt:

```bash
deactivate
python3 -m venv --system-site-packages clean-env/
source clean-env/bin/activate
python3 -m pip install dist/org.kde.simplemdviewer-0.1-py3-none-any.whl
```

Run:

```bash
# As a module
python3 -m simplemdviewer
# As a console script
simplemdviewer
```

At this point we can tag and release the source code. Linux distributions will
package it and the application will be added to their software repositories.

Well done.
