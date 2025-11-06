---
title: Using Rust together with C++
weight: 3
group: introduction
description: >
    Take advantage of both worlds
---

The initial Rust tutorial pages focus on creating an application that uses only Rust, but existing KDE applications will rather use Rust to extend their current C++ codebase.

This is possible by using C++ as the entrypoint for the application and using a custom Rust crate as a library that gets linked to it via cxx-qt CMake integration. This integration is internally provided by [Corrosion](https://github.com/corrosion-rs/corrosion).

As a result, instead of having a simple CMake wrapper on top of Cargo, we will rely on some cxx-qt facilities to generate the library crate.

This tutorial can be skipped if you don't plan on making a project that uses both Rust and C++. It also consists of a slightly modified version of [upstream cxx-qt Building with CMake](https://kdab.github.io/cxx-qt/book/getting-started/5-cmake-integration.html).

## Project structure

We will be modifying the existing tutorial example from [A full Rust + Kirigami application]({{< ref "rust-app" >}}). The resulting project structure will look like this:

```tree
simplemdviewer/
├── README.md
├── CMakeLists.txt -------------------- # Modified
├── Cargo.toml     -------------------- # Modified
├── build.rs
├── org.kde.simplemdviewer.desktop
├── org.kde.simplemdviewer.json
├── org.kde.simplemdviewer.svg
├── org.kde.simplemdviewer.metainfo.xml
└── src/
    ├── main.cpp   -------------------- # New (replaces main.rs)
    ├── lib.rs     -------------------- # New
    ├── mdconverter.rs
    └── qml/
        └── Main.qml
```

## Changes to existing code

### Cargo.toml

When using this integration, the originally Rust only code will turn into a separate library that can be linked from C++; this means that a separate CMake target will be created for the crate.

If the crate is named "simplemdviewer", then we can't use "simplemdviewer" for the C++ executable. Therefore, we need a slight modification to the application name in `Cargo.toml`:

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/Cargo.toml" highlight="toml" lines=7 emphasize="2 8 9" >}}

The crate, originally a Rust executable, now must become a static library:

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/Cargo.toml" highlight="toml" emphasize="8 9" >}}

### src/main.rs -> src/lib.rs

As the Rust code no longer functions as an executable, the entrypoint can no longer be `main.rs`, so we delete it.

```bash
rm src/main.rs
```

Instead we want to create a `lib.rs` file whose purpose is purely to import other Rust modules. This `lib.rs` functions as the entrypoint for the library and simply exposes any modules that might be available. We want to expose it to C++, so it must be a `pub` module.

You can read more about this in [Rust Book: Defining Modules to Control Scope and Privacy](https://doc.rust-lang.org/book/ch07-02-defining-modules-to-control-scope-and-privacy.html#defining-modules-to-control-scope-and-privacy).

Create `src/lib.rs` with the following contents:

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/src/lib.rs" highlight="rust" >}}

This will expose the code from `mdconverter.rs` automatically.

Functionally, this is the same as the following ***if*** we didn't have a separate `mdconverter.rs` file:

```rust
pub mod mdconverter {
    // The rest of the code from mdconverter.rs here
}
```

The `src/mdconverter.rs` file is what will expose things to C++. It requires no modifications.

### src/main.cpp

The new entrypoint for the application will be a C++ executable, so we need to create a `main.cpp` file. For our purposes, we can use a standard C++ file for loading QML that is analogous to what we did with the [original main.rs]({{< ref "rust-app#our-app-so-far" >}}) file:

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/src/main.cpp" highlight="cpp" >}}

### CMakeLists.txt

The CMake code will need major modifications to use CxxQt instead of our previous custom Cargo wrapper.

First, since the entrypoint for the application is C++, we need to find the C++ Qt libraries and link them so `main.cpp` compiles:

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/CMakeLists.txt" highlight="cmake" lines=21 emphasize="13-21" >}}

We will no longer need the original Cargo wrapper code, so we can safely remove it:

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/CMakeLists.txt" start=52 lines=12 highlight="cmake" >}}

We need to add CxxQt to the project. We can use CMake's built-in [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html) functionality to download it from the repository and make it available at configure time:

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/CMakeLists.txt" highlight="cmake" start=23 lines=11 >}}

And then we import the Rust crate into the project using the manifest path (`Cargo.toml`) and the package name `simplemdviewer_rs`. It **must** link to the same Qt6 libraries specified earlier, otherwise this will result in an ABI incompatibility.

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/CMakeLists.txt" highlight="cmake" start=35 lines=12 >}}

After having imported the library crate, we can import the QML module exposed in the Rust code. Its first argument will be the name of the new linking target; URI **must** match the URI in `build.rs`; and SOURCE_CRATE **must** match the package name in `Cargo.toml`.

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/CMakeLists.txt" highlight="cmake" start=47 lines=4 >}}

We now have a CMake library target that points to Rust code called `simplemdviewer_rs_qml_module`. The name can be anything, like `simplemdviewer_rs_plugin` for example.

We can now create the C++ entrypoint executable target, and then link to the newly created QML module target (as well as the necessary Qt6 libraries for C++):

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/CMakeLists.txt" highlight="cmake" start=64 lines=10 >}}

## Final test run

At last, build, install and run your new application:

```bash
cmake -B build/ --install-prefix ~/.local
cmake --build build/
cmake --install build/
simplemdviewer
```

## Our app so far

<details>
<summary>CMakeLists.txt</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/CMakeLists.txt" highlight="cmake" >}}

</details>

<details>
<summary>Cargo.toml</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/Cargo.toml" highlight="toml" >}}

</details>

<details>
<summary>build.rs</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/build.rs" highlight="rust" >}}

</details>

<details>
<summary>src/lib.rs</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/src/lib.rs" highlight="rust" >}}

</details>

<details>
<summary>src/main.cpp</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/src/main.cpp" highlight="cpp" >}}

</details>

<details>
<summary>src/mdconverter.rs</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/src/mdconverter.rs" highlight="rust" >}}

</details>

<details>
<summary>src/qml/Main.qml</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/src/qml/Main.qml" highlight="qml" >}}

</details>

<details>
<summary>org.kde.simplemdviewer.desktop</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/org.kde.simplemdviewer.desktop" highlight="ini" >}}

</details>

<details>
<summary>org.kde.simplemdviewer.metainfo.xml</summary>

{{< readfile file="/content/docs/getting-started/rust/rust-mixed/simplemdviewer/org.kde.simplemdviewer.metainfo.xml" highlight="xml" >}}

</details>
