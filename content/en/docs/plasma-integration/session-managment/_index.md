---
title: Session Management
description: >
  Make your application aware of X sessions
weight: 1
---

## About KDE and X11 session management

Since KDE 1.0, KDE supports the legacy X11R4 and ICCCM session management protocols. It will restart with the specified command all legacy applications that define the `WM_COMMAND` property or support the `WM_SAVE_YOURSELF` protocol. It will also restore the window geometries on a best effort basis. 

Since KDE 2.0, KDE also supports the standard X11R6 session management protocol XSMP and uses it. You can download the official documentation of the standard from the X Consortium's FTP server [ftp.x.org](http://stuff.mit.edu/afs/sipb/contrib/doc/X11/hardcopy/SM/xsmp.PS.gz). Unlike the legacy protocols, the new X11R6 session management gives a chance to save application dependent settings when you log out. A text editor, for instance, would save the names of the loaded files and would reload them when you log in again. Another major advantage of the new protocol is the support for a clean and safe logout procedure even if the users decides not to restore the session next time. The protocol gives applications the possibility to interact with the user if they are in danger to lose some data, and to cancel the shutdown process if necessary. 

## Further Reading

An introductory overview of session management functionality and the Qt API for it is available from [Qt documentation](https://doc.qt.io/qt-5/session.html).

In KDE, the classes [KConfigGui](https://api.kde.org/frameworks/kconfig/html/namespaceKConfigGui.html) and [KMainWindow](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html) hide all the ugly details from the programmer. Basically, a KConfigGui manages a KConfig configuration object (available trough [KConfigGui::sessionConfig()](https://api.kde.org/frameworks/kconfig/html/namespaceKConfigGui.html#a36d66204429764d84f4f7728dfb0805e)) for you, that your application can use to store session specific data. 

Please read the class documentation, especially the one of [KMainWindow](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html), for a detailed interface description. With the advanced functionality in [KMainWindow](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html), it's really just a matter of a few lines to get even a multi-window application to retains its state between different user sessions. 

## Implementing session management in your application

Here's just a brief overview how you can add session management to your application. Again, see the class documentation for details.

Implementing session management in Plasma is easy. If your main window inherits from KMainWindow, you have just 2 things to do: 

+ Reimplement some virtual functions of [KMainWindow](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html).
+ Add session management support to your main() function.

That's all. 

### Reimplement some virtual functions of KMainWindow

KMainWindow will automatically save its position, geometry and positions of toolbars and menu bar on logout - and restore it on the next startup.

For every other data that your application needs to restore a session, you have to write the code for saving and restoring yourself. However, KMainWindow makes this task easy. You can just re-implement the following functions:

+ [saveProperties()](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html#a4c7a6c395eec0bb245cd9ad6c884f897): This function is called only when the session manager closes the application (and not when the user closes the application). To save the data that you need to restore the session, reimplement this function. (For a text editor that would be the list of loaded files) Note that you may not do any user interaction in this function! (For example, you may not display any dialog!)
+ [readProperties()](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html#ac8d0d64ed5b309ba1da410423120d0a6): To read the data again on next login, reimplement this function.

Furthermore, the function [queryClose()](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html#af8c5708414be62f259114b0453ef8432) could be interesting for you. This function is called always before the window is closed, either by the user or indirectly by the session manager. (Note that this is not the case for a call of [QApplication::quit()](https://doc.qt.io/qt-5/qcoreapplication.html#quit) because this function will exit the event loop without causing a close event for the main windows. It will even not destroy them.) Typically, here you can warn the user that the application or some windows have unsaved data on close or logout (example: show a dialog with the buttons "Save changes" and "Discard changes"). However, for session management it isn't nice to need a user interaction before closing, so you better avoid this. Note that it is not determined if `saveProperties()` is called before or after `queryClose()`! 

{{< alert color="info" title="Note" >}}
To save your application-wide properties (data that is only needed once per application, and not for each main window instance) reimplement [saveGlobalProperties()](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html#acf811d77a3acdcf2b61f8826429615a7) and it's counterpart [readGlobalProperties()](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html#a2d4da4f305f00e8a5c94f5b978334231). Normally, you don't need these functions. 
{{< /alert >}}

## Add session management support to your main() function

While [KMainWindow::saveProperties()](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html#a4c7a6c395eec0bb245cd9ad6c884f897) (and [KMainWindow::queryClose()](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html#af8c5708414be62f259114b0453ef8432)) will be called automatically, [KMainWindow::readProperties()](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html#ac8d0d64ed5b309ba1da410423120d0a6) will not. You have to add some code to your main() function to add session restoring. 

{{< highlight cpp "linenos=table" >}}
QApplication app;
if (app.isSessionRestored()) {
  kRestoreMainWindows<MyWindow>();
} else {
  // create default application as usual
  // example:
  MyWindow * window = new MyWindow();
  // The function will replace '#' with numbers that are
  // unique within the application:
  window->setObjectName("MyWindow#");
  window->show();
}
return app.exec();
{{< /highlight >}}

[kRestoreMainWindows<>()](https://api.kde.org/frameworks/kxmlgui/html/group__KXMLGUI__Session.html#ga59a5929cb898cca8ac26a3d55397aae3) will create (on the heap) as many instances of your main windows as have existed in the last session and call [KMainWindow::restore()](https://api.kde.org/frameworks/kxmlgui/html/classKMainWindow.html#a46e01bd1aa6d488f1be2a5010030efb2) with the correct arguments. Note that also `QWidget::show()` is called implicitly. 

About `setObjectName("MyWindow#")`: For session management and window management to work properly, all main windows in the application should have a different name. If you don't do it, KMainWindow will create a unique name, but it's recommended to explicitly pass a window name that will also describe the type of the window. If there can be several windows of the same type, append '#' (hash) to the name, and KMainWindow will replace it with numbers to make the names unique. For example, for a mail client which has one main window showing the mails and folders, and which can also have one or more windows for composing mails, the name for the folders window should be e.g. "mainwindow" and for the composer windows "composer#". 

With this you can easily restore all top-level windows of your application. 

It is also possible to restore different types of top-level windows (each derived from KMainWindow, of course) within one application. Imagine you have three classes of main windows: childMW1, childMW2 and childMW3: 

{{< highlight cpp "linenos=table" >}}
KApplication app;
if ( app.isSessionRestored() ) {
  kRestoreMainWindows< childMW1, childMW2, childMW3 >();
} else {
  // create default application as usual
  // example:
  childMW1* window1 = new childMW1();
  childMW2* window2 = new childMW2();
  childMW3* window3 = new childMW3();
  // The function will replace '#' with numbers that are
  // unique within the application:
  window1->setObjectName("type1mainWindow#");
  window2->setObjectName("type2mainWindow#");
  window3->setObjectName("type3mainWindow#");
  window1->show();
  window2->show();
  window3->show();
}
return app.exec();
{{< /highlight >}}

Currently, KXmlGui provides the `kRestoreMainWindows<>()` template functions for up to three template arguments. 

### Appendix: Architecture of the KDE session manager

The name of the session management server in KDE is `ksmserver` and it is part of the `plasma-workspace` package. The server interacts with the KDE window manager `kwin` to save and restore the window geometries and to perform legacy session management. To make session management work, ksmserver has to be started as last process of the X login procedure. This happens automatically at the end of the `startplasma` script. 

 Initial Author: [Matthias Ettrich](mailto:ettrich@kde.org)




