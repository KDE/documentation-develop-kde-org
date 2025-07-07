---
title: A full Rust + Kirigami application
weight: 1
group: introduction
description: >
    Learn how to write an application with cxx-qt
---

## Prerequisites

For the purposes of this tutorial, we will create the application on Linux.

To bridge the connection between Qt's C++ API and our Rust code, we will be using [cxx-qt](https://kdab.github.io/cxx-qt/book/getting-started/index.html), which provides two way communication between the two.

You will need to install Rust, Cargo, CMake, extra-cmake-modules, QtQuick and Kirigami. All other software needed to build the project will be provided via Rust crates from [crates.io](https://crates.io) or directly from a git repository.

Upstream Rust [recommends](https://doc.rust-lang.org/cargo/getting-started/installation.html) using [rustup](https://rustup.rs/) to install Rust and Cargo:

```bash
curl https://sh.rustup.rs -sSf | sh
```

You may otherwise install them from your distribution repositories.

{{< installpackage
    opensuse="rust cargo cmake kf6-extra-cmake-modules kf6-kirigami-devel kf6-qqc2-desktop-style-devel qt6-declarative-devel qt6-wayland-devel flatpak-builder AppStream-compose"
    fedora="rust cargo cmake extra-cmake-modules kf6-kirigami-devel kf6-qqc2-desktop-style qt6-qtdeclarative-devel qt6-qtwayland-devel flatpak-builder appstream-compose"
    arch="rust cargo cmake extra-cmake-modules kirigami flatpak-builder qqc2-desktop-style appstream"
>}}

## Project Structure

The application will be a simple Markdown viewer called `simplemdviewer` and its executable will have the same name.

By the end of the tutorial, the project will look like this:

```tree
simplemdviewer/
├── README.md
├── CMakeLists.txt                 # To manage installing the project
├── Cargo.toml                     # To manage building the project
├── build.rs                       # To initialize cxx-qt
├── org.kde.simplemdviewer.desktop
├── org.kde.simplemdviewer.json
├── org.kde.simplemdviewer.svg
├── org.kde.simplemdviewer.metainfo.xml
└── src/
    ├── main.rs                    # The entrypoint to our application
    ├── mdconverter.rs             # The Markdown formatter
    └── qml/
        └── Main.qml               # Where the Kirigami window will be made
```


{{< alert title="💡 Tip" color="success" >}}

To quickly generate this folder structure, run:

```bash
cargo new simplemdviewer
mkdir -p simplemdviewer/src/qml/
```

{{< /alert >}}

## Setting up the project

The UI will be created in QML and the logic in Rust. Users will write some
Markdown text, press a button, and the formatted text will be shown below it.

Initially we will focus on the following files, do a test run, and then add the rest later:

```tree
simplemdviewer/
├── CMakeLists.txt
├── Cargo.toml
├── build.rs
└── src/
    ├── main.rs
    └── qml/
        └── Main.qml
```

### build.rs

We need to initialize `cxx-qt` before Cargo builds the project, hence we use a [build script build.rs](https://doc.rust-lang.org/cargo/reference/build-scripts.html) which serves this purpose.

Create a new `build.rs` file in the root directory of the project with the following contents:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer/build.rs" highlight="rust" >}}

### src/main.rs

Create a new directory `src/` and add a new
`main.rs` file in this directory:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer/src/main.rs" highlight="rust" >}}

The first part that is marked with the `#[cxx_qt::bridge]` Rust macro creates a dummy QObject out of a dummy Rust struct. This is needed as cxx-qt needs to find at least one QObject exposed to Rust to work. This should no longer be necessary in the future once https://github.com/KDAB/cxx-qt/issues/1137 is addressed. When we start [Adding Markdown functionality]({{< ref "#adding-markdown" >}}) later on, we will use a proper QObject.

We then created a
[QGuiApplication](https://doc.qt.io/qt-6/qguiapplication.html)
object that initializes the application and contains the main event loop. The
[QQmlApplicationEngine](https://doc.qt.io/qt-6/qqmlapplicationengine.html)
object loads the `Main.qml` file.

Then comes the part that actually creates the application window:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/main.rs" highlight="rust" start=31 lines=4 >}}

The long URL `qrc:/qt/qml/org/kde/simplemdviewer/src/qml/Main.qml` corresponds to the `Main.qml` file in the [Qt Resource System](https://doc.qt.io/qt-6/resources.html), and it follows this scheme: `<resource_prefix><import_URI><QML_dir><file>`.

In other words: the default resource prefix `qrc:/qt/qml/` + the import URI `org/kde/simplemdviewer` (set in `build.rs`, separated by slashes instead of dots) + the QML dir `src/qml/` + the QML file `Main.qml`.


### src/qml/Main.qml

Create a new `src/qml/` directory and add a `Main.qml` to it:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer/src/qml/Main.qml" highlight="qml" >}}

This is the file that will manage how the window will look like. For more details about Kirigami, see our [Kirigami Tutorial](/docs/getting-started/kirigami).

### Cargo.toml

Create a new `Cargo.toml` file in the root directory of your project:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer/Cargo.toml" highlight="toml" >}}

This file is what is traditionally used for building Rust applications, and indeed with only the four files we've written it's already possible to build the project with Cargo:

```bash
cargo build
cargo run
```

The project will be built inside a directory called `target/`, and when running `cargo run` Cargo will execute the resulting binary in that directory.

You may also specify a custom build directory with the `--target-dir` flag. This will be important in the `CMakeLists.txt` file.

```
cargo build --target-dir build/
cargo run --target-dir build/
```

### CMakeLists.txt

Cargo lacks the ability to install more than just executables, which is insufficient for desktop applications. We need to install:

* an application icon
* a [Desktop Entry file](https://specifications.freedesktop.org/desktop-entry-spec/latest/) to have a menu entry and show the application icon in our window on Wayland
* a [Metainfo file](https://www.freedesktop.org/software/appstream/docs/chap-Metadata.html) to show the application on Linux software stores

More complex and mature projects might also include manpages and manuals, KConfig configuration files, and D-Bus interfaces and services for example.

To achieve this, we can wrap Cargo with CMake and have it manage the installation step for us. For now we will focus only on the executable, and add the other files in the section [Adding metadata]({{< ref "#metadata" >}}).

Create a new `CMakeLists.txt` file in the root directory of the project:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer/CMakeLists.txt" highlight="cmake" >}}

The first thing we do is add KDE's [Extra CMake Modules (ECM)](https://api.kde.org/ecm/manual/ecm.7.html) to our project so we can use [ecm_find_qml_module](https://api.kde.org/ecm/module/ECMFindQmlModule.html) to check that Kirigami is installed when trying to build the application, and if it's not, fail immediately. Another useful ECM feature is [ECMUninstallTarget](https://api.kde.org/ecm/module/ECMUninstallTarget.html), which allows to easily uninstall the application with CMake if desired.

We also use CMake's [find_package()](https://cmake.org/cmake/help/latest/command/find_package.html) to make sure we have [qqc2-desktop-style](https://invent.kde.org/frameworks/qqc2-desktop-style), KDE's QML style for the desktop.

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer/CMakeLists.txt" highlight="cmake" start=5 lines=8 >}}

We create a target that will simply execute Cargo when run, and mark it with `ALL` so it builds by default.

After this, we simply install the `simplemdviewer` executable generated by Cargo in the binary directory and install it to the `BINDIR`, which is usually `/usr/bin`, `/usr/local/bin` or `~/.local/bin`.

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer/CMakeLists.txt" highlight="cmake" start=14 lines=9 emphasize="1 3 7" >}}

Note that the name `simplemdviewer` set in lines 14 and 20 must match the application's executable name built by Cargo, otherwise the project will fail to install.

In line 16 we use `--target-dir` to make Cargo build the executable inside CMake's binary directory (typically `build/`). This way, if the user specifies an out-of-tree build directory in their CMake build command, Cargo will use the directory specified by the user instead of the `target/` directory:

```bash
cmake -B build/
cmake --build build/
```

For more information about CMake, targets, and the binary directory, see [Building KDE software manually]({{< ref "cmake-build" >}}).

## First test run

We have just created a simple QML-Kirigami-Rust application. Run it:

```bash
cmake -B build --install-prefix ~/.local
cmake --build build/
./build/debug/simplemdviewer
```

You can also try running it with Cargo:

```bash
cargo build --target-dir build/ # Optional; cargo run will also build the project!
cargo run --target-dir build/
```

At the moment we have not used any interesting Rust stuff. In reality, the application can also run as a standalone QML app:

```bash
QT_QUICK_CONTROLS_STYLE=org.kde.desktop qml6 --apptype widget src/qml/Main.qml
```

{{< alert title="About the qml binary" color="info" >}}

Some distributions might name the `qml` binary from Qt5 or Qt6 differently: for example, openSUSE and Arch have `qml`, `qt5-qml`, and `qml6`, while Fedora has `qml`, `qml-qt5`, and `qml-qt6`.

Use the explicit Qt6 variant to be sure that your app runs with Qt6.

{{< /alert >}}

It does not format anything; if we click on "Format" it just spits the
unformatted text into a text element. It also lacks a window icon.

{{<figure src="simplemdviewer1.webp" class="text-center" alt="A screenshot of the application showing a text area with two buttons Format and Clear beneath it. The text area has the text \"# Hello\", yet the text below the buttons shows the same text, unformatted." >}}

## Adding Markdown functionality {#adding-markdown}

Let’s add some Rust logic: a simple Markdown converter in a
Rust [QObject](https://doc.qt.io/qt-6/qobject.html)
derivative struct.

### src/mdconverter.rs

Create a new `mdconverter.rs` file inside `src/`:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/mdconverter.rs" highlight="rust" emphasize="5 6 14 15 25 26" >}}

The highlighted lines show the same essential contents that we added to our initial dummy QObject in `main.rs`, but this time using an actual QObject the cxx-qt way. Let's take a look bit by bit.

We have a [struct](https://doc.rust-lang.org/book/ch05-01-defining-structs.html) that has the [Default trait](https://doc.rust-lang.org/std/default/trait.Default.html), so all its members are default initialized:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/mdconverter.rs" highlight="rust" start=25 lines=4 >}}

We then create a module inside the new `mdconverter` module that we call `ffi` (which stands for Foreign Function Interface) because it will deal with things coming from C++ or C++ code that is generated from our Rust code. The name does not need to be `ffi`. The module gets marked with the [#[cxx-qt::bridge]](https://kdab.github.io/cxx-qt/book/bridge/index.html) macro first, and we import [QString](https://doc.qt.io/qt-6/qstring.html) which comes from the Qt C++ side so it's available on the Rust side:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/mdconverter.rs" highlight="rust" start=5 lines=7 >}}

We use the `type` keyword to create an alias so that we don't need to type the `cxx_qt_lib::QString` name all the time.

After that, we write the aforementioned Rust code that will generate a C++ Qt QObject:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/mdconverter.rs" highlight="rust" start=13 lines=10 >}}

The [#[auto_cxx_name] cxx-qt macro](https://kdab.github.io/cxx-qt/book/bridge/attributes.html#automatic-case-conversion) is a convenience macro that replaces names from the Rust snake_case convention (`md_format()`) to the C++ Qt camelCase convention (`mdFormat()`).

We then use [extern "RustQt"](https://kdab.github.io/cxx-qt/book/bridge/extern_rustqt.html) so we can define our new QObject. The Rust code in it generates C++ code that lets us expose it to QML. In this case, the type `MdConverter` will be exposed.

We use the [#[qml_element]](https://kdab.github.io/cxx-qt/book/bridge/extern_rustqt.html?highlight=qml_element#qml-attributes) attribute to mark the new QObject as something that contains code exposed to QML, analogous to C++ [QML_ELEMENT](https://doc.qt.io/qt-6/qtqml-cppintegration-definetypes.html).

The [#[qproperty()]](https://kdab.github.io/cxx-qt/book/bridge/extern_rustqt.html?highlight=qml_element#properties) attribute specifies the exact types that will be exposed to QML, analogous to the C++ [Q_PROPERTY](https://doc.qt.io/qt-6/properties.html). In this case, we want to export `source_text` as the `MdConverter.sourceText` QML property, which will be used in the Rust implementation.

We use [#[qinvokable]](https://kdab.github.io/cxx-qt/book/bridge/extern_rustqt.html?highlight=qinvokable#invokables) to expose the function `md_format()` to QML.

Lastly, we implement the function that actually formats text as Markdown:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/mdconverter.rs" highlight="rust" start=30 lines=4 >}}

We use the [markdown crate](https://docs.rs/markdown/latest/markdown/) for this. This function returns a QString made of the `MdConverter.sourceText` property converted from Markdown to HTML. Non-editable Qt text components parse HTML in strings by default, so the QString will be shown formatted in our application without further changes.

Now the `mdconverter` module exposes everything we need to the QML side:

* the `MdConverter` QML type
* the `sourceText` QML property
* the `mdFormat()` QML method

### src/main.rs

Two modifications are needed in `src/main.rs`: removing the dummy QObject and importing our new `mdconverter` module:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/main.rs" highlight="rust" emphasize="1-10 16"  >}}

### build.rs

Now that the module is finished, replace `src/main.rs` with the new `src/mdconverter.rs` file in `build.rs`:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/build.rs" highlight="rust" emphasize="8" >}}

### src/qml/Main.qml

Since we are going to actually use code that was exposed to QML, we need to actually import it this time. The module from the file `mdconverter.rs` is made available via the QML module from `build.rs` under the `org.kde.simplemdviewer` import URI.

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/qml/Main.qml" highlight="qml" emphasize="5 23-27 50"  >}}

Then the new QML type `MdConverter` that was exposed to QML needs to be instantiated:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/qml/Main.qml" highlight="qml" emphasize="5 23-27 50 66"  >}}

The contents of the `sourceText` property is populated with the contents of the `sourceArea.text`, which is then formatted when clicking the "Format" button and passed to the `formattedText`.

## Adding metadata {#metadata}

The finishing touches need to be done for the application to have a nice window icon and look good in software stores.

### README.md

Create a simple README.md:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/README.md" highlight="markdown" >}}

### org.kde.simplemdviewer.svg

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

### org.kde.simplemdviewer.desktop

The primary purpose of [Desktop Entry files](https://specifications.freedesktop.org/desktop-entry-spec/latest/) is to show your app on the application launcher on Linux. Another reason to have them is to have window icons on Wayland, as they are required to tell the compositor "this window goes with this icon".

It must follow a [reverse-DNS naming scheme](https://en.wikipedia.org/wiki/Reverse_domain_name_notation) followed by the `.desktop` extension such as `org.kde.simplemdviewer.desktop`:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/org.kde.simplemdviewer.desktop" highlight="ini" emphasize="4" >}}

Note that the icon name should not include its file extension.

### org.kde.simplemdviewer.metainfo.xml

To show your application on software stores like Plasma Discover, GNOME Software or Flathub, your application will need to provide an [AppStream metainfo file](https://www.freedesktop.org/software/appstream/docs/chap-Metadata.html):

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/org.kde.simplemdviewer.metainfo.xml" highlight="xml" >}}

### CMakeLists.txt

Now that we have our final metadata files, we can tell CMake where to install them:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/CMakeLists.txt" highlight="xml" emphasize="24-26" >}}

When a distribution installs these files, they will go to `/usr/share/applications`, `/usr/share/metainfo` and `/usr/share/icons/hicolor/scalable/apps`, respectively. We will be installing them in userspace, so `~/.local/share/applications`, `~/.local/share/metainfo` and `~/.local/share/icons/hicolor/scalable/apps` instead.

To learn more about where files need to be installed, see [Building KDE software manually: The install step]({{< ref "cmake-build#install" >}}).

## Final test run

At last, build, install and run your new application:

```bash
cmake -B build/ --install-prefix ~/.local
cmake --build build/
cmake --install build/
simplemdviewer
```

You can also try building it with Cargo:

```bash
cargo build --target-dir build/
cargo run --target-dir build/
```

You should now have a new menu entry named "Simple Markdown Viewer in Rust and Kirigami".

{{< figure src="simplemdviewer-menu.webp" class="text-center" alt="A screenshot of the Plasma Kickoff menu showing the menu entry." >}}

Play with adding some Markdown text:

{{<figure src="simplemdviewer2.webp" class="text-center" alt="A screenshot of the application showing the custom window icon and the Free Software foundation definition of the four freedoms. Beneath it, the text is fully formatted in Markdown." >}}

Hooray!

## Our app so far

<details>
<summary>CMakeLists.txt</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/CMakeLists.txt" highlight="cmake" >}}

</details>

<details>
<summary>Cargo.toml</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/Cargo.toml" highlight="toml" >}}

</details>

<details>
<summary>build.rs</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/build.rs" highlight="rust" >}}

</details>

<details>
<summary>src/main.rs</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/main.rs" highlight="rust" >}}

</details>

<details>
<summary>src/mdconverter.rs</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/mdconverter.rs" highlight="rust" >}}

</details>

<details>
<summary>src/qml/Main.qml</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/qml/Main.qml" highlight="qml" >}}

</details>

<details>
<summary>org.kde.simplemdviewer.desktop</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/org.kde.simplemdviewer.desktop" highlight="ini" >}}

</details>

<details>
<summary>org.kde.simplemdviewer.metainfo.xml</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/org.kde.simplemdviewer.metainfo.xml" highlight="xml" >}}

</details>
