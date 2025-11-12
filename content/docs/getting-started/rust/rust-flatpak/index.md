---
title: Publishing your Rust app as a flatpak
weight: 3
layout: home
group: introduction
description: >
  Ship your app easily to users
---


### Creating a Flatpak 

Traditionally in the Rust ecosystem you would build and install a Rust program from [crates.io](https://crates.io/) with `cargo install` or install a binary directly with [cargo-binstall](https://github.com/cargo-bins/cargo-binstall), but desktop applications consist of more files than just a binary.

We have already prepared the project to use CMake on top of Cargo to install those additional files to their appropriate places so Linux distributions can package your application more easily, and that also makes it ready to package as a flatpak.

Create a new flatpak manifest file `org.kde.simplemdviewer.json` in the root directory of the project:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/org.kde.simplemdviewer.json" highlight="json"  >}}

The most notable additions to the manifest are the rust-stable Sdk (development) extension, and the build option to append Rust binaries like Cargo and rustc, needed for building our application:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/org.kde.simplemdviewer.json" highlight="json" start=31 lines=6 >}}

Flatpak performs a local offline build of the project, so the traditional `cargo build` step cannot fetch crates from crates.io while building the project. To accommodate for that, we need to use [flatpak-cargo-generator](https://github.com/flatpak/flatpak-builder-tools/tree/master/cargo).

Download and use `flatpak-cargo-generator.py` to prepare all the dependency crates:

```bash
wget https://raw.githubusercontent.com/flatpak/flatpak-builder-tools/refs/heads/master/cargo/flatpak-cargo-generator.py
python3 flatpak-cargo-generator.py Cargo.lock -o cargo-sources.json
```

You might need to manually install `python3-aiohttp` and `python3-toml` from your distribution to run the script.

This will make the dependencies available in the flatpak manifest as a separate source. We need three sources in total: the cargo dependencies, the actual project in the current directory, and additional shell commands to put the Cargo configuration file in the right place to build inside a flatpak:

{{< readfile file="/content/docs/getting-started/rust/rust-app/simplemdviewer_final/org.kde.simplemdviewer.json" highlight="json" start=15 lines=14 >}}

### Building and running

Install `org.kde.Sdk` and `org.kde.Platform`, version 6.9, from Flathub:

```bash
flatpak install org.kde.Platform/x86_64/6.9 org.kde.Sdk/x86_64/6.9
```

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

If you use the `--user` flag, you will also need to pass this flag when installing the flatpak.

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
[App Submission Guidelines](https://docs.flathub.org/docs/for-app-authors/submission).

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

