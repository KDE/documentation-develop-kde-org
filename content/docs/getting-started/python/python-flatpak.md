---
title: Publishing your Python app as a Flatpak
weight: 3
group: python
description: >
    Ship your app easily to users.
---

## Creating a Flatpak

We can also take care of distributing our PyQt application. Although the
[Python Package Index (PyPI)](https://pypi.org/) is probably the standard way to distribute a
Python package, [Flatpak](https://flatpak.org/) should be more user friendly
for Linux users than using command line tools such as `pip`.

Flatpaks are built locally using `flatpak-builder`. The tool checks out the
source code and any of its custom dependencies, then builds it against a
runtime (a collection of libraries shared between flatpaks). Since we already
took care of the source code, all we need is to write a single file, the
flatpak manifest, which describes everything needed to build the package.

Create a new flatpak manifest file `simplemdviewer/org.kde.simplemdviewer.json`:

{{< tabset >}}

{{< tab tabName="PySide6" >}}

{{< readfile file="/content/docs/getting-started/python/pyside-app/src/org.kde.simplemdviewer.json" highlight="json" emphasize="3-7 17 22 27" >}}

{{< /tab >}}

{{< tab tabName="PyQt6" >}}

{{< readfile file="/content/docs/getting-started/python/pyqt-app/src/org.kde.simplemdviewer.json" highlight="json" emphasize="3-7 17 22 27" >}}

{{< /tab >}}

{{< /tabset >}}

This file reads that we use the `markdown` module and the build info
is provided by the `python3-markdown.json` manifest file. We are going
to create this manifest automatically using `flatpak-pip-generator`.

Download
[flatpak-pip-generator](https://raw.githubusercontent.com/flatpak/flatpak-builder-tools/master/pip/flatpak-pip-generator),
and save it into the `simplemdviewer/env/bin/` directory:

```bash
wget https://raw.githubusercontent.com/flatpak/flatpak-builder-tools/master/pip/flatpak-pip-generator --directory-prefix env/bin
```

The generator has a single dependency to run, `requirements-parser`. After
installing it in the virtual environment, the tool can be run:

```bash
python3 -m pip install requirements-parser
python3 env/bin/flatpak-pip-generator markdown
```

You should see a new `python3-markdown.json` inside `simplemdviewer/` now.

We are using the
[KDE Runtime](https://docs.flatpak.org/en/latest/available-runtimes.html#kde),
which provides Qt dependencies like QtQuick
and KDE frameworks like Kirigami, so you will need the Software Development Kit
(Sdk) runtime to build the app locally, and the Platform runtime to run it.
More than that, the KDE Runtime is based on the general
[Freedesktop Runtime](https://docs.flatpak.org/en/latest/available-runtimes.html#freedesktop),
which provides Python. You can read more about runtimes in the
[Flatpak Runtime Documentation](https://docs.flatpak.org/en/latest/available-runtimes.html).

Install `org.kde.Sdk` and `org.kde.Platform`, version 6.7, from Flathub:

```bash
flatpak install org.kde.Platform/x86_64/6.7 org.kde.Sdk/x86_64/6.7
```

For a PyQt Flatpak application, we are using the
[PyQt Baseapp](https://github.com/flathub/com.riverbankcomputing.PyQt.BaseApp),
which contains an already built and ready-to-use PyQt we can quickly add on
top of the KDE Runtime, so we need to install it as well. Alternatively, you can use the
[PySide Baseapp](https://github.com/flathub/io.qt.PySide.BaseApp),
which provides a similar ready-to-use PySide6 environment.

{{< tabset >}}

{{< tab tabName="PySide6" >}}

```bash
flatpak install io.qt.PySide.BaseApp/x86-64/6.7
```

{{< /tab >}}

{{< tab tabName="PyQt6" >}}

```bash
flatpak install com.riverbankcomputing.PyQt.BaseApp/x86-64/6.7
```

{{< /tab >}}

{{< /tabset >}}

To attempt a first build of the flatpak, run:

```bash
flatpak-builder --force-clean flatpak-build-dir org.kde.simplemdviewer.json
```

{{< alert title="Tip" color="success" >}}
You can add the flag `--install-deps-from flathub` to flatpak-builder to
make it download the Sdk, Platform and Baseapp for you instead of installing
them manually.

If you installed Flathub as a user repository, you will need to add the `--user`
flag to install the runtime. Otherwise you might see the error "Flatpak system
operation Deploy not allowed for user".

```bash
flatpak-builder --user --force-clean --install-deps-from flathub flatpak-build-dir org.kde.simplemdviewer.json
```

{{< /alert >}}

Test the flatpak build:

```bash
flatpak-builder --run flatpak-build-dir org.kde.simplemdviewer.json simplemdviewer
```

Build a distributable nightly flatpak bundle:

```bash
flatpak-builder --repo simplemdviewer-master --force-clean --ccache flatpak-build-dir org.kde.simplemdviewer.json
flatpak build-bundle simplemdviewer-master simplemdviewer.flatpak org.kde.simplemdviewer
```

Now we can either distribute the `simplemdviewer.flatpak` directly to the
users, or submit the application to a flatpak repository, like the most popular
repository, [Flathub](https://flathub.org/).
See the
[App Submission Guidelines](https://github.com/flathub/flathub/wiki/App-Submission).

Other improvements you can make to your application:

- Signing the source archive with a
[detached signature](https://www.gnupg.org/gph/en/manual/x135.html).
- Providing copyright and licensing information for each file with
[REUSE](https://community.kde.org/Guidelines_and_HOWTOs/Licensing).
- Learn more about building flatpak apps with our
[Flatpak Tutorial]({{< ref "flatpak" >}}) and the
[official documentation](https://docs.flatpak.org/en/latest/index.html).
- Consider making it an official [KDE Application]({{< ref "add-project" >}}),
building [Flatpak nightlies using KDE infrastructure]({{< ref "docs/packaging/flatpak/publishing" >}}).
- Follow the
[Flathub Quality Guidelines](https://docs.flathub.org/docs/for-app-authors/appdata-guidelines/quality-guidelines)
to refine the presentation of your application on Flathub.

Happy hacking.
