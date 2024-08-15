---
title: "Simple by default"
weight: 3
aliases:
- /hig/patterns-content/placeholder/
---

Focus on the core experience for new users using the default settings. Future experts begin as novices; don't scare them away before they find your app's powerful features!

Multiple techniques are used to make your app friendlier and more usable for people using it for the first time, or at a basic level of technical skill:


## Be welcoming, not demanding or baffling
Show something actionable when the app is first launched, and guide the user through the app's initial or primary interaction flow. Don't waste the user's time by requiring them to hunt around for the obvious “next step” or make a decision about something they don't understand yet.

Examples of guided workflows:

- In a content creation app, show a blank canvas if it's obvious how to add content to it. This works well in writing and artistic apps. If the content created in the app is more complex than an untrained user would understand (e.g. circuit design or 3D modeling), prompt the user to go through a tutorial or new content creation wizard so they can get up to speed quickly.
- In a content consumption app, show a placeholder message to open a file, point to a folder full of files, or otherwise get the user's content into the app. If there are no privacy concerns, show a list or grid of recently-accessed content.
- In an app like a chat or email client that's largely a front-end for an online service, show a placeholder message briefly introducing the service and prompting the user to log into their account for it, or create one. Remember the account's credentials using [KWallet](https://api.kde.org/frameworks/kwallet/html/classKWallet_1_1Wallet.html) and log the user in automatically on subsequent launches.
- In a utility app, show the UI for the primary function as simply and obviously as possible without making the user configure anything or hunt for the “do it” button.

Use [Kirigami.PlaceholderMessage](https://develop.kde.org/docs/getting-started/kirigami/components-scrollablepages_listviews/#placeholdermessage) to display placeholder messages in empty views. Include an icon, explanation text, and ideally a [helpfulAction](https://api.kde.org/frameworks/kirigami/html/classorg_1_1kde_1_1kirigami_1_1PlaceholderMessage.html#a24e24f7bc94d7bd0ddb6cc708d454c22) button the user can click on to proceed or add content to the view.

For specialized apps or features that are unfamiliar to a normal person, write a sentence or two of text explaining what the app or feature is used for. This message can go in the app's placeholder content in an otherwise empty view, or at the top of a page that's full of controls.

<!-- TODO: Picture of explanation messages here -->

Only use a first-run wizard in a complex app, for one of the following:
- To perform mandatory and unskippable setup actions that must be done before the app can be used.
- As an optional and skippable teaching tool.

Don't ask the user to express preferences or make decisions about optional settings in a wizard, or implement one for a simple to medium-sized app.


## Optimize common workflows
Don't make the user do unnecessary work to use your app. Anticipate what the user is likely to do next and offer that. For example:

- In cases where the user needs to choose a device to use from a set of many, pre-select the last-used device or the one most likely to be useful, instead of asking the user to explicitly choose a device every time before they can proceed. If there is only one available device, skip this step entirely.
- When the user asks to compose a new email, if the clipboard's top item is an email address, pre-populate the “To:” field with that address.
- Allow the user to rename files and folders inline, rather than with a separate modal dialog box.


## Show the most important UI elements
New users will judge your app based on what they can see. Optimize the post-launch experience to guide the user through the app's primary workflow.

Keep it simple: don't bombard the user with extraneous UI controls that aren't interactive or relevant in their current context, and avoid button overload. Consider the following techniques to reduce visual complexity without reducing functionality:

- Condense related buttons into a single one that opens a menu.
- Group related features or controls and put them on separate pages.
- In Kirigami apps, use [Page actions](https://api.kde.org/frameworks/kirigami/html/classorg_1_1kde_1_1kirigami_1_1Page.html) and [Context Drawers](https://develop.kde.org/docs/getting-started/kirigami/components-drawers/#context-drawers) which show only actions contextually relevant to the visible content.
- In QtWidgets apps, use [KConfigWidgets::KHamburgerMenu](https://api.kde.org/frameworks/kconfigwidgets/html/classKHamburgerMenu.html) to provide a curated list of the most important actions.

Determine which functionality is most important to your app and keep it visible by default; don't hide it behind menus, controls that appear on hover, keyboard shortcuts, or gestures. Any actions exclusively available via one of these means must be of low importance, because less experienced users will frequently miss them.


## Optimize launch time and UI responsiveness
Make your app lightning fast or new users will lose interest quickly.

Display a progress indicator for tasks that take longer than a second. If the progress is inherently indeterminate, use a [QtQuick.Controls.BusyIndicator](https://doc.qt.io/qt-6/qml-qtquick-controls-busyindicator.html); otherwise use [Kirigami.LoadingPlaceholder](https://api.kde.org/frameworks/kirigami/html/classLoadingPlaceholder.html) for progress that is always determinate or can vary between determinate and indeterminate.

Prefer determinate progress indication when an exact count of remaining tasks or time is known. Here technical jargon in the text is acceptable: accurate details can be used for debugging purposes, and also convince the user that the app is still doing something. If an exact count of remaining tasks or time is not known, use the indeterminate variant.


## Be consistent
New users learn software by relying on consistent visual cues from other software: what a button looks like and how it behaves, where menus can be found, what sidebars are used for, and so on. If they use other KDE apps, they've developed a general sense of “how KDE apps work.” Make use of this knowledge! Other similar well-designed apps are a good precedent to follow.

Avoid custom styling and minimize the use of custom components. Adhere to standards:

- Standard [colors](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1PlatformTheme.html) that pull from the user's active color scheme
- Standard [icon sizes](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Units.html#a7e729a19d3cdd6107828dcfc14950706)
- Standard [spacing units](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Units.html#ab05463c4e6cedd3b811aef8ff0b2cae9) for spacing
- Standard [durations](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Units.html#a35cef4114fd40bcc8a425dab44f5fedb) for animations


## Use sensible defaults
Optimize default settings for new users unfamiliar with the app, and consider what kind of expectations they'll be bringing along so you can cater to them. Seek inspiration from other apps with similar functionality.

Make sure the app's main window is large enough to show its UI labels and controls with no elision or overflow menus. Don't keep running in the background as a System Tray icon when closed.

Integrating into other desktop environments is a virtue, but don't sacrifice integration or visual fidelity within Plasma in cases where the two goals conflict irreconcilably.


## Maximize safety
Guide the user towards making good decisions, and either prevent them from making bad ones, or at least warn them of the consequences. Make the user feel like they know where they are and how to get back to safety when they feel confused or overwhelmed.

The easier something is to remove from the app, the easier it should be to get it back. Use menus or sub-pages to hide features that destroy data or difficult-to-restore content so they can't be triggered by a stray click, or else use a confirmation dialog. Move files to the trash, don't delete them immediately.

Offer an undo for every action that removes content not trivial to re-add. For cases requiring immediate deletion, employ a deferred deletion approach by postponing the underlying delete operation until after the user has dismissed the option to undo it.

Make the UI for undo actions dismissable and non-modal so it doesn't annoy the user. A [Kirigami.PassiveNotification](https://api.kde.org/frameworks/kirigami/html/classAbstractApplicationWindow.html#a8ab455ab09378a016c34f467653760e5) automatically disappears after a few seconds, and is good for cases where losing the option to undo is not catastrophic. A [Kirigami.InlineMessage](https://develop.kde.org/docs/getting-started/kirigami/components-inlinemessages/) does not disappear automatically and is better for truly destructive actions such as deleting files.

Finally, use [standard iconography for destructive actions]({{< relref "icons/#icons-for-destructive-actions" >}}).


## Remember history
Always remember the window size and position (on X11) when your app is re-opened.

In many apps, it also makes sense to remember the active view, set of open files, and scroll positions within documents. For example:

- In large project-based apps where re-creating the project state is time-consuming.
- In file-based apps where the user is likely to continue using the same file over multiple sessions (e.g. a word processor or spreadsheet app).

Don't remember state and open files in small utility apps or apps where the user is likely to open a different one every time they use it—for example video players and PDF document viewers. In such apps, instead show the user a list or grid of recently-opened files generated using [KRecentDocument](https://api.kde.org/frameworks/kio/html/classKRecentDocument.html) so they can quickly return to them if needed. When allowing the user to open files in ways that bypass the standard Open dialog, manually add them to the recent files list using `KRecentDocument`.
