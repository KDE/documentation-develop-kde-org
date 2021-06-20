---
title: Overlay sheets
weight: 106
description: Overlay sheets can serve a variety of uses for both serving and inputting data.
group: components
---

Overlay sheets provide a simple component that you can use to supplement the content being displayed on an application's page. They are designed to display long, vertical content and can accommodate content longer than the application window itself. 

They can be dismissed by clicking or tapping outside of their area or by clicking the 'x' icon on sheets' headers.

## Learning about the sheet

In order to use an overlay sheet, we should create it inside the Kirigami Page we want it to appear in. 

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick 2.0
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.5 as Kirigami

Kirigami.Page {
    id: page
    Layout.fillWidth: true

    Kirigami.OverlaySheet {
        id: mySheet
        Controls.Label {
            Layout.fillWidth: true
            wrapMode: Text.WordWrap
            text: "Weeeeee, overlay sheet!"
        }
    }
}
```
{{< /section-left >}}

{{< section-right >}}

![Simple overlay sheet](sheet_simple.png)

{{< /section-right >}}

{{< /sections >}}

Overlay sheets come with methods we can use to open (`mySheet.open()`) or close (`mySheet.close()`) them as we see fit. By default overlay sheets are hidden, so at the very least we will need to use the `open()` method.

```qml
Controls.Button {
    text: "Open mySheet"
    onClicked: mySheet.open()
}
```

When opened, this overlay sheet will appear centered vertically and horizontally within its parent page. Horizontally it will be bounded by its parent even if its contents' width exceeds its parent's. If the sheet's vertical length exceeds its' parent's, then the sheet will be displayed from its top position, and will be scrollable.

## Global sheet

If you want to display the sheet as a global sheet — one that spans across the entire width of the application, regardless of the page it is a child to — we have to reparent our overlay sheet to our application window's overlay property. We can do this with the `parent` property.

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.OverlaySheet {
    id: mySheet

    parent: applicationWindow().overlay

    Controls.Label {
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        text: "Weeeeee, overlay sheet!"
    }
}
```
{{< /section-left >}}

{{< section-right >}}

{{< compare >}}

{{< figure class="text-center" caption="Non-global overlay sheet" src="sheet_global_before.png" >}}

{{< figure class="text-center" caption="Global overlay sheet" src="sheet_global_after.png" >}}

{{< /compare >}}

{{< /section-right >}}

{{< /sections >}}

## Fixed sizing

A sheet is greedy and will take the maximum amount of available width in a page if needed. We can avoid this by specifying an `implicitWidth` or a `Layout.preferredWidth` for its child elements, which will limit how much the sheet will grow width-wise.

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.OverlaySheet {
    id: mySheet
    Controls.Label {
        Layout.preferredWidth: Kirigami.Units.gridUnit * 25
        wrapMode: Text.WordWrap
        text: "Weeeeee, overlay sheet! I'm so excited!! WEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE WEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE WEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE WEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE WEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE!!!!!"
    }
}
```

{{< /section-left >}}

{{< section-right >}}

{{< compare >}}

{{< figure class="text-center" caption="Non-fixed width overlay sheet" src="sheet_fixedwidth_before.png" >}}

{{< figure class="text-center" caption="Fixed width overlay sheet" src="sheet_fixedwidth_after.png" >}}

{{< /compare >}}

{{< /section-right >}}

{{< /sections >}}

## Headers and footers

Overlay sheets come by default with a header which only contains a button for closing our overlay sheet. We can add a Kirigami heading as a title in our header to make it easy for users to understand what the sheet is for. This is done by setting the `header` property to contain our Kirigami heading component.

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.OverlaySheet {
    id: mySheet

    header: Kirigami.Heading {
        text: "My Overlay Sheet"
    }

    Controls.Label {
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        text: "Weeeeee, overlay sheet!"
    }
}
```
{{< /section-left >}}

{{< section-right >}}

![Sheet header](sheet_header.png)

{{< /section-right >}}

{{< /sections >}}

We can also provide our overlay sheet with a footer. Footers in overlay sheets are quite flexible, but most often they are used to provide overlay sheets with some sort of quick interactive input similar to that provided by modal dialogs (e.g. buttons for 'Apply', 'Ok', 'Cancel', 'Close', etc.)

Footers are set in much the same way as headers:

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.OverlaySheet {
    id: mySheet

    header: Kirigami.Heading {
        text: "My Overlay Sheet"
    }

    footer: Controls.DialogButtonBox {
        standardButtons: DialogButtonBox.Close
        onRejected: mySheet.close()
    }

    Controls.Label {
        Layout.fillWidth: true
        wrapMode: Text.WordWrap
        text: "Weeeeee, overlay sheet!"
    }
}
```
{{< /section-left >}}

{{< section-right >}}

![Sheet footer](sheet_footer.png)

{{< /section-right >}}

{{< /sections >}}

## Using delegate / model views

Since overlay sheets are designed to display vertical content, they can be especially useful when used in conjunction with components such as ListViews. When displaying content longer than the application window itself, the overlay sheet becomes scrollable:

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.OverlaySheet {
    id: mySheet

    ListView {
        model: 100
        implicitWidth: Kirigami.Units.gridUnit * 30
        delegate: Kirigami.BasicListItem {
            label: "Item in sheet " + modelData
        }
    }
}
```
{{< /section-left >}}

{{< section-right >}}

![Sheet with a listview](sheet_listview.png)

{{< /section-right >}}

{{< /sections >}}
