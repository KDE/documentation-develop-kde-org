---
title: Command line interface
description: >
  Adds the ability to specify which file to open from the command line to our text editor.
weight: 6
aliases:
  - /docs/getting-started/commandline/
---

## Introduction

We now have a working text editor that can open and save files. We might, however, want to extend its utility by enabling users to more quickly and efficiently use it to edit files. In this tutorial we will make the editor act more like a desktop application by enabling it to open files from command line arguments or even using Open with from within Dolphin.

![](commandline.webp)

## Code and Explanation

### mainwindow.h

{{< readfile file="/content/docs/getting-started/kxmlgui/commandline/mainwindow.h" highlight="cpp" emphasize="15" >}}

Here we have done nothing but add a new `openFileFromUrl()` function which takes a [QUrl](docs:qtcore;QUrl). Again, we use URLs instead of strings so that we can also work with remote files as if they were local.

### mainwindow.cpp

{{< readfile file="/content/docs/getting-started/kxmlgui/commandline/mainwindow.cpp" highlight="cpp" emphasize="80 83-91" >}}

There's no new code here, only rearranging. Everything from `void openFile()` has been moved into `void openFileFromUrl(const QUrl &inputFileName)` except the call to [QFileDialog::getOpenFileUrl()](docs:qtwidgets;QFileDialog::getOpenFileUrl).

This way, we can call `openFile()` if we want to display a dialog, or we can call `openFileFromUrl(const QUrl &)` if we know the name of the file already. Which will be the case when we feed the file name through the command line.

### main.cpp

{{< readfile file="/content/docs/getting-started/kxmlgui/commandline/main.cpp" highlight="cpp" >}}

This is where all the [QCommandLineParser ](docs:qtcore;QCommandLineParser) magic happens. In previous examples, we only used the class to feed [QApplication](docs:qtwidgets;QApplication) the necessary data for using flags like `--version` or `--author`. Now we actually get to use it to process command line arguments.

First, we tell [QCommandLineParser ](docs:qtcore;QCommandLineParser) that we want to add a new positional argument. In a nutshell, these are arguments that are not options. `-h` or `--version` are options, `file` is an argument.

```c++
parser.addPositionalArgument(u"file"_s, i18n("Document to open"));
```

Later on, we start processing positional arguments, but only if there is one. Otherwise, we proceed as usual. In our case we can only open one file at a time, so only the first file is of interest to us. We call the `openFileFromUrl()` function and feed it the URL of the file we want to open, whether it is a local file like "$HOME/foo" or a remote one like "ftp.mydomain.com/bar". We use the overloaded form of [QUrl::fromUserInput()](docs:qtcore;QUrl::fromUserInput) in order to set the current path. This is needed in order to work with relative paths like "../baz".

```c++
if (parser.positionalArguments().count() > 0) {
    window->openFileFromUrl(QUrl::fromUserInput(parser.positionalArguments().at(0), QDir::currentPath()));
}
```

### CMakeLists.txt

We don't need to change anything in here.

{{< readfile file="/content/docs/getting-started/kxmlgui/commandline/CMakeLists.txt" highlight="cmake" >}}

## Compile, Install and Run

With this, we should be ready to test our application.

As before:

```bash
cmake -B build/ -DCMAKE_INSTALL_PREFIX=$HOME/kde/usr
cmake --build build/
cmake --install build/
source build/prefix.sh
```

However, we will test if our application handles files from the command line correctly.

```bash
echo "It works!" > testfile.txt
texteditor somefile.txt
```

You should then see your application run and load `testfile.txt` directly from its UI, showing "It works!" in your `textArea`.
