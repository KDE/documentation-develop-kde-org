---
title: "KArchive"
description: Read and write to archives
weight: 5
group: "features"
SPDX-License-Identifier: missing
SPDX-FileCopyrightText: 2014 Rohan Garg <rohan16garg@gmail.com>
aliases:
  - /docs/features/karchive/
---

When you are storing large amounts of data, how do you archive it in
a easy way from within your code? The [KArchive framework](https://api.kde.org/karchive-index.html) provides a quick
and easy way to do this from within Qt apps.

KArchive supports a wide array of formats
such as `p7zip`, `zip` and `tar` archives, giving you the flexibility of
choosing the formats that fit your project.

## Creating and opening an archive

An archive consists of:

* a root directory
* optional directories inside the root directory
* files in any directory

[KArchive::writeDir()](https://api.kde.org/karchive.html#writeDir) allows you to create directories while [KArchive::writeFile()](https://api.kde.org/karchive.html#writeFile) allows you to create directories and files.

This is done by passing string paths: `writeDir("emptydir/emptysubdir")` and `writeFile("subdir/subsubdir/world")` will generate the following structure:

```tree
hello.zip
├── emptydir/
│   └── emptysubdir/
└── somedir/
    └── subdir/
        └── world
```

Creating an archive with the above structure is very simple:

```cpp
// Create a zip archive
KZip archive(QStringLiteral("hello.zip"));

// Open our archive for writing
if (archive.open(QIODevice::WriteOnly)) {
    // The archive is open, we can now write data
    archive.writeDir("emptydir/emptysubdir");
    archive.writeFile(QStringLiteral("somedir/subdir/world"), // File name
                      QByteArray("The whole world inside a hello."), // Data
                      0100644, // Permissions
                      QStringLiteral("owner"), // Owner
                      QStringLiteral("users")); // Group

    // Don't forget to close!
    archive.close();
}
```

If you already know the path to the file, you can then open the archive as follows:

```cpp
if (archive.open(QIODevice::ReadOnly)) {
    const KArchiveDirectory *dir = archive.directory(); // the root directory
    const KArchiveFile *file = dir->file("somedir/subdir/world");
    if (!file) {
        qInfo() << "File not found!";
        return -1;
    }
    QByteArray data(file->data());
    qInfo() << data; // the file contents
}
```

{{< alert title="💡Optimization tip" color="success" >}}

To avoid reading everything into memory in one go, we can use [createDevice()](https://api.kde.org/karchivefile.html#createDevice) instead:

```cpp
std::unique_ptr<QIODevice> device(file->createDevice());
while (!device.get()->atEnd()) {
    qDebug() << device->readLine();
}
```

{{< /alert >}}

If you don't know the file structure of the archive beforehand, you can use [KArchiveEntry](https://api.kde.org/karchiveentry.html), the base class for [KArchiveDirectory](https://api.kde.org/karchivedirectory.html) and [KArchiveFile](https://api.kde.org/karchivefile.html).

This can be used to check whether an entry is a file or directory:

```cpp
// This example does not represent a full-fledged implementation.
if (archive.open(QIODevice::ReadOnly)) {
    const KArchiveDirectory *dir = archive.directory();
    const KArchiveEntry *entry = dir->entry("somedir/subdir/world");
    if (!entry) {
        qInfo() << "Entry not found!";
        return -1;
    }
    if (entry->isFile()) {
        const KArchiveFile *file = static_cast<const KArchiveFile *>(entry);
        QByteArray data(file->data());
        qDebug() << data;
    }
    // ...
}
```

## Advanced usecases

### Working with compressed data
In addition to supporting files, KArchive also supports reading and writing compressed data to devices such as
buffers or sockets via the KCompressionDevice class, allowing developers to save
bandwidth transmitting data over networks.

A quick example of the KCompressionDevice class can be summed up as:

{{< snippet repo="frameworks/karchive" file="examples/bzip2gzip/main.cpp" part="kcompressiondevice_example" lang="cpp" >}}

