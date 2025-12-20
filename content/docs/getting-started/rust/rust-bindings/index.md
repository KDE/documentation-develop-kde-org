---
title: Using Rust bindings for KDE Frameworks
weight: 4
group: bindings
description: >
    Extend your application with KDE libraries
---

KDE provides Rust bindings for some KDE libraries. The current list of Rust bindings can be seen in the [cxx-kde-frameworks](https://invent.kde.org/libraries/cxx-kde-frameworks) repository.

We will be modifying the existing tutorial example from [A full Rust + Kirigami application]({{< ref "rust-app" >}}). Since the code displayed here is only usable from Rust, this tutorial won't be applicable to [Using Rust together with C++]({{< ref rust-mixed >}}) as the code displayed there can simply use C++ KDE libraries directly.

{{< alert title="⚠️ Subject to changes" color="warning" >}}

The Qt Group has announced the development of [Qt Bridges](https://www.qt.io/qt-bridges), new technology for using Qt with other languages. Depending on what happens when this new tecnology is published, the KDE Frameworks bindings might undergo large changes.

{{< /alert >}}

## Changes to existing code

### Cargo.toml

To add the crate to the project, just add a new entry in the `[dependencies]` section of `Cargo.toml`:

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/Cargo.toml" highlight="toml" emphasize=14 >}}

Triggering a rebuild with either `cmake --build build/` or `cargo build --target-dir build/` should pull the new dependency automatically.

### src/main.rs

The KDE Frameworks bindings we will use are:

* [KCrash](https://api.kde.org/kcrash-index.html) to generate a Dr. Konqi bug report dialog whenever the application crashes
* [KCoreAddons](https://api.kde.org/kcoreaddons-index.html) for the project credits (and exposing them to QML)
* [KI18n](https://api.kde.org/ki18n-index.html) for translations

{{< alert title="💡 Reading the API" color="success" >}}

The API that is exposed to Rust follows the standard Rust naming scheme: [snake_case](https://en.wikipedia.org/wiki/Snake_case). This applies to class names and functions.

A function like `KAboutData::setApplicationData()` shown in the C++ API translates to `KAboutData::set_application_data()`.

{{< /alert >}}

All three of them will be used in the Rust entrypoint code, `main.rs`.

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/main.rs" highlight="rust" emphasize="1 3-5 12 13 23-35 39">}}

Add the necessary [use declarations](https://doc.rust-lang.org/stable/book/ch07-02-defining-modules-to-control-scope-and-privacy.html) to import the classes from the `cxx_kde_frameworks` crate, as well as [QByteArray](https://doc.qt.io/qt-6/qbytearray.html) from `cxx_qt_lib` which is needed for one of the functions: 

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/main.rs" highlight="rust" start=1 lines=7 emphasize="3-5 1" >}}

All it takes to initialize KCrash is a single line after the QApplication is created:

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/main.rs" highlight="rust" start=11 lines=2 emphasize="2" >}}

While KI18n requires two lines: one for setting the name of the application domain after the QApplication is created (required to identify which application the translation belongs to):

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/main.rs" highlight="rust" start=10 lines=4 emphasize=4 >}}

And the other to apply internationalization to the QML engine:

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/main.rs" highlight="rust" start=37 lines=7 emphasize=3 >}}

Lastly, we use the KAboutData constructor (translated to Rust using the [From trait](https://doc.rust-lang.org/std/convert/trait.From.html)) to define the metadata information of the application and set it:

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/main.rs" highlight="rust" start=23 lines=13 >}}

Note that the license enum is called License instead of KAboutLicense, as internally it is just a helper enum rather than the whole KAboutLicense class. The enum value names still match the [C++ API](https://api.kde.org/kaboutlicense.html#LicenseKey-enum).

The KI18n bindings expose common `i18n()` functions used for translatable text, such as [i18nc()](https://api.kde.org/klocalizedstring.html#i18nc) which is used for adding context to strings following KDE's [Programmer's Guide to Internationalization](https://invent.kde.org/frameworks/ki18n/-/blob/master/docs/programmers-guide.md).

### CMakeLists.txt

To test and visualize the result of using [KAboutData](https://api.kde.org/kaboutdata.html) in our code, we will add an additional dependency to the project: [Kirigami Addons](https://api.kde.org/kirigami-addons-index.html).

Make sure to add it to the root `CMakeLists.txt`:

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/CMakeLists.txt" highlight="cmake" emphasize=12 >}}

This makes the presence of the FormCard QML module required at compile time.

### src/qml/Main.qml

Kirigami Addons provides a FormCard component that can be used to generate a standard About Application page, as mentioned in [FormCard About Pages]({{< ref addons-about >}}). It can be added to the default [actions property](https://api.kde.org/qml-org-kde-kirigami-page.html#actions-prop) of a new [Kirigami.GlobalDrawer]({{< ref components-drawers >}}) inside the top level [Kirigami.ApplicationWindow](https://api.kde.org/qml-org-kde-kirigami-applicationwindow.html).

We can use [Qt.createComponent()](https://doc.qt.io/qt-6/qtqml-javascript-dynamicobjectcreation.html) to generate the page on the fly:

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/Main.qml" highlight="qml" emphasize="5 16-25" >}}

As simple as that.

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

## Our app so far

<details>
<summary>CMakeLists.txt</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/CMakeLists.txt" highlight="cmake" >}}

</details>

<details>
<summary>Cargo.toml</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/Cargo.toml" highlight="toml" >}}

</details>

<details>
<summary>build.rs</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/build.rs" highlight="rust" >}}

</details>

<details>
<summary>src/main.rs</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/main.rs" highlight="rust" >}}

</details>

<details>
<summary>src/mdconverter.rs</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/src/mdconverter.rs" highlight="rust" >}}

</details>

<details>
<summary>src/qml/Main.qml</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-bindings/Main.qml" highlight="qml" >}}

</details>

<details>
<summary>org.kde.simplemdviewer.desktop</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/org.kde.simplemdviewer.desktop" highlight="ini" >}}

</details>

<details>
<summary>org.kde.simplemdviewer.metainfo.xml</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/org.kde.simplemdviewer.metainfo.xml" highlight="xml" >}}

</details>
