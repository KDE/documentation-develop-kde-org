---
title: "What makes a KDE app a KDE app?"
weight: 2
aliases:
- /hig/introduction/architecture/
- /hig/introduction/devicetypes/
- /hig/introduction/concept/
- /hig/introduction/research/
- /hig/patterns-command/
- /hig/platform/
---

## Philosophy and target user groups
- **Guided common workflows:** KDE apps endeavor to offer a good user experience for casual users. Make the app's 80% common use case simple and obvious, with guidance and feedback appropriate for non-experts.
- **Customization supports diversity:** KDE apps can be customized with the primary goal of allowing people with diverse workflows and functional preferences to use them. A secondary goal is satisfying people with diverse and subjective aesthetic preferences.
- **Not afraid to grow:** KDE apps don't limit themselves to being small and single-purpose. Within the scope of their design domain, they are comfortable appealing to ever-growing numbers of experts by evolving over time to offer powerful features and user-directed extensibility.

Together these characteristics embody KDE's central principle: **Simple by default, powerful when needed**. A KDE app's target user group therefore stretches from people with basic technical knowledge all the way to experts and professionals.

Users of KDE apps can be expected to be familiar with common user interface design patterns (windows, buttons, menus, list views and tab views, etc.) and able to perform tasks such as searching for data that isn't immediately visible, or writing an email reply to multiple people. Users below this skill level are generally de-prioritized. Don't be afraid to pick your users.

## Development technologies

All KDE apps are built with [Qt](https://www.qt.io/) and [KDE Frameworks](https://develop.kde.org/products/frameworks/), plus one of Qt's graphical user interface (GUI) toolkits:

- [QtWidgets](http://doc.qt.io/qt-6/qtwidgets-index.html) is the original way of writing GUI applications with Qt. It is best suited for traditional desktop applications with complex interfaces, e.g. [KDevelop](https://apps.kde.org/kdevelop/).
- [QtQuick](https://doc.qt.io/qt-6/qmlapplications.html) with [Kirigami](https://develop.kde.org/docs/getting-started/kirigami/) constitute the modern way of developing GUI Qt applications. They feature hardware-accelerated rendering, [declarative](https://en.wikipedia.org/wiki/Declarative_programming) UI design, and better support for animations, touch, and gestures. [Kirigami](https://develop.kde.org/docs/getting-started/kirigami/) is KDE's convergent UI toolkit that extends QtQuick with higher-level controls that conform to KDE's Human Interface Guidelines and adapt to the device's form factor.

KDE recommends using QtQuick with Kirigami when writing a new application. GUI code examples throughout the Human Interface Guidelines will primarily use QtQuick and Kirigami components, but the general principles extend to applications using either technology.
