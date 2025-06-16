---
title: Publishing your Rust app as a flatpak
weight: 3
layout: home
group: introduction
description: >
  Ship your app easily to users
---

```
wget https://raw.githubusercontent.com/flatpak/flatpak-builder-tools/refs/heads/master/cargo/flatpak-cargo-generator.py
python3 flatpak-cargo-generator.py Cargo.lock -o cargo-sources.json
```

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
