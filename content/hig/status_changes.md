---
title: "Communicating status changes"
weight: 8
aliases:
- /hig/style/color/
- /hig/components/assistance/
- /hig/components/assistance/inline/
- /hig/components/assistance/message/
- /hig/components/assistance/progress/
- /hig/platform/notification/
- /hig/platform/tray/
---

Minimize unnecessary status messages. Indicate success by visually changing something on the screen related to the task that succeeded, not by sending a message saying “Task completed.” One exception is for long-running tasks that the user may have forgotten about.


## Errors and failures
Strive to prevent error messages by keeping the user from entering an error or failure state in the first place. Only accept data in structured input fields, validate inputs before entry, and automatically recover from internal failures.

See the following table for how to express errors to the user, in decreasing order of preference:

Message type                                                                        | When to use
------------------------------------------------------------------------------------|-------------
None; the error condition is made impossible or the software recovers automatically | Always preferred
Description of what went wrong with some kind of “Fix it” action                 | When the “Fix it” action is not universally desirable or has consequences the user must be notified about
Description of what went wrong and how the user can proceed                         | When it's technically infeasible to offer a “Fix it” action
Only a description of what went wrong                                               | Never
Only technical gibberish                                                            | Never ever
Silent failure                                                                      | Never ever ever

**All error messages must be actionable.** Tell the user in plain language what happened and what they can do to either fix it, or at least move forward somehow. Be explicit and don't assume knowledge of the system's inner workings or support resources! For example, if you expect the user to visit a support forum or submit a bug report, show a link to the appropriate location in the UI displaying the error message.

Ensure that failures originating with third-party software or web services are communicated to the user as such. Never let the user blame your app for a problem that's outside of your control!


## Color
Anything colorful will stand out visually, so use it strategically to attract the user's attention. Don't overdo it; when many UI elements are colorful, the user's attention will be pulled in multiple directions.

- [HighlightedTextColor](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1PlatformTheme.html#aaaa6079586261ff972afaa8d3495c66d)/[HighlightColor](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1PlatformTheme.html#a2bd2ec37029686d63963d9a686889469) color (blue by default): highlighted list or grid items, checked controls, benign and ignorable text
- [NeutralTextColor](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1PlatformTheme.html#a0fff6168eb9642a245dfbc7cb7964350)/[NeutralBackgroundColor](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1PlatformTheme.html#a6eaafd30163a444f173cd82fc1356847) (orange by default): warning or alert text/areas, non-default settings states
- [NegativeTextColor](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1PlatformTheme.html#a49b47cb9e9ac3cade27e60a7d59fc3b9)/[NegativeBackgroundColor](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1PlatformTheme.html#a3dacef3051da2e210d2f65ac5e4b8863) (red by default): error text/areas, dangerous actions

Don't rely on color alone to convey meaning or invite action; also use different icons, shapes, or text.


## In-app notifications
Avoid sending system notifications while your app's main window is in the foreground, as they can appear where the user is not looking. Instead use one of the following:

- For ignorable or low-importance messages, use [Kirigami.PassiveNotification](https://api.kde.org/frameworks/kirigami/html/classAbstractApplicationWindow.html#a8ab455ab09378a016c34f467653760e5).
- For messages that should get the user's attention but not interrupt their current task, add a [Kirigami.InlineMessage](https://develop.kde.org/docs/getting-started/kirigami/components-inlinemessages/). If the message's scope is specific to the whole page or application, add it to the page header with the [position](https://api.kde.org/frameworks/kirigami/html/classorg_1_1kde_1_1kirigami_1_1templates_1_1InlineMessage.html#a2711f84c2a4c7f984a0be88cd4e95596) property set to `InlineMessage.Position.Header`.


## System notifications
Use [system notifications](https://api.kde.org/frameworks/knotifications/html/classKNotification.html) sparingly. Excessive notifications drive users crazy.

Only send notifications when your app is in the background and needs to inform the user about about actionable events such as the progress of ongoing jobs, incoming communications from other people, or hardware issues such as running low on battery power. Never use notifications to bug the user about expected events, advertise new features, or prompt the user to promote the app.

Give an [urgency level](https://api.kde.org/frameworks/knotifications/html/classKNotification.html#ae4d50824cf6d70132bf6280ad9357012) to each notification: Low, Normal, or Critical. Strongly consider not sending Low importance notifications in the first place. Give the [persistent](https://api.kde.org/frameworks/knotifications/html/classKNotification.html#a61b63788f43bfad07f6e34b4d768703e) flag to normal-priority notifications that are not critical, but that the user should not miss anyway. Critical notifications always remain visible until dismissed.


## Task Manager badges and progress bars
For infrequent yet long-running tasks, also display the completion percentage on the app's Task Manager background using [setBadgeNumber](https://doc.qt.io/qt-6/qguiapplication.html#setBadgeNumber) on your `QApplication`/`QGuiApplication`. Only use this to show completion percentage for jobs and tasks the user has explicitly initiated.

Task Manager badges can also display a number using the [same D-Bus interface](https://wiki.ubuntu.com/Unity/LauncherAPI#Low_level_DBus_API:_com.canonical.Unity.LauncherEntry). This can be used to show a count of unread messages or open tasks. Only include actionable tasks in the number; users want to get rid of it!


## System Tray icons
System Tray icons can be annoying to users, who generally expect apps to quit when their windows are closed. The status monitoring functions typically provided by System Tray icons are better implemented with deeper system integration:

- Task Manager badges can show a count of unread messages.
- Task Manager progress bars and system notifications can show job progress.
- System notifications can display new messages and status changes.

If your app runs primarily as a background service with any UI or window  being of secondary importance, consider writing a [Plasma Widget]({{< relref "widget" >}}) instead of a standalone app.

Only implement System Tray icons as a last resort, and always follow these rules:

- Also implement any of the system integrations mentioned above that make sense.
- Make the tray icon opt-in, not opt-out.
- Make the tray icon visible only when there is abnormal status to report and the app is not showing a window—not 100% of the time.
