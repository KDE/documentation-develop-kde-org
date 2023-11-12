---
title: Overlay sheets
weight: 206
description: Overlay sheets can serve a variety of uses for both serving and inputting data.
group: components
aliases:
  - /docs/getting-started/kirigami/components-overlaysheets/
---

A [Kirigami.OverlaySheet](docs:kirigami2;OverlaySheet) is a simple component that you can use to supplement the content being displayed on an application's page. They are designed to display long, vertical content and can accommodate content longer than the application window itself.

They can be dismissed by clicking or tapping outside of their area or by clicking the 'x' icon on sheets' headers.

## Learning about the sheet

In order to use an overlay sheet, we should create it inside the Kirigami Page we want it to appear in. 

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

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

![Simple overlay sheet containing only text](/docs/getting-started/kirigami/components-overlaysheets/sheet_simple.png)

{{< /section-right >}}

{{< /sections >}}

Overlay sheets come with methods we can use to [open()](docs:kirigami2;templates::OverlaySheet::open) or [close()](docs:kirigami2;templates::OverlaySheet::close) them as we see fit. By default overlay sheets are hidden, so at the very least we will need to use the `open()` method.

```qml
Controls.Button {
    text: "Open mySheet"
    onClicked: mySheet.open()
}
```

When opened, this overlay sheet will appear centered vertically and horizontally within its parent page. Horizontally it will be bounded by its parent even if the width of its contents exceeds its parent's. If the sheet's vertical length exceeds its parent's, then the sheet will be displayed starting from its top position, and will be scrollable.

## Global sheet

If you want to display the sheet as a global sheet—one that spans across the entire width of the application, regardless of the page it is a child to—we have to reparent our overlay sheet to our application window's overlay property. We can do this with the [parent](https://doc.qt.io/qt-6/qml-qtquick-item.html#parent-prop) property.


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

{{< sections >}}

{{< section-left >}}

{{< figure class="text-center" caption="Non-global overlay sheet" src="sheet_global_before.png" >}}

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Global overlay sheet" src="sheet_global_after.png" >}}

{{< /section-right >}}

{{< /sections >}}

## Fixed sizing

A sheet is greedy and will take the maximum amount of available width in a page if needed. We can avoid this by specifying an [implicitWidth](https://doc.qt.io/qt-6/qml-qtquick-item.html#implicitWidth-prop) or a [Layout.preferredWidth](https://doc.qt.io/qt-6/qml-qtquick-layouts-layout.html#preferredWidth-attached-prop) for its child elements, which will limit how much the sheet will grow width wise.

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

{{< sections >}}

{{< section-left >}}

{{< figure class="text-center" caption="Non-fixed width overlay sheet" src="sheet_fixedwidth_before.png" >}}

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="Fixed width overlay sheet" src="sheet_fixedwidth_after.png" >}}

{{< /section-right >}}

{{< /sections >}}

## Headers and footers

Overlay sheets come by default with a [header](docs:kirigami2;templates::OverlaySheet::header) that only contains a button for closing our overlay sheet. We can add a [Kirigami.Heading](docs:kirigami2;Heading) as a title in our [header](docs:kirigami2;templates::OverlaySheet::header) to make it easy for users to understand what the sheet is for. This is done by setting `header` to contain our heading component.

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

![Overlay sheet with title text in its header area](/docs/getting-started/kirigami/components-overlaysheets/sheet_header.png)

{{< /section-right >}}

{{< /sections >}}

We can also provide our overlay sheet with a [footer](docs:kirigami2;templates::OverlaySheet::footer). Footers in overlay sheets are quite flexible, but most often they are used to provide overlay sheets with some sort of quick interactive input similar to that provided by modal dialogs (e.g. buttons for "Apply", "Ok", "Cancel", "Close", etc.)

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

![Overlay sheet with a button in its footer area](/docs/getting-started/kirigami/components-overlaysheets/sheet_footer.png)

{{< /section-right >}}

{{< /sections >}}

## Using delegate / model views

Since overlay sheets are designed to display vertical content, they can be especially useful when used in conjunction with components such as [ListViews](docs:qtquick;QtQuick.ListView). When displaying content longer than the application window itself, the overlay sheet becomes scrollable:

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

![Overlay sheet with a listview](/docs/getting-started/kirigami/components-overlaysheets/sheet_listview.png)

{{< /section-right >}}

{{< /sections >}}
