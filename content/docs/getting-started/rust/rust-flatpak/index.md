---
title: Publishing your Rust app as a flatpak
weight: 3
layout: home
group: introduction
description: >
  Ship your app easily to users
---


## Creating a Flatpak 

Traditionally in the Rust ecosystem you would build and install a Rust program from [crates.io](https://crates.io/) with `cargo install` or install a binary directly with [cargo-binstall](https://github.com/cargo-bins/cargo-binstall), but desktop applications consist of more files than just a binary.

We have already prepared the project to use CMake on top of Cargo to install those additional files to their appropriate places so Linux distributions can package your application more easily, and that also makes it ready to package as a flatpak.

Create a new flatpak manifest file `simplemdviewer/org.kde.simplemdviewer_rust.json`:

```
{
  "command": "kirigami_hello",
  "desktop-file-name-suffix": " (Nightly)",
  "finish-args": [
    "--share=ipc",
    "--device=dri",
    "--socket=fallback-x11",
    "--socket=wayland"
  ],
  "id": "org.kde.kirigami_rust",
  "modules": [
    {
      "buildsystem": "cmake",
      "name": "kirigami_rust",
      "sources": [
        "cargo-sources.json",
        {
          "type": "dir",
          "path": "."
        },
        {
          "type": "shell",
          "commands": [
            "mkdir -p .cargo",
            "cp -vf cargo/config .cargo/config.toml"
          ]
        }
      ]
    }
  ],
  "sdk-extensions": [
    "org.freedesktop.Sdk.Extension.rust-stable"
  ],
  "build-options": {
    "append-path": "/usr/lib/sdk/rust-stable/bin"
  },
  "runtime": "org.kde.Platform",
  "runtime-version": "6.9",
  "sdk": "org.kde.Sdk"
}
```

The most notable additions to the manifest are the rust-stable Sdk (development) extension, and the build option to append Rust binaries like Cargo and rustc, needed for building our application:

```
"sdk-extensions": [
  "org.freedesktop.Sdk.Extension.rust-stable"
],
"build-options": {
  "append-path": "/usr/lib/sdk/rust-stable/bin"
},

```

Flatpak performs a local offline build of the project, so the traditional `cargo build` step cannot fetch crates from crates.io while building the project. To accomodate for that, we need to use [flatpak-cargo-generator](https://github.com/flatpak/flatpak-builder-tools/tree/master/cargo).

Download and use `flatpak-cargo-generator.py` to prepare all the dependency crates:

```
wget https://raw.githubusercontent.com/flatpak/flatpak-builder-tools/refs/heads/master/cargo/flatpak-cargo-generator.py
python3 flatpak-cargo-generator.py Cargo.lock -o cargo-sources.json
```

This will make the dependencies available in the flatpak manifest as a separate source. We need three sources in total: the cargo dependencies, the actual project in the current directory, and additional shell commands to put the Cargo configuration file in the right place to build inside a flatpak:

```
"sources": [
  "cargo-sources.json",
  {
    "type": "dir",
    "path": "."
  },
  {
    "type": "shell",
    "commands": [
      "mkdir -p .cargo",
      "cp -vf cargo/config .cargo/config.toml"
    ]
  }
]
```

