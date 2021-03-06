---
title: Progress Bars and Indicators
weight: 111
description: Provide your users with loading state information using progress bars.
group: components
---

Whenever your application does something that takes a noticeable amount of time, you will want to use a visual element that tells the user that something is happening in the background. 

QtQuick Controls provides two useful components that you can use to this end.

## Progress bar

`Controls.ProgressBar` is a component that lets you easily include progress bars in your application. There are four main properties you will need to use:

- `from`: the minimum value represented by the start of the progress bar
- `to`: the maximum value represented by the end of the progress bar
- `value`: the current value of the action that is in progress (e.g. 50% loaded)
- `indeterminate`: if the action that is in process currently has no clear progress value, you can set this property to true to show the user something is happening but its progress is not yet clear (but will be soon).

{{< sections >}}
{{< section-left >}}

```qml
import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami

Kirigami.Page {

    Controls.ProgressBar {
        from: 0
        to: 100
        value: 50
        indeterminate: false
    }

}
```

{{< /section-left >}}
{{< section-right >}}

{{< figure class="text-center" caption="Above: progress bar at 50%; Below: indeterminate progress bar" src="progressbar-both.png" >}}

{{< /section-right >}}
{{< /sections >}}

## Busy indicator

In cases where loading times are shorter or measuring progress is not feasible, you can instead use `Controls.BusyIndicator`. This component provides a simple spinning wheel that shows users that something is happening.

{{< sections >}}
{{< section-left >}}

```qml
Controls.BusyIndicator {}
```

{{< /section-left >}}
{{< section-right >}}

![A busy indicator](busyindicator.png)

{{< /section-right >}}
{{< /sections >}}

If you want the indicator to stop running, you can do so by setting the `running` property to false.

```qml
Controls.BusyIndicator {
    running: false
}
```
