---
title: "New HIG"
description: "Proposal of new Human Interface Guidelines"
---

# Introduction


## What the HIG is
Welcome to the KDE Human Interface Guidelines! Following them will help you build a beautiful and powerful app that feels at home in a KDE environment, and works well outside of it. Users will learn how to use it quickly, accomplish their goals with ease, and encounter fewer issues requiring support.

This document covers KDE's design philosophy and culture, common workflows and patterns, standard user interface conventions, and recommendations for platform integration.


## What the HIG isn't
The HIG is a set of design guidelines, not instructions for implementing every specific component. While some technical guidance will be provided, much more detail can be found in components' own [usage](https://develop.kde.org/docs/) and [API](https://api.kde.org/) documentation as well as the [source code of existing KDE apps](https://invent.kde.org/explore/groups?sort=name_asc). It's more of a *what* and a *why*, not a *how*.

This document is not intended to be an ironclad law code. By learning and following the rules, you'll understand how to safely innovate within the guidelines, and when it can be appropriate to break them if it produces a superior result.


## What is design?
Design determines how well something fulfills its functional purpose, and how enjoyable it is to interact with. If either is lacking, the result will be frustrating. People won't want to use a poorly-designed app, and if forced to, they'll be resentful and spread negativity about it. Avoid this through good design!

Design is about targeted decisions and trade-offs that bring a project closer to its intended goals and usage paradigms. The best apps know which users and use cases they're targeting, and which ones they leave for others. It's better to succeed by focusing on what you can do well than to spread yourself thin and fail. Under-promise and over-deliver, never the reverse.




# What makes a KDE app a KDE app?

## Philosophy and target user groups
- **Guided common workflows:** KDE apps endeavor to offer a good user experience for casual users. The app's 80% common use case should be simple and obvious, with guidance and feedback appropriate for non-experts.
- **Customization supports diversity:** KDE apps can be customized with the primary goal of allowing of people with diverse workflows and functional preferences to use them. A secondary goal is satisfying people with diverse and subjective aesthetic preferences.
- **Not afraid to grow:** KDE apps don't limit themselves to being small and single-purpose. Within the scope of their design domain, they are comfortable appealing to ever-growing numbers of experts by evolving over time to offer powerful features and user-directed extensibility.

Together these characteristics embody KDE's central principle: **Simple by default, powerful when needed**. A KDE app's target user group therefore stretches from people with basic technical knowledge all the way to experts and professionals. People with no technical knowledge are de-prioritized. Don't be afraid to pick your users.

All KDE apps are built with [Qt](https://www.qt.io/) and [KDE Frameworks](https://develop.kde.org/products/frameworks/), plus one of Qt's graphical user interface (GUI) toolkits.


## Development technologies
- [QtWidgets](http://doc.qt.io/qt-5/qtwidgets-index.html) is the original way of writing GUI applications with Qt. It is best suited for traditional desktop applications with complex interfaces, e.g. KDevelop.
- [QtQuick](https://wiki.qt.io/Introduction_to_Qt_Quick) with [Kirigami](https://develop.kde.org/docs/getting-started/kirigami/) constitute the modern way of developing GUI Qt applications. They feature hardware-accelerated rendering, [declarative](https://en.wikipedia.org/wiki/Declarative_programming) UI design, and better support for animations, touch, and gestures. [Kirigami](https://develop.kde.org/docs/getting-started/kirigami/) is KDE's convergent UI toolkit that extends QtQuick with higher-level controls that conform to KDE's HIG and adapt to the device's form factor. This makes it easy to build an app that looks and works great everywhere.

KDE recommends using QtQuick with Kirigami when writing a new application. GUI code examples throughout the HIG will use QtQuick and Kirigami components.


## Convergence and responsiveness
The best KDE apps adapt fluidly to whatever device form factor they're run on. Follow these general guidelines:

- Desktop apps can be scaled down to work on tablets and 2-in-1 laptops in tablet mode by making small UI elements larger and hiding menubars. This state can be detected by reading the value of [Kirigami.Settings.tabletMode](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Settings.html#ad0e5d3914e8a36983e44a3bd35a9528f).
- Phones (even large ones) need an optimized mobile UI; do not just scale down a desktop UI. Detect that the app is running on a phone by reading the value of [Kirigami.Settings.isMobile](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Settings.html#abae81b4f287d9a96a44e1953f9833596).

Setting the `QT_QUICK_CONTROLS_MOBILE=1` environment variable will let you run your app in a simulated mobile mode.

[Kirigami.GlobalDrawer](https://develop.kde.org/docs/getting-started/kirigami/components-drawers/#global-drawer) is a useful component for convergent apps. On the desktop it looks like a menu, while on mobile, it looks like a pull-out drawer of actions. [Kirigami.ContextDrawer](https://develop.kde.org/docs/getting-started/kirigami/components-drawers/#context-drawers) is the same but for contextual actions relevant only for individual pages.

In addition, app window sizes may vary significantly even on the same form factor. It's important for the app's window content and UI to adapt in sane and sensible ways when maximized, tiled, or otherwise used at a different size or shape than how it was originally designed.




# Simple by default
Focus on the core experience for new users using the default settings. Future experts begin as novices; don't scare them away before they find your app's powerful features!

Multiple techniques are used to make your app friendlier and more usable for people using it for the first time, or at a basic level of technical skill:


## Be welcoming, not demanding or baffling
Show something actionable when the app is first launched. Don't require the user to make a decision about something they don't understand yet, or present them with a blank view with no obvious next step. Don't waste the user's time.

Use [Kirigami.PlaceholderMessage](https://develop.kde.org/docs/getting-started/kirigami/components-scrollablepages_listviews/#placeholdermessage) to display placeholder messages in empty views. Include an icon, explanation text, and ideally a [helpfulAction](https://api.kde.org/frameworks/kirigami/html/classorg_1_1kde_1_1kirigami_1_1PlaceholderMessage.html#a24e24f7bc94d7bd0ddb6cc708d454c22) button the user can click on to proceed or add content to the view.

For apps or features that are specialized and not necessarily familiar to a normal person, don't be afraid to write a sentence or two of text explaining what the app or feature is used for. This can go in the app's welcoming placeholder content in an otherwise empty view, or at the top of a page that's full of controls.

[TODO: Picture of explanation messages here]


## Show the most important UI elements
New users will judge your app based on what they can see. Optimize the post-launch experience to guide the user through the app's primary workflow.

Don't bombard the user with extraneous UI controls that aren't interactive or relevant in their current context. Avoid button overload. Consider the following techniques to reduce visual complexity without reducing functionality:

- Condense related buttons into a single one that opens a menu.
- Use UI elements that show only actions contextually relevant to the visible content.
- Group related features or controls and put them on separate pages.

Don't hide important functionality behind right-click context menus, gestures, controls that appear on hover, or keyboard shortcuts. Any actions exclusively available via one of these means must be very low importance, because less experienced users will frequently miss them.


## Optimize launch time and UI responsiveness
Make your app lighting fast or new users will lose interest quickly.

Any task that doesn't complete in under a second should display detailed progress information using [Kirigami.LoadingPlaceholder](https://api.kde.org/frameworks/kirigami/html/classLoadingPlaceholder.html) that explains *exactly* what the app is doing. Here technical jargon is acceptable: accurate details can be used for debugging purposes, and also convince the user that the app is still doing something.


## Be consistent
New users learn software by relying on consistency-based visual cues from other software: what a button looks like and how it behaves, where menus can be found, what sidebars are used for, and so on. If they use other KDE apps, they've developed a general sense of "how KDE apps work." Make use of this knowledge! Other similar well-designed apps are a good precedent to follow.

Avoid custom styling and minimize the use of custom components. Adhere to standards:

- Standard [icon Sizes](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Units.html#a7e729a19d3cdd6107828dcfc14950706)
- Standard [spacing units](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Units.html#ab05463c4e6cedd3b811aef8ff0b2cae9) for spacing
- Standard [durations](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Units.html#a35cef4114fd40bcc8a425dab44f5fedb) for animations


## Use sensible defaults
Optimize default settings for a new user of the app, not someone who's used it for years. Consider what kind of expectations a new user will be bringing along, and cater to them.

Make sure the main window is large enough to show its UI labels and controls with no elision or overflow menus. Don't keep running in the background as a System Tray icon when closed.


## Maximize safety
Guide the user towards making good decisions, and either prevent them from making bad ones, or at least warn them of the consequences. Make the user feel like they know where they are and how to get back to safety when they feel confused or overwhelmed.

The easier something is to remove from the app, the easier it should be to get it back. Use menus or sub-pages to hide features that destroy data or difficult-to-restore content so they can't be triggered by a stray click, or else use a confirmation dialog. Move files to the trash, don't delete them immediately.

Offer an undo for every action that removes content not trivial to re-add. When things do need to be immediately deleted or removed, implement it in a sneaky way by not actually performing the underlying deletion operation until after the user has dismissed the option to undo it.

The UI for undo actions should be non-modal so it doesn't annoy the user. A [Kirigami.PassiveNotification](https://api.kde.org/frameworks/kirigami/html/classAbstractApplicationWindow.html#a8ab455ab09378a016c34f467653760e5) automatically disappears after 7 seconds, and is good for cases where losing the option to undo is not catastrophic. [Kirigami.InlineMessage](https://develop.kde.org/docs/getting-started/kirigami/components-inlinemessages/) does not disappear automatically and is better for truly destructive actions such as deleting files.

Finally, use [standard iconography for destructive actions](TODO: Link to relevant Icons section).


## Remember history
Show what the user saw the last time they used the app after they re-open it later: same document, same view, same window size, same scroll position--everything! On X11, remember the window position, too.

There are some exceptions, including viewer apps for images, videos, and documents, which are typically used to open different files every time. Context will dictate whether remembering the last-opened file makes sense or not. In cases where it's inappropriate, instead show the user a list or grid of recently-opened files so they can quickly return to them if needed.




# Powerful when needed
While KDE apps can certainly be simple and opinionated, they aren't afraid of providing power-user functionality when needed--suitable for demanding users, experts, and professionals.

Note that this is not a hard requirement. Remember "when needed."


## Customization increases reach
The primary purpose of options and settings is to make the software more usable for different types of users with strong workflow preferences. These users are important because they are thought leaders, influencers in their communities, and potential future contributors to your app!

The best options for this purpose allow the user to switch between multiple supported behaviors or workflows, each explicitly benefiting a certain type of person. Options to simply enable or disable a feature entirely are warning signs of sloppy design.

Visual customization is of secondary importance. As much as possible, defer to the platform's own visual styling conventions and theming tools. This allows users with strong aesthetic preferences to do theming at the system level, and their apps will all respond accordingly.

Apply newly-saved settings immediately; don't require re-launching the app.

Don't use customizability to avoid making design decisions, work around your own bugs, or "because KDE is all about customization." The more options your app presents, the more frustrated users will become when it doesn't have exactly the one they're looking for.

Don't use customizability to override platform settings or styling, with one exception: when the app is used on a platform without that global setting, it can be exposed as an app-specific setting.

Use [Kirigami.FormLayout](https://api.kde.org/frameworks/kirigami/html/classFormLayout.html) to build your configuration pages.


## Accelerators for experts
Expert users love to speed up their tasks with keyboard shortcuts and context menus, so make sure to implement them! But always remember that these are *accelerators;* no functionality should only be available via keyboard shortcut or context menu.

Every action that can be performed should either have a keyboard shortcut assigned to it by default, or at least let the user assign one themselves. For common, standard actions, use the shortcuts provided by [KStandardShortcut](https://api.kde.org/frameworks/kconfig/html/namespaceKStandardShortcut.html).

Only implement two-finger gestures in your app. Three- and four-finger gestures can conflict with gestures provided by the system.

Don't use the `Meta` key for app-specific shortcuts; this is reserved for global shortcuts.


## User-driven extensibility
The best KDE apps are modular, with functionality provided through plugins. This allows users to self-satisfy rather than asking the developers for new features.

KDE Frameworks include the [KNewStuff](https://invent.kde.org/frameworks/knewstuff) system for getting and managing user-provided 3rd-party content from https://store.kde.org or any other [Open Collaboration Services](https://en.wikipedia.org/wiki/Open_Collaboration_Services) server. Using KNewStuff, users can get new content and functionality. Make sure to warn users that this content represents a digital Wild West with no assumptions of stability or safety!




# Basic layout and navigation
Most KDE apps have a "Tools Area" on top consisting of the window titlebar and a toolbar below it. The toolbar typically shows actions contextually relevant to what's shown in the content view below it. In very powerful and complex desktop apps, a menubar is often added between the titlebar and toolbar. Its contents are always static, showing all possible actions with contextually irrelevant ones disabled rather than hidden.

[TODO: Pictures of Dolphin, Merkuro, and System Monitor]

If the app's workflow or navigation pattern is completely linear, use the standard [PageStack](https://develop.kde.org/docs/getting-started/kirigami/components-pagerow_pagestack/) mechanism built into Kirigami, with breadcrumbs and back/forward buttons in the header for navigation.

If the app's navigational flow is non-linear or has many possible top-level destinations, implement a dedicated navigational control to let the user jump from one destination to another.

When the potential top-level destinations are static and number 5 or fewer, use a [Kirigami.NavigationTabBar](https://develop.kde.org/hig/components/navigation/navigationtabbar/). It can be placed below or to the left of the content view, depending on what makes the most sense.

[TODO: Picture of KClock]

Otherwise use a sidebar on the left side of the window, with the main content view on the right:

[TODO: Picture of Discover or Elisa]

Regardless of which navigational control is used, place the most important or commonly-accessed destinations on the top or the left side.

When a content view needs additional controls specific to it, add them in the header of the page showing the content:

[TODO: Picture of the colors KCM or maybe Elisa]

Many KDE apps also feature auxiliary "Contextual Toolviews." These can show previews or information about what's displayed or selected in the main content area, or extra tools to interact with it.

[TODO: Picture of Kate, Dolphin, or Partition Manager]

Show these views in addition to the global-scope navigation UI; don't replace it. The only exception is when the navigation view is itself already contextual (e.g. a thumbnail view for the open document in a PDF reader app); in this case the contextual navigation can be integrated into a tabbed/multi-view sidebar that shows different contextual views for the visible content.

[TODO: Picture of Gwenview or Okular's tabbed sidebar]

Don't use underlined web-style links for internal navigation within your app; only use these for actual URLs. By the same token, only use the pointing finger cursor for hovering over a URL link. Use alternative means of showing that hovered items are clickable, such as changing their background or outline color.



# Displaying content
Maximize the space available for content; it's what users open your app to interact with! Avoid unnecessary frames, spacing, and padding around content views. Make them take up the entire window, with the exceptions of the Tools Area and any navigation UI or Contextual Toolviews.


## Page vs OverlaySheet
[Kirigami.OverlaySheet](https://api.kde.org/frameworks/kirigami/html/classorg_1_1kde_1_1kirigami_1_1templates_1_1OverlaySheet.html) is used to browse auxiliary views of narrow content that's taller than the screen space. Don't use it for getting input. And if the content is very wide, put it on a separate page instead.


## Lists and grids
When a view's content consists of multiple items that can be seen or interacted with, display them in a [QtQuick.ListView](https://doc.qt.io/qt-6/qml-qtquick-listview.html) or a [QtQuick.GridView](https://doc.qt.io/qt-6/qml-qtquick-gridview.html). Which one to choose depends on the context:

- Lists are faster to visually scan and scroll through, and handle long text better. They tend to be better for mostly-textual content. Use [alternating background colors](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1PlatformTheme.html#afd4bbd60d2d32ff0c788e95b998889f2) for list items with subtitles or extra items on their right sides.
- Grids make better use of space when the view is wide, items are large, or scrolling is undesirable. They tend to be better for mostly-visual content.

Depending on the context, it can be reasonable to let the user pick their preferred representation, or even to automatically switch from one to another based on the width of the window.

List and grid Delegates should use or be subclasses of one of the [standard `QtQuick.Controls` Delegates](https://doc.qt.io/qt-6/qtquickcontrols-delegates.html), which lets them inherit the common KDE styling. If the content is more complex than what these Delegates provide, override the `contentItem` with one of the pre-made [Kirigami Delegates], or roll your own if none of these are sufficient.

Controls used to add content to list or grid views should be added in the form of [Kirigami.Actions](https://develop.kde.org/docs/getting-started/kirigami/components-actions/) to a [Kirigami.InlineViewHeader](https://api.kde.org/frameworks/kirigami/html/classInlineViewHeader.html).

Controls used to remove list or grid items should be placed inline, on the items themselves.

Text for the selected or actively-used list or grid delegate should be bold.


## Tabbed views
It's often useful to let the user open multiple content views at a time and switch between them using a [QtQuick.Controls.TabBar](https://doc.qt.io/qt-6/qml-qtquick-controls-tabbar.html). Tabs should always be above the content view, be re-orderable, show visible close buttons, and use [standard keyboard shortcuts for switching](https://api.kde.org/frameworks/kconfig/html/namespaceKStandardShortcut.html#a9262eb609e9ad994d7b913eb715e004e).

TODO: Expanding or not?

TODO: Mention the "add new tab" button? Is it needed?

Tab views tend to scale poorly beyond 8 or 9 tabs. If the user is expected to regularly interact with more than this, consider a different switching control such as a sidebar.

Only use a tab bar for switching between content views; use a [Kirigami.NavigationTabBar](https://develop.kde.org/hig/components/navigation/navigationtabbar/) for switching between settings pages or views of a Contextual Toolviews. This control can be above or below its view.


## Tables and tree views
Use a [QtQuick.TableView](https://doc.qt.io/qt-6/qml-qtquick-tableview.html) to display lists of items with 3 or more pieces of data per list item, where being able to quickly compare the data across list items makes sense. Put each piece of data in its own column.

If you would ever end up with a table that has only two columns, or where sorting or reversing the order of any column does not make sense, instead use a list view.

Minimize the use of tree views, as they tend to be confusing for regular users--especially if they allow more than one level of nesting. Instead, consider a list view with collapsible sections.

Only use a tree view in an app meant for technical users where the content being shown already has an inherent tree-like structure (e.g. a tree of system processes).


## Inline help and tooltips
Sometimes complex features require explanation, even for experts. The appropriate place for this explanation will depend on its length and purpose. If the text is important for the user to understand and can be kept very short, place it inline below the control it affects:

[TODO: Picture of the single/double click setting]

If it requires up to two sentences and can broadly describe a whole page's worth of content, place the text inline, at the top of the page:

[TODO: Picture of the Night Color explanation]

If there is no space in the current context (e.g. for a menu item), place the text in a tooltip.

**Warning message box thingy** Don't put any truly important text in a traditional tooltip because this component is either unusable or unintuitive for touchscreen users, and even mouse/touchpad users are often not in the habit of hovering the cursor over everything to see if there's a tooltip.

If the tooltip's text is longer than a sentence, or it's important that the user reads it, use a [Kirigami.ContextualHelpButton](TODO: Move to Kirigami and link to its API docs there). Using this component can also be a good idea even for shorter explanations if the UI would otherwise look overrun with multiple inline descriptions.

[TODO: Picture of the KScreen KCM]

Users don't read manuals for apps of low or even moderate complexity, so don't bother to provide them. If the UI of such apps is too complex to understand even with inline help text, the user will delete your app and find another one rather than turning to the manual. Spend your time improving the app's UI instead.

Manuals and formal documentation are acceptable for highly technical and specialized professional apps (video editing, image manipulation, CAD, etc.) that may be incomprehensible without any prior technical training.




# Getting input

## Controls ##
KDE apps mostly use standard input controls such as [buttons, menus, checkboxes, text fields, and sliders](https://develop.kde.org/docs/getting-started/kirigami/components-controls/). There are some rules to keep in mind beyond the basics:

- Use a [Switch](https://doc.qt.io/qt-6/qml-qtquick-controls-switch.html) for "Instant apply" settings that take effect immediately. Otherwise use a [CheckBox](https://doc.qt.io/Qt-6/qml-qtquick-controls-checkbox.html).
- Use [RadioButtons](https://doc.qt.io/qt-6/qml-qtquick-controls2-radiobutton.html) for sets of 3 or fewer mutually-exclusive options with short text. Otherwise use a [ComboBox](https://doc.qt.io/qt-6/qml-qtquick-controls-combobox.html).
- Use a flat [ToolButton](https://doc.qt.io/qt-6/qml-qtquick-controls-toolbutton.html) on a toolbar in the app's Tools Area, Contextual Toolview, or a page header or footer--basically anywhere users expect to encounter toolbars. When used elsewhere, `ToolButtons` can be mistaken for non-interactive decorations.
- Use a regular raised [Button](https://doc.qt.io/qt-6/qml-qtquick-controls-button.html) in the main content area, including settings pages and inside list and grid view items.
- Use a [RoundButton](https://doc.qt.io/qt-6/qml-qtquick-controls-roundbutton.html) for covering up part of the content area not already covered by any kind of opaque or semi-transparent background. These kinds of buttons never have text, so choose an icon that conveys the button's action perfectly.


## Dialogs
For opening and saving files, use  [QtQuick.Dialogs.FileDialog](https://doc.qt.io/qt-6/qml-qtquick-dialogs-filedialog.html) with the [fileMode](https://doc.qt.io/qt-6/qml-qtquick-dialogs-filedialog.html#fileMode-prop) set appropriately. Don't implement a custom file-choosing UI.

Try to use the least intrusive type of dialog for getting other kinds of input. Only use a modal [KMessageDialog](https://api.kde.org/frameworks/kwidgetsaddons/html/classKMessageDialog.html) when the app cannot proceed without getting a specific answer from the user.

Otherwise, use one of the Kirigami `Dialog` types, which can be safely dismissed by clicking outside of them to trigger their "cancel" or "don't do anything" behavior.

- Use a [Kirigami.PromptDialog](https://api.kde.org/frameworks/kirigami/html/classPromptDialog.html) for a "do it/don't do it" type of choice.
- Use a [Kirigami.PromptDialog](https://api.kde.org/frameworks/kirigami/html/classPromptDialog.html) with a [QtQuick.Controls.TextField](https://doc.qt.io/qt-6/qml-qtquick-controls-textfield.html) inside it to get text input from the user.
- Use a [Kirigami.MenuDialog](https://api.kde.org/frameworks/kirigami/html/classMenuDialog.html) to let the user choose from among a set of actions.


## Visible interactivity ##
Standard Breeze styling for controls communicates interactivity primary through hover effects--typically by changing the background or outline color. Keep these guidelines in mind:

- As much as possible, use standard controls so that your apps inherits this style of visual interactivity automatically.
- When custom controls must be used, prefer to override the `contentItem` property of standard controls so that only the content is custom, and the interactivity and styling of the background effect are preserved.
- If even that is not possible, re-implement interactivity signaling using hover effects.

**Good:** Control highlights with an outline

**Bad:** Cursor becomes a pointing finger




# Communicating status changes
Minimize unnecessary status messages. Success should be indicated by something visually changing on the screen; only show a status message when an action failed or something out of the ordinary happened. One exception is when it may not be obvious that an action succeeded because nothing visibly changed on the screen.


## In-app notifications
While your app is running and in the foreground, avoid sending system notifications, as they can appear where the user is not looking. Instead use one of the following:

- For ignorable or low-importance messages, use [Kirigami.PassiveNotification](https://api.kde.org/frameworks/kirigami/html/classAbstractApplicationWindow.html#a8ab455ab09378a016c34f467653760e5).
- For messages that should get the user's attention, but not interrupt their current task, add a [Kirigami.InlineMessage](https://develop.kde.org/docs/getting-started/kirigami/components-inlinemessages/) into the page header with the [position](https://api.kde.org/frameworks/kirigami/html/classorg_1_1kde_1_1kirigami_1_1templates_1_1InlineMessage.html#a2711f84c2a4c7f984a0be88cd4e95596). property set to `InlineMessage.Position.Header`.

**Good:** "Network is unreachable; retrying in 5 seconds"

**Bad:** "Successfully opened the file"


## System notifications
Use [system notifications](https://api.kde.org/frameworks/knotifications/html/classKNotification.html) sparingly. Excessive notifications drive users crazy.

Only send notifications when your app is in the background and needs to inform the user about about actionable events such as the progress of ongoing jobs, incoming communications from other people, or hardware issues such as running low on battery power. Never use notifications to advertise new features or prompt the user to promote the app.

Notifications must be given an urgency: Low, Normal, or Critical. Consider not sending Low importance notifications in the first place. Normal-priority notifications that are not critical, but that the user should not miss anyway, should be marked as persistent. Critical notifications always remain visible until dismissed.

**Good:** "2 new emails"

**Bad:** "Playing next song"


## Task Manager badges and progress bars
For infrequent yet long-running tasks, also display the completion percentage on the app's Task Manager background. [TODO: Link to how to do this]

**Good:** Progress of system updates in Discover

**Bad:** Remaining time for a song playing in a music player

Task Manager badges can also display a number. This can be used to show a count of unread messages or open tasks. Only include actionable tasks in the number; users want to get rid of it. [TODO: Link to how to do this]

**Good:** Number of unread emails

**Bad:** Number of tasks completed


## System Tray icons
Try to avoid implementing a System Tray icon in the first place; users expect their apps to quit when closed, not remain running in the background. When this happens, it's usually unexpected and annoying.

Consider alternative ways to notify the user about status changes:

- Use Task Manager badges to show a count of unread messages.
- Use Task Manager progress bars and system notifications to show job progress.
- Use system notifications to display new messages and status changes.

There is one exception: when your app runs primarily as a background service, and any UI or window it shows is of secondary importance. In this case, a System Tray icon is acceptable, but also consider implementing your app instead as a Plasma widget, not an app.

If you must implement a System Tray icon for an app mostly interacted with through a window, disable the feature by default and make the user opt into it.




# Text and labels
Whenever writing text, start by following these guidelines:

- Make it as short as possible without losing meaning or precision.
- Keep it actionable.
- Front-load the most important information in longer text.
- Use plain language and minimize technical jargon.
- Adhere to common wording conventions.
- Use a neutral, informative tone: not informal, exciting, boring, or harsh-sounding.
- Use the word "Delete" for actions that remove files on disk.
- Don't overuse bold text and pull the user's attention in multiple directions at once.

And then keep in mind these implementation details:

- Use [QtQuick.Controls.Label](https://doc.qt.io/qt-6/qml-qtquick-controls2-label.html) for normal-sized text, and [Kirigami.Heading](https://api.kde.org/frameworks/kirigami/html/classorg_1_1kde_1_1kirigami_1_1Heading.html) (with a `level` suitable for the context) for larger header text. See [more information here](https://develop.kde.org/docs/getting-started/kirigami/style-typography/).
- Manually assign [accelerator keys](https://doc.qt.io/qt-6.2/accelerators.html) only for text in buttons, radio buttons, checkboxes, and switches (in other places, they are auto-generated).
- Assign text for icons-only buttons anyway, so it can be read by screen readers. Hide the text by setting the [display](https://doc.qt.io/qt-5/qml-qtquick-controls2-abstractbutton.html#display-prop) property to `IconOnly` and then manually add a [tooltip](https://doc.qt.io/Qt-6/qml-qtquick-controls-tooltip.html) for the benefit of mouse and touch users.
- For standard actions, use [KStandardAction](https://api.kde.org/frameworks/kconfigwidgets/html/namespaceKStandardAction.html) so that it gets standard text automatically.


## Capitalization
All user interface text should use either [sentence case](https://apastyle.apa.org/style-grammar-guidelines/capitalization/sentence-case) or [title case](https://apastyle.apa.org/style-grammar-guidelines/capitalization/title-case).

Use sentence case when:

- The text ends with a period or colon
- The text is clearly a sentence
- The text is a subtitle, tooltip, transient status message, or placeholder label
- The text is used as a label for a radio button or checkbox

Otherwise, use title case.

Specialized proper nouns such as "the Internet" or "Plasma Widgets" should be capitalized.

Acronyms (e.g. "URL") should always have all letters capitalized.


## Buttons and menu items
Labels for buttons and menu items should clearly represent *actions* or *locations*:

- **An action makes something happen,** and begins with a verb appropriate to describe the action. If the action is complex and requires additional user input before it completes (most commonly because it opens a dialog that prompts the user to make a further decision), end its label with an ellipsis. Use the real "…" ellipsis character (`U+2026` in Unicode), not three periods.
- **A location is another page, window, or sub-menu** that opens when the user triggers the button or menu item. Make sure the text in the button or menu item matches the title of the new page or window.

Buttons in dialogs also follow these rules. "OK" and "Yes" are never acceptable button labels!

**Good:** Open…

**Good:** Configure Shortcuts…

**Good:** Show More

**Bad:** Yes (unclear what it refers to)

**Bad:** Print (always requires additional input)

**Bad:** Properties… (this is a location, not an action)


## Window titles
Every window needs a distinctive title briefly describing its visible content. This text is shown in multiple parts of the UI where space may be limited, so keep it as short as possible while retaining distinctiveness. Don't include the app's vendor or version number.

**Good:** Inbox - konqi@kde.org

**Good:** Stairway To Heaven, by Led Zeppelin

**Bad:** AppName 5.3.9 Professional Edition, by SquidSoft™

**Bad:** Main Window

Avoid showing file paths, which can be long and hard to parse. In a tab-based app that can have multiple files open, disambiguate identically-named files only by their parent folder names, like this:

```
CMakeLists.txt - library
CMakeLists.txt - app
```

Dialog titles should describe the action being performed starting with a verb, just like button and menu item labels. If the dialog was opened from a button or menu item, echo its label.

**Good:** Save… -> Save File

**Good:** Properties -> Properties for \[file name\]

**Bad:** Load… -> Open File

**Bad:** About -> \[app name\] Details


## Placeholders
Placeholder text is used in empty text fields and empty views. Both share a common purpose: to tell users how to get content into it.

For placeholder messages in empty views, use [Kirigami.PlaceholderMessage](https://develop.kde.org/docs/getting-started/kirigami/components-scrollablepages_listviews/#placeholdermessage).

In empty text fields, use the following rules:

- If the text field has an explanatory label to the left of it, the placeholder text should show an example of the type of text the user is expected to type into it. Placeholder text can be omitted if this is not relevant.
- Otherwise, the placeholder text should be a very short sentence starting with a verb that describes what the user should do: "Search", "Enter file name", etc.
- Don't end with an ellipsis character, as it would contradict the meaning of the character in the context of buttons and menu items.

For search fields, use [Kirigami.SearchField](TODO: fix lack of link in Kirigami API docs) which includes standard placeholder text.


## Translation
Many or even most users won't be using your software in English, so keep translatability in mind:

- Avoid culture-specific references and internet memes.
- Respect system-wide locale settings for units, date and time formats, etc.
- Leave enough room in your UI for strings to become 50% longer or more when translated into languages with longer text than English.
- Use the [i18nc()](https://api.kde.org/frameworks/ki18n/html/prg_guide.html#good_ctxt) function to provide translation context to your strings, and use [KUIT markup](https://api.kde.org/frameworks/ki18n/html/prg_guide.html#kuit_tags) instead of HTML.
- Use the [i18ncp()](https://api.kde.org/frameworks/ki18n/html/prg_guide.html#gen_usage) function for any text that refers to a number, as plurals are handled differently in different languages.
- Test your app in RTL mode by running in in Arabic with `LANGUAGE=ar_AR [app_executable]`. Even if you can't read the words, make sure everything has reversed properly and there's enough room for the text.


## symbols
Use appropriate Unicode symbols rather than handmade approximations. This makes the text of your app look nicer and more professional, easier to translate, and more comprehensible when read by a screen reader. For example:

- `…` (`U+2026`) instead of `...` anywhere ellipses are used
- `→` (`U+2192`) instead of `->`
- `÷` (`U+00F7`) and `×` (`U+00D7`) instead of `/` and `x` in mathematical expressions
- `“` (`U+201C`) and `”` (`U+201D`) instead of `"` for quotations
- `’` (`U+2019`) instead of `'` for apostrophes
- `—` (`U+2014`) instead of `-`, ` - `, or `--` for [interjections](https://www.merriam-webster.com/grammar/em-dash-en-dash-how-to-use)

KDE's [KCharSelect](https://apps.kde.org/kcharselect) app can be used to find these and other symbols.




# Icons
KDE apps respect the [FreeDesktop icon theme standard](https://specifications.freedesktop.org/icon-theme-spec/latest/) and make extensive use of themable icons. Start by following these guidelines:

- Set an icon on every button and menu item.
- Don't use the same icon for multiple UI elements that are visible at the same time.
- Only icons beginning with `emblem-` should be overlaid directly on top of user content or other icons, as they are designed for this.
- Icons on parent menu items or buttons that open menus should use symbolism relevant to all child menu items.

And then keep in mind these implementation details:

- Don't bundle custom icons with your app or specify pixmaps for your icons. Instead get them from the system's icon theme using [QIcon::IconFromTheme()](https://doc.qt.io/qt-6/qicon.html#fromTheme-1) in C++ code, or using the `icon.name` property for QML components that accept icons.
- For standard actions, use [KStandardAction](https://api.kde.org/frameworks/kconfigwidgets/html/namespaceKStandardAction.html) so that it gets a standard icon, too.
- Use [standard icon sizes](https://api.kde.org/frameworks/kirigami/html/classKirigami_1_1Platform_1_1Units.html#a7e729a19d3cdd6107828dcfc14950706) in any context where the icon size is not automatically chosen for you.


## Symbolic vs full-color
At small sizes (especially `small` and `smallMedium`), append "-symbolic" to the name of the icon you're asking the icon theme to provide, which causes it to give you a symbolic monochrome icon if it has one. At these small sizes, full-color icons can become visual smudges or contribute to a "heavy" appearance where many are shown in a row or column, so we prefer symbolic ones. Full-color icons are better at `medium` size and larger.

Menu items and standard-sized buttons should always use symbolic icons.

List items should always use symbolic icons at `small` icon size, and *generally* at the default `smallMedium` size too. Context dictates whether this makes sense or not: with only a small number of list items, full-color icons may look better. For large or dense lists, prefer symbolic icons.


## Icons-only buttons
Most buttons should have text. Icons-only buttons should only be used where saving space is critical and their icons use imagery that is common and universal across all operating systems and apps. Examples include:

- go-previous-symbolic
- go-home-symbolic
- search-symbolic
- configure-symbolic
- edit-delete-symbolic
- print-symbolic
- player-volume-muted-symbolic
- media-playback-start-symbolic
- documentinfo-symbolic
- open-menu-symbolic

[TODO: Add pictures of these icons into each list item]

It's also acceptable to use icons-only buttons for actions not relevant to the app's core workflow (where it's not a disaster if the user ignores it) or where groups of related icons reveal each other's meaning by proximity, such as icons-only buttons to choose text justification in a word processing app.

If in doubt, show the button's text. If the app has so many buttons visible at once that this looks overwhelming, rethink the UI. For example:

- Only show buttons relevant to the current context.
- Place buttons in a Contextual Toolview that can be hidden when not relevant.
- Group buttons by function in the tabs of a [Kirigami.NavigationTabBar](https://develop.kde.org/hig/components/navigation/navigationtabbar/).
- Put the buttons on a [Kirigami.ActionToolBar](https://develop.kde.org/docs/getting-started/kirigami/components-actiontoolbar/) so that buttons without sufficient space get moved into an overflow menu.
- Reduce the length of the buttons' labels.
- Condense related buttons into a single one that opens a menu of actions.

To make a button icons-only, hide the text using the [display](https://doc.qt.io/qt-6/qml-qtquick-controls-abstractbutton.html#display-prop) property. Always set the [text](https://doc.qt.io/qt-6/qml-qtquick-controls-abstractbutton.html#text-prop) property.


## Icons for destructive actions
Destructive actions must be consistently indicated as such using icons that are are red or have red elements (in the Breeze icon theme, at least):

- Use a red trash can via the `edit-delete-symbolic` icon for actions that delete files or destroy content the user has created.
- Use a red X via the `edit-delete-remove-symbolic` icon for actions that remove abstract or standard items in a way that's possible to restore later.
- Use one of the more detailed deletion icons (e.g. `delete-comment-symbolic`) only where multiple deletion actions are visible and must be visually disambiguated, or on icons-only buttons where the icon itself has to convey all meaning and the context is not sufficient to indicate what will be deleted.
- Use a black trash can via the `trash-empty-symbolic` icon for moving an item to the trash, and give its button or menu item a label that includes the "move to trash" phrasing.

Avoid the use of icons with red elements or X symbols for non-destructive actions.


## Designing your own icons
Every app needs a great icon. Learn how to make one [here](TODO: link to Breeze colorful icon design docs after they get moved elsewhere).

If you find that you need any new icons within your app that are not already provided by the Breeze icon theme, request it from the KDE visual design group [here](https://bugs.kde.org/enter_bug.cgi?product=Breeze&component=Icons) so that it can be added to the icon theme for the benefit of all, and then you can safely request it using [QIcon::IconFromTheme()](https://doc.qt.io/qt-6/qicon.html#fromTheme-1) or [Kirigami.Icon](https://api.kde.org/frameworks/kirigami/html/classIcon.html).

If you'd like to try your hand at making the icon yourself, read the [Breeze action icon design documentation](TODO: link to action icon design docs after they get moved elsewhere).




# Accessibility
Following this guide will already give you an app that's quite accessible. Nonetheless, it's important to test your app in a way that simulates impairments that you may not possess yourself:

- **Keyboard:** Unplug your mouse or disable your touchpad and attempt to interact with every UI element solely with the keyboard. Make sure the item with default focus makes sense, and each item with active focus looks visibly different from selected items in inactive views. Make sure no truly important text is only seen in a hover tooltip.
- **Pointing device:** Unplug or don't use your keyboard, and attempt to interact with every UI element solely with left-clicks from a pointing device and the virtual keyboard. Verify that all drag-and-drops show a preview of the dragged item and either succeed or show the "can't drag here" cursor.
- **Touchscreen:** If you have a touch-capable device, try using it exclusively. Verify that everything works and that the virtual keyboard appears only at the right times. Verify that hover tooltips also appear on press-and-hold.
- **Color:** Change the system-wide color scheme to something other than what you regularly use to verify that everything adapts as expected.
- **Text size:** Increase the system-wide font size to 14 and verify that visual relationships are preserved and text doesn't get cut off.
- **Audio:** Unplug or mute your speakers and verify that no information is only communicated via audio.
- **Screen Reader:** Turn off your screen and attempt to use the app with the Orca screen reader. It should say something intelligible and distinct for all elements. For GUI elements it should say the label and type, e.g.: "File, Menu" or "Create New Folder, Button". Verify that all tooltip text is read by the screen reader via components `Accessible` properties and that no labels are used more than once in the same window.
- **Animations:** Globally disable animations and verify that all animated UI elements either transition instantly (e.g. for a pushing a new page) or display a static image (e.g. for a loading spinner). Avoid blinking UI elements other than the text insertion point.

See the [Qt accessibility documentation](https://doc.qt.io/qt-6/accessible.html) for more information.
