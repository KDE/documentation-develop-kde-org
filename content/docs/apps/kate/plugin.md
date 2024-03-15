---
title: "Kate plugin tutorial"
weight: 1
description: Learn how to write a Kate plugin
---

The plugin we will write will basically be a Markdown previewer. It will do something like
- Once a file opens, check if the file is a Markdown file
- If it is, then create and show a preview for it in right the sidebar

We'll call this plugin Markdown Previewer.

This tutorial assumes that you have a basic understanding of C++ and Qt concepts and that you have development versions of Qt and KDE Framework libraries installed, as well as `extra-cmake-modules`.

Initial directory structure:

```
myplugin
├─ CMakeLists.txt  # the build file, this is needed to build the plugin
├─ plugin.cpp      # the actual plugin code
├─ plugin.h
└─ plugin.json     # plugin type, description and name
```

Let's start by writing our cmake file:

{{< readfile file="/content/docs/apps/kate/plugin/CMakeLists.txt" highlight="cmake" >}}

Ok, CMake is done. Let's write the `plugin.json` file:

{{< readfile file="/content/docs/apps/kate/plugin/plugin.json" highlight="json" >}}

Finally, let's start writing the actual code for the plugin.

Before I start, let's go through a couple of basic things first. Every Kate plugin consists of at least two classes
- Plugin class
- Plugin View class

The plugin class creates a global instance of the plugin only once. The plugin view class will be created once for each new MainWindow. Your UI code will always go into the plugin view class. The plugin class usually stores stuff that will be same across multiple plugin views for e.g., the configuration.

Below is the code for both of the classes. At this point, the classes are empty and don't do anything at all

#### `plugin.h`
```c++
#pragma once

#include <KTextEditor/Document>
#include <KTextEditor/MainWindow>
#include <KTextEditor/Plugin>
#include <KTextEditor/View>
#include <KXMLGUIClient>
#include <QTextBrowser>

class MarkdownPreviewPlugin : public KTextEditor::Plugin
{
    Q_OBJECT
public:
    explicit MarkdownPreviewPlugin(QObject *parent, const QList<QVariant> & = QList<QVariant>())
        : KTextEditor::Plugin(parent)
    {
    }

    QObject *createView(KTextEditor::MainWindow *mainWindow) override;
};

class MarkdownPreviewPluginView : public QObject, public KXMLGUIClient
{
    Q_OBJECT
public:
    explicit MarkdownPreviewPluginView(MarkdownPreviewPlugin *plugin, KTextEditor::MainWindow *mainwindow);

private:
    KTextEditor::MainWindow *m_mainWindow = nullptr;
};
```

#### `plugin.cpp`
```c++
#include "plugin.h"

#include <KPluginFactory>
#include <QIcon>
#include <QLayout>
#include <KLocalizedString>

K_PLUGIN_FACTORY_WITH_JSON(MarkdownPreviewPluginFactory, "plugin.json", registerPlugin<MarkdownPreviewPlugin>();)

QObject *MarkdownPreviewPlugin::createView(KTextEditor::MainWindow *mainWindow)
{
    return new MarkdownPreviewPluginView(this, mainWindow);
}

MarkdownPreviewPluginView::MarkdownPreviewPluginView(MarkdownPreviewPlugin *plugin, KTextEditor::MainWindow *mainwindow)
    : m_mainWindow(mainwindow)
{
}

#include "plugin.moc"
```

With this, we should now be able to compile and install it. For testing purposes, we will be installing it to our home directory.

```bash
cmake -B build/ -D CMAKE_INSTALL_PREFIX=$HOME/kde/usr
cmake --build build/
cmake --install build/
```

You should now see the installed plugin in `~/kde/usr/lib64/plugins/ktexteditor/markdowpreview.so`.

To test the local plugin with our system-installed Kate, we can use the generated `prefix.sh` inside our build folder:

```bash
source build/prefix.sh
kate
```

{{< alert title="Note" color="info" >}}
If we were to install the plugin to the root directory where Kate plugins are deployed, it would have been installed in `/usr/lib/qt/plugins/ktexteditor/markdowpreview.so`. To do that, you'd need to remove the `-D CMAKE_INSTALL_PREFIX` call and run the install command with sudo, and sourcing `prefix.sh` would no longer be necessary.
{{< /alert >}}

With Kate now running, go to Settings, Configure Kate..., Plugins, and verify that the "Markdown Previewer" plugin is present.

Next we will create a toolview in the right sidebar. This toolview will be the GUI component that appears on the right side of Kate that, when clicked, opens the Markdown preview.

First add two new member variables to the MarkdownPreviewPluginView class in `plugin.h`:

```c++
    // The top level toolview widget
    std::unique_ptr<QWidget> m_toolview;

    // The widget which will show the actual preview
    QTextBrowser *m_previewer = nullptr;
```

Now let's create the toolview by adding the following to the constructor in `plugin.cpp`:

```c++
MarkdownPreviewPluginView::MarkdownPreviewPluginView(MarkdownPreviewPlugin *plugin, KTextEditor::MainWindow *mainwindow)
    : m_mainWindow(mainwindow)
{
    m_toolview.reset(
        m_mainWindow->createToolView(plugin,                        // pointer to plugin
                                      "markdownpreview",            // just an identifier for the toolview
                                      KTextEditor::MainWindow::Right, // we want to create a toolview on the right side
                                      QIcon::fromTheme("preview"), // icon,
                                      i18n("Markdown Preview"))); // User visible name of the toolview, i18n means it will be available for translation

    m_previewer = new QTextBrowser(m_toolview.get());
    // Add the preview widget to our toolview
    m_toolview->layout()->addWidget(m_previewer);
}
```

Before proceeding further, make sure the code compiles. Then install the plugin, enable it in Kate and verify that the toolview is visible in the right sidebar. If the toolview isn't visible, make sure the plugin is enabled and recheck your code.

{{< alert title="Note" color="info" >}}
If you didn't use an icon and your sidebar settings are set to "icon-only", you won't see the button for the toolview and it will appear as if there is no toolview because of the non existent icon. To disable this setting, check the option "**Show text for left and right sidebar buttons**".
{{< /alert >}}

Now to the actual previewing. To be able to tell when the active document changes the `MainWindow` class emits a `viewChanged()` [signal](https://doc.qt.io/qt-6/signalsandslots.html). We will connect to this signal and then check if the new document is of Markdown type. If it is, we will load the document's text into the preview widget which will take care of the rest.

So, in the constructor of the `MarkdownPreviewPluginView` class add the following:
```c++
    // Connect the view changed signal to our slot
    connect(m_mainWindow, &KTextEditor::MainWindow::viewChanged, this, &MarkdownPreviewPluginView::onViewChanged);
```

Next, we will define the `onViewChanged()` function. Let's add its declaration in `MarkdownPreviewPluginView` in `plugin.h`:
```c++
void onViewChanged(KTextEditor::View *v);
```

And definition in the `plugin.cpp` file:

```c++
void MarkdownPreviewPluginView::onViewChanged(KTextEditor::View *v)
{
    if (!v || !v->document()) {
        return;
    }

    if (v->document()->highlightingMode().toLower() == "markdown") {
        m_previewer->setMarkdown(v->document()->text());
    }
}
```

Compile and install it. You should now be able to see the preview of markdown files in the toolview we created.

### Full code

#### CMakeLists.txt
{{< readfile file="/content/docs/apps/kate/plugin/CMakeLists.txt" highlight="cmake" >}}
#### plugin.json
{{< readfile file="/content/docs/apps/kate/plugin/plugin.json" highlight="json" >}}
#### plugin.h
{{< readfile file="/content/docs/apps/kate/plugin/plugin.h" highlight="cpp" >}}
#### plugin.cpp
{{< readfile file="/content/docs/apps/kate/plugin/plugin.cpp" highlight="cpp" >}}

Since this is a very basic tutorial and likely doesn't explain a lot of things or shows other APIs that we have, the following resources may be of more help:

- https://api.kde.org/frameworks/ktexteditor/html/ - Here you will find the list of all classes and methods available in the API
- https://invent.kde.org/utilities/kate/-/tree/master/addons - The list of existing plugins can be an extremely useful resource if you want to find how to do a particular thing
- https://kate-editor.org/support/ - You can find links to our mailing-list, chat here. We also have telegram and matrix groups where you can ask questions

