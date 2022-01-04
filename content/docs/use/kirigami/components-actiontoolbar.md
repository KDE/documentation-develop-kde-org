---
title: Action Tool Bars
weight: 110
description: Create your own customisable tool bars with the ActionToolBar component
group: components
aliases:
  - /docs/kirigami/components-actiontoolbar/
---

While Kirigami pages allow you to easily place a set of actions in the page header, there are times when you might prefer to have something more flexible.

Kirigami provides the component `Kirigami.ActionToolBar`. It will display a list of `Kirigami.Action` objects and will display as many of them as possible, providing an overflow menu for the ones that don't fit. The ActionToolBar is dynamic and will move actions in and out of the overflow menu depending on the size available to it.

{{< alert title="Note" color="info" >}}
This page assumes you are familiar with `Kirigami.Action` objects. If you are not, you can learn all about them in our beginner tutorial or in [the dedicated documentation page for them](../components-actions/).
{{< /alert >}}

## Creating our first ActionToolBar

The layout and location of your `Kirigami.ActionToolBar` are really up to you, though for the sake of user-friendliness it is usually a good idea to stick to UI conventions and put your toolbar near the top or bottom of your page and to have it spread width-wise. 

Like most other action-holding components, `Kirigami.ActionToolBar` has an `actions` property. We can assign an array of `Kirigami.Action` components to this property.

```qml
import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami

Kirigami.Page {

    Kirigami.ActionToolBar {
        anchors.fill: parent

         actions: [
            Kirigami.Action { 
                text: "Beep" 
                icon.name: "notifications" 
                onTriggered: showPassiveNotification("BEEP!") 
            },
            Kirigami.Action { 
                text: "Action Menu" 
                icon.name: "overflow-menu"

                Kirigami.Action { 
                    text: "Deet"; 
                    icon.name: "notifications" 
                    onTriggered: showPassiveNotification("DEET!") 
                }
                Kirigami.Action { 
                    text: "Doot"; 
                    icon.name: "notifications" 
                    onTriggered: showPassiveNotification("DOOT!") 
                }
            },
            Kirigami.Action {
                icon.name: "search"
                displayComponent: Kirigami.SearchField { }
            }
        ]
    }

}
```

{{< compare >}}
{{< figure class="text-center" caption="ActionToolBar with enough space for all children" src="actiontoolbar.png" >}}
{{< figure class="text-center" caption="ActionToolBar with overflow menu containing children" src="actiontoolbar-overflow.png" >}}
{{< /compare >}}

### Alignment

By default, actions in the ActionToolBar will be left aligned. This might not be desirable in all situations. Thankfully we can change this with the `alignment` property. We can set this property to a range of values, but the three most relevant ones for an ActionToolBar are `Qt.AlignLeft`, `Qt.AlignCenter`, and `Qt.AlignRight` (which deal with horizontal alignment).

{{< sections >}}
{{< section-left >}}

```qml
Controls.GroupBox {
    Layout.fillWidth: true
        
    Kirigami.ActionToolBar {
        anchors.fill: parent

        alignment: Qt.AlignCenter

        actions: [
            Kirigami.Action { 
                text: "Beep" 
                icon.name: "notifications" 
                onTriggered: showPassiveNotification("BEEP!") 
            }
        ]
    }
    
}
```

{{< /section-left >}}
{{< section-right >}}

![ActionToolBar with children center-aligned](actiontoolbar-alignment.png)

{{< /section-right >}}
{{< /sections >}}
