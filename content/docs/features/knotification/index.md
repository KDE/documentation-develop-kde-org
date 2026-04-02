---
title: "KNotification"
weight: 1
description: >
  Create platform-independent notifications
group: "features"
---

KNotification allows to create notifications:
* on Linux, following the [Desktop Notifications specification](https://specifications.freedesktop.org/notification/latest/)
* on Windows, using [SnoreToast](https://invent.kde.org/libraries/snoretoast)
* on Android, using [NotificationBuilder](https://developer.android.com/develop/ui/views/notifications/build-notification)
* on MacOS, using [NSUserNotificationCenter](https://developer.apple.com/documentation/foundation/nsusernotificationcenter)

Using the same straightforward C++ and QML API.

This tutorial focuses on C++. You can read more about its QML API in [KNotifications QML Types](https://api.kde.org/org-kde-notifications-qmlmodule.html).

## The notifyrc file

To send notifications, your application needs to provide (and install) an `appname.notifyrc` file. It is used to list all the application's notification events. In KDE Plasma, it is also used to allow the user to control notification events, muting or adding sound to them, among other things. It can be accessed through `System Settings` → `Notifications` → `Configure for applications…`.

It needs to be installed to `knotifications6/appname.notifyrc` in a [QStandardPaths::GenericDataLocation](https://doc.qt.io/qt-6/qstandardpaths.html#StandardLocation-enum) directory. On Android, this path is `qrc:/knotifications6/`.

The `appname` must either match [QCoreApplication::applicationName](https://doc.qt.io/qt-6/qcoreapplication.html#applicationName-prop) or be specified using [KNotification::setComponentName()](https://api.kde.org/knotification.html#setComponentName). Notifications won't be visible otherwise.

This file contains mainly two parts, global information and individual events:

```ini
[Global]
IconName=myicon
Name=Name of Application
Comment=A brief description of the application
DesktopEntry=org.kde.yourapplication.desktop

[Event/newmail]
Name=New E-Mail
Comment=You got a new email
Action=Sound|Popup

[Event/contactOnline]
Name=Contact Goes Online
Comment=One of your contacts has been connected
Sound=filetoplay.ogg
Action=None
Urgency=Low
```

`IconName=`, `Name=` and `Comment=` follow the same pattern as desktop entry files, and will be used to display information about where the notification comes from in the popup itself, in the notification history widget, or in the System Settings module. If `Name` is not available, `Comment` will be displayed instead.

For the notifications to be shown in these three places, the following requirements must be met:

* The `DesktopEntry=` field matches the application's desktop file name (including extension)
* The desktop file name is set with [QGuiApplication::setDesktopFileName()](https://doc.qt.io/qt-6/qguiapplication.html#desktopFileName-prop) or with [KAboutData](https://api.kde.org/kaboutdata.html)
* The desktop file is not marked as `Hidden`

New events are made by creating a new group matching `[Event/` + `customEventId` + `]`. The event ID is a custom string made by you that will be used in the [KNotification constructor](https://api.kde.org/knotification.html#KNotification).

The `Action=` key determines whether the notification will show up (`Popup`), play a sound (`Sound`) or do nothing (`None` or empty). If `Sound` is specified, the notifyrc file must also include the `Sound=` key for that event. Both actions can be combined with `|`.

The `Urgency=` key determines how the system will present the notification and whether they show up even with notifications turned off. The possible values are `Low`, `Normal`, `High` and `Critical`, matching their [respective enum](https://api.kde.org/knotification.html#Urgency-enum).

You can install the notifyrc file with the following CMake command, if you use ECM's [KDEInstallDirs](https://api.kde.org/ecm/kde-module/KDEInstallDirs6.html):

```cmake
install(FILES appname.notifyrc  DESTINATION ${KDE_INSTALL_KNOTIFYRCDIR})
```

## Basic usage from C++

Once the notifyrc file gets installed, sending a notification is as simple as instantiating a new KNotification object, set its text or other properties, and finish by sending the notification event.

```cpp
KNotification* notification = new KNotification("eventNameFromNotifyrc");
notification->setText("It just works! 🎉");
notification->sendEvent();
```

## Custom behavior on close

A common use case in applications is to trigger custom behavior when the user clicks the close button, the timeout runs out, or when the user clicks an action button in the notification popup.

This can be done using the [closed signal](https://api.kde.org/knotification.html#closed):

```cpp
QObject::connect(
    notification, &KNotification::closed,
    [](){
        qInfo() << "Notification closed!";
    });
```

## Custom behavior on action clicked

Depending on the system, notifications can have *actions* the user may click to perform a task quickly. This can be done using [KNotificationAction](https://api.kde.org/knotificationaction.html).

The [activated signal](https://api.kde.org/knotificationaction.html#activated) can then be used to connect to any custom behavior by the application.

The following example shows an action that will raise a QML application window to the front upon click:

```cpp
KNotification* notification = new KNotification("eventNameFromNotifyrc");
notification->setText("You have a new email!");
KNotificationAction* openAction = notification->addAction("Open application");
QObject::connect(
    defaultAction, &KNotificationAction::activated,
    [&engine](){
        auto window = qobject_cast<QQuickWindow*>(engine.rootObjects().first());
        window->show();
        window->requestActivate();
        window->raise();
    }
);
notification->sendEvent();
```

## Custom behavior with reply action

Another common use case of controls being used in a notification is showing a button so that the user may write text inline that can be used by the application, for example, to send a chat reply or an email.

This can be done with [KNotificationReplyAction](https://api.kde.org/knotificationreplyaction.html).

```cpp
KNotification* notification = new KNotification("eventNameFromNotifyrc");
notification->setText("Your friend just sent a message!");
auto replyAction = std::make_unique<KNotificationReplyAction>("Reply"); // Button label
replyAction->setPlaceholderText("Reply with...");
QObject::connect(replyAction.get(), &KNotificationReplyAction::replied, [](const QString &text) {
    qInfo() << "You sent the message:" << text;
});
// Needs to be after the QObject::connect call!
notification->setReplyAction(std::move(replyAction));
notification->sendEvent();
```
