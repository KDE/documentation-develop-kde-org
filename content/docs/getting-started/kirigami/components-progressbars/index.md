---
title: Progress bars and indicators
weight: 211
description: Provide your users with loading state information using progress bars.
group: components
aliases:
  - /docs/getting-started/kirigami/components-progressbars/
---

Whenever your application does something that takes a noticeable amount of time, you will want to use a visual element that tells the user that something is happening in the background. 

QtQuick Controls provides two useful components that you can use to this end.

## Progress bar

[Controls.ProgressBar](docs:qtquickcontrols;QtQuick.Controls.ProgressBar) is a component that lets you easily include progress bars in your application. There are four main properties you will need to use:

- [from](https://doc.qt.io/qt-6/qml-qtquick-controls2-progressbar.html#from-prop): the minimum value represented by the start of the progress bar
- [to](https://doc.qt.io/qt-6/qml-qtquick-controls2-progressbar.html#to-prop): the maximum value represented by the end of the progress bar
- [value](https://doc.qt.io/qt-6/qml-qtquick-controls2-progressbar.html#value-prop): the current value of the action that is in progress (e.g. 50% loaded)
- [indeterminate](https://doc.qt.io/qt-6/qml-qtquick-controls2-progressbar.html#indeterminate-prop): if the action that is in process currently has no clear progress value, you can set this property to `true` to show the user that something is happening but its progress is not yet clear (but will be soon).

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Progressbar App"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.Page {
        ColumnLayout {
            anchors.left: parent.left
            anchors.right: parent.right
            Controls.ProgressBar {
                Layout.fillWidth: true
                from: 0
                to: 100
                value: 50
                indeterminate: false
            }
            Controls.ProgressBar {
                Layout.fillWidth: true
                from: 0
                to: 100
                // value: 50
                indeterminate: true
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

<br>

{{< figure class="text-center" caption="Above: progress bar at 50%; below: indeterminate progress bar" src="progressbar-both.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Busy indicator

In cases where loading times are shorter or measuring progress is not feasible, you can instead use [Controls.BusyIndicator](docs:qtquickcontrols;QtQuick.Controls.BusyIndicator). This component provides a simple spinning wheel that shows users that something is happening.

If you want the indicator to stop running, you can do so by setting the [running](https://doc.qt.io/qt-6/qml-qtquick-controls2-busyindicator.html#running-prop) property to false, in which case the .

```qml
import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    title: "Progressbar App"
    width: 400
    height: 400
    pageStack.initialPage: Kirigami.Page {
        actions: [
            Kirigami.Action {
                text: "Toggle busy indicator"
                onTriggered: indicator.running ? indicator.running = false : indicator.running = true
            }
        ]
        Controls.BusyIndicator {
            id: indicator
            anchors.centerIn: parent
        }
    }
}
```

{{< figure class="text-center" src="busyindicator.webp" >}}
