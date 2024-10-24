---
title: Saving and loading 
description: >
  Introduces the KIO library while adding loading and saving support to our application.
weight: 4
aliases:
  - /docs/getting-started/saving_and_loading/
---

## Introduction

Now that we have a basic text editor interface, it's time to make it do something useful. At the most basic, a text editor needs to be able to load files from data storage, save files that have been created/edited, and create new files.

KDE Frameworks provides a number of classes for working with files that make life a lot easier for developers. [KIO](docs:kio) allows you to easily access files through network-transparent protocols. Qt also provides standard file dialogs for opening and saving files.

![](saving_and_loading.webp)

## The Code

### main.cpp

We don't need to change anything in here.

{{< readfile file="/content/docs/getting-started/kxmlgui/saving_and_loading/main.cpp" highlight="cpp" >}}

### mainwindow.h

{{< readfile file="/content/docs/getting-started/kxmlgui/saving_and_loading/mainwindow.h" highlight="cpp" emphasize="7 11 16-26 30" >}}

To add the ability to load and save files, we must add the functions which will do the work. Since the functions will be called through [Qt's signal/slot](http://doc.qt.io/qt-6/signalsandslots.html) mechanism we must specify that these functions are slots using `Q_SLOTS`. Since we are using slots in this header file, we must also add the [Q_OBJECT](docs:qtcore;QObject::Q_OBJECT) macro, as only [Q_OBJECTs](docs:qtcore;QObject::Q_OBJECT) can have signals and slots.

We also want to keep track of the filename of the currently opened file, so we declare a [QString](docs:qtcore;QString) `fileName`.

### mainwindow.cpp

{{< readfile file="/content/docs/getting-started/kxmlgui/saving_and_loading/mainwindow.cpp" highlight="cpp" emphasize="3-6 11-12 15 34-37 42-105" >}}

We'll get into the details of mainwindow.cpp in a while. 

### texteditorui.rc

This is identical to the `texteditorui.rc` from the [previous tutorial]({{< relref "using_actions/#texteditoruirc" >}}). We do not need to add any information about any of the [KStandardAction](docs:kconfigwidgets;KStandardAction) methods since the placement of those actions is handled automatically by the [KXmlGui](docs:kxmlgui) system.

## Explanation

Okay, now to implement the code that will do the loading and saving. This will all be happening in `mainwindow.cpp`.

```cpp
MainWindow::MainWindow(QWidget *parent) : KXmlGuiWindow(parent), fileName(QString())
```

The first thing we do is to initialize `fileName(QString())` in the MainWindow's [constructor initializer list](https://en.cppreference.com/w/cpp/language/constructor) to make sure that `fileName` is empty right from the beginning.

### Adding the actions

We will then provide the outward interface for the user so they can tell the application to load and save. Like with the quit action in the [previous tutorial]({{< relref "using_actions/#kstandardaction" >}}), we will use [KStandardAction](docs:kconfigwidgets;KStandardAction). We add the actions in the same way we did for the quit action and, for each one, we connect it to the appropriate slot that we declared in the header file.

### Creating a new document

The first function we create is the `newFile()` function. 

```cpp
void MainWindow::newFile()
{
  fileName.clear();
  textArea->clear();
}
```

`fileName.clear()` sets the `fileName` string to be empty to reflect the fact that this document is not stored anywhere yet. `textArea->clear()` then clears the central text area using the same function that we connected the 'clear' action to in the [previous tutorial]({{< relref "using_actions#creating-the-qaction-object" >}}).

{{< alert title="Warning" color="warning" >}}
This example simply clears the text area without checking if the file has been saved first. It's only meant as a demonstration of file I/O and is *not* an example of best programming practices.
{{< /alert >}}

### Saving a file

{{< alert title="Note" color="info" >}}
To make this tutorial simple, this example program can only save to local storage even though it can open any file from any location, even those from remote sources.
{{< /alert >}}

### saveFileToDisk(const QString &)

Now we get onto our first file handling code. We are going to implement a function which will save the contents of the text area to the file name given as a parameter. Qt provides a class for safely saving a file called [QSaveFile](docs:qtcore;QSaveFile).

The function's prototype is:

```cpp
void MainWindow::saveFileAs(const QString &outputFileName)
```

We then create our [QSaveFile](docs:qtcore;QSaveFile) object and open it with:

```cpp
QSaveFile file(outputFileName);
file.open(QIODevice::WriteOnly);
```

Now that we have our file to write to, we need to format the text in the text area to a format which can be written to file. For this, we create a [QByteArray](docs:qtcore;QByteArray) to serve as our temporary string buffer and fill it with the plain text version of whatever is in the text area:

```cpp
QByteArray outputByteArray;
outputByteArray.append(textArea->toPlainText().toUtf8());
```

Now that we have our [QByteArray](docs:qtcore;QByteArray), we use it to write to the file with [QSaveFile::write()](docs:qtcore;QSaveFile::write). If we were using a normal [QFile](docs:qtcore;QFile), this would make the changes immediately. However, if a problem occurred partway through writing, the file would become corrupted. For this reason, [QSaveFile](docs:qtcore;QSaveFile) works by first writing to a temporary file and then, when calling [QSaveFile::commit()](docs:qtcore;QSaveFile::commit), the changes are made to the actual file and the file is then closed.

```cpp
file.write(outputByteArray);
file.commit();
```

Finally, we set MainWindows's `fileName` member to point to the file name we just saved to.

```cpp
fileName = outputFileName;
```

### saveFileAs()

This is the function that the `saveAs` slot is connected to. It simply calls the generic `saveFileToDisk(QString)` function and passes the file name returned by [QFileDialog::getSaveFileName()](docs:qtwidgets;QFileDialog::getSaveFileName).

```cpp
void MainWindow::saveFileAs()
{
    saveFileToDisk(QFileDialog::getSaveFileName(this, i18n("Save File As")));
}
```

[QFileDialog](docs:qtwidgets;QFileDialog) provides a number of static functions for displaying the common file dialog that is used by all KDE applications. Calling [QFileDialog::getSaveFileName()](docs:qtwidgets;QFileDialog::getSaveFileName) will display a dialog where the user can select the name of the file to save to or choose a new name. The function returns the full file name, which we then pass to `saveFileToDisk(QString)`.

### saveFile()

```c++
void MainWindow::saveFile()
{
    if(!fileName.isEmpty()) {
        saveFileToDisk(fileName);
    } else {
        saveFileAs();
    }
}
```

There's nothing exciting or new about this function, just the logic to decide whether or not to show the save dialog. If `fileName` is not empty, then the file is saved to `fileName`. But if it is, then the dialog is shown to allow the user to select a file name.

### Loading a file

Finally, we get around to being able to load a file, from local storage or from a remote location like an FTP server. The code for this is all contained in `MainWindow::openFile()`.

First we must ask the user for the name of the file they wish to open. We do this using [QFileDialog::getOpenFileUrl()](docs:qtwidgets;QFileDialog::getOpenFileUrl):

```c++
const QUrl fileNameFromDialog = QFileDialog::getOpenFileUrl(this, i18n("Open File"));
```

Here we use [QUrl](docs:qtcore;QUrl) to handle files from remote locations.

Then we use the [KIO](docs:kio) library to retrieve our file. This allows us to open the file even if it's stored in a remote location like an SFTP server. We make the following call to the [KIO::storedGet](docs:kio;KIO::storedGet) function with an argument for the file you wish to open or download:

```c++
KIO::Job *job = KIO::storedGet(fileNameFromDialog);
```

The function returns a handle to a [KIO::Job](docs:kio;KIO::Job), which we first connect to our `downloadFinished()` slot before "running" the job.

```c++
connect(job, &KJob::result, this, &MainWindow::downloadFinished);
job->exec();
```

The rest of the work happens in the `downloadFinished()` slot. First, the job is checked for errors. If it failed, we display a message box giving the error. We also make sure to clear the `fileName`, since the file wasn't opened successfully:

```c++
KMessageBox::error(this, job->errorString());
fileName.clear();
```

Otherwise, we continue with opening the file.

The data that `storedGet()` successfully downloaded, in this case the contents of our text file, is stored in the data member of a [KIO::StoredTransferJob](docs:kio;KIO::StoredTransferJob) class. But in order to display the contents of the file as text, we must use a [QTextStream](docs:qtcore;QTextStream). We create one by passing the data of the [KIO::StoredTransferJob](docs:kio;KIO::StoredTransferJob) to its constructor and then call its [QTextStream::readAll()](docs:qtcore;QTextStream::readAll) function to get the text from the file. This is then passed to the `setPlainText()` function of our text area.

```c++
const KIO::StoredTransferJob *storedJob = qobject_cast<KIO::StoredTransferJob *>(job);

if (storedJob) {
    textArea->setPlainText(QTextStream(storedJob->data(), QIODevice::ReadOnly).readAll());
}
```

{{< alert title="Note" color="info" >}}
Again, for simplicity's sake, this tutorial only saves text files to local disk. When you open a remote file for viewing and try to save it, the program will behave as if you were calling Save As on a completely new file.
{{< /alert >}}

### CMakeLists.txt

{{< readfile file="/content/docs/getting-started/kxmlgui/saving_and_loading/CMakeLists.txt" highlight="cmake" emphasize="27-28 46-47" >}}

Since we are now using the [KIO](docs:kio) library, we must tell CMake to link against it. We do this by passing `KIO` to the [`find_package()`](https://cmake.org/cmake/help/latest/command/find_package.html) function and `KF6::KIOCore` to the [`target_link_libraries()`](https://cmake.org/cmake/help/latest/command/target_link_libraries.html) function.

### Running our application

Once again, you can repeat the same steps provided in [KXmlGui Hello World]({{< ref "hello_world#kxmlgui-running" >}}) to build and install the application. You can then run the project with:

```bash
kde-builder --run texteditor
```

or

```bash
texteditor
```
