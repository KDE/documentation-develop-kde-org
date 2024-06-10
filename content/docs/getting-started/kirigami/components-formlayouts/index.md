---
title: Form layouts
weight: 208
description: Easily create attractive interaction areas with Kirigami FormLayouts
group: components
aliases:
  - /docs/getting-started/kirigami/components-formlayouts/
---

[Kirigami.FormLayout](docs:kirigami2;FormLayout) components make it easy for you to create forms that conform to the [KDE Human Interface Guidelines](https://develop.kde.org/hig/). They are optimal for settings dialogs and for large groups of controls and input fields that are related to each other.

When provided with enough space, form layouts will take up two columns. The column on the left will be occupied by the labels provided for the form's children components, while the right will be taken up by the children components themselves. In more space-constrained windows (or on mobile), forms will consist of a single vertical column with the labels of children components being placed above their respective component.

## Simple form

[Kirigami.FormLayout](docs:kirigami2;FormLayout) components are similar in use to [QtQuick Layout](https://doc.qt.io/qt-6/qtquicklayouts-index.html) components such as [ColumnLayout](https://doc.qt.io/qt-6/qml-qtquick-layouts-columnlayout.html) or [RowLayout](https://doc.qt.io/qt-6/qml-qtquick-layouts-rowlayout.html). The child components will be automatically arranged according to the size available to the form layout.

Children of a [Kirigami.FormLayout](docs:kirigami2;FormLayout) have a property named [Kirigami.FormData.label](docs:kirigami2;FormLayoutAttached::label). This property lets you set the label that will be provided for the child component in question.

{{< sections >}}

{{< section-left >}}

```qml
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    pageStack.initialPage: Kirigami.Page {

        Kirigami.FormLayout {
            anchors.fill: parent

            Controls.TextField {
                Kirigami.FormData.label: "TextField 1:"
            }
            Controls.TextField {
                Kirigami.FormData.label: "TextField 2:"
            }
            Controls.TextField {
                Kirigami.FormData.label: "TextField 3:"
            }
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="A simple form layout in desktop mode" src="formlayouts-simple.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Sections and separators

FormLayouts can also be divided into sections. Setting where a section starts is as easy as setting a child component's [Kirigami.FormData.isSection](docs:kirigami2;FormLayoutAttached::isSection) to true. This will provide the component with some extra margin at the top to demarcate the start of the new section.

[Kirigami.Separator](docs:kirigami2;Separator) components are best suited for starting new sections. Separators are used to draw a thin horizontal line, demarcating the end of a section. If you would rather not have a line drawn between sections, you can use a standard QML [Item](docs:qtquick;QtQuick.Item) property. Alternatively you could use the [Kirigami.FormData.isSection](docs:kirigami2;FormLayoutAttached::isSection) property on any other component.

However, this is not recommended. On components where [Kirigami.FormData.isSection](docs:kirigami2;FormLayoutAttached::isSection) is set to `true`, the label text provided for this component's [Kirigami.FormData.label](docs:kirigami2;FormLayoutAttached::label) property will be displayed as the section's header text.

{{< alert title="Warning" color="warning" >}}

This does not apply to every component, hence the recommendation that you use [Kirigami.Separator](docs:kirigami2;Separator) or [Item](docs:qtquick;QtQuick.Item) components in places where you would like to use a header text.

{{< /alert >}}

This header text is larger than the normal label text, and provides users with a nice visual cue of what the form layout section is about.

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.FormLayout {
    anchors.fill: parent

    Controls.TextField {
        Kirigami.FormData.label: "TextField 1:"
    }
    Controls.TextField {
        Kirigami.FormData.label: "TextField 2:"
    }
    Controls.TextField {
        Kirigami.FormData.label: "TextField 3:"
    }
    Kirigami.Separator {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: "New Section!"
    }
    ColumnLayout {
        Kirigami.FormData.label: "Radio buttons"
        Controls.RadioButton {
            text: "Radio 1"
            checked: true
        }
        Controls.RadioButton {
            text: "Radio 2"
        }
        Controls.RadioButton {
            text: "Radio 3"
        }
    }
    Item {
        Kirigami.FormData.isSection: true
        Kirigami.FormData.label: "Another Section! (lineless though)"
    }
    Controls.TextField {
        Kirigami.FormData.label: "TextField 4:"
    }
    Controls.TextField {
        Kirigami.FormData.label: "TextField 5:"
    }
    Controls.TextField {
        Kirigami.FormData.label: "TextField 5:"
    }
}
```

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="A form layout with sections" src="formlayouts-sections.webp" >}}

{{< /section-right >}}

{{< /sections >}}


## Checkable children

A handy feature of [Kirigami.FormLayout](docs:kirigami2;FormLayout) is that you can add checkboxes to its children. This can be useful in settings pages where you might want to let the user enable or disable a setting, and also want the user to provide some extra information in a component such as a textfield.

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.FormLayout {
    anchors.fill: parent

    Controls.TextField {
        Kirigami.FormData.label: "First name:"
    }
    Controls.TextField {
        Kirigami.FormData.label: "Middle name:"
        Kirigami.FormData.checkable: true
        enabled: Kirigami.FormData.checked
    }
    Controls.TextField {
        Kirigami.FormData.label: "Last name:"
    }
}
```

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="A form layout with checkable label." src="formlayouts-checkable.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Forcing a desktop or mobile layout

If you would rather have your form layout stay consistent regardless of your application's environment, you can use the [wideMode](docs:kirigami2;FormLayout::wideMode) property of the [Kirigami.FormLayout](docs:kirigami2;FormLayout) component:

- When set to `true`, the form layout will be structured in a desktop-optimized widescreen (double-column) layout
- When set to `false`, the form layout will be structured in a mobile layout (single column)

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.FormLayout {
    anchors.fill: parent
    wideMode: false

    Controls.TextField {
        Kirigami.FormData.label: "TextField 1:"
    }
    Controls.TextField {
        Kirigami.FormData.label: "TextField 2:"
    }
    Controls.TextField {
        Kirigami.FormData.label: "TextField 3:"
    }
}
```

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="A form layout with forced mobile layout" src="formlayouts-widemode.webp" >}}

{{< /section-right >}}

{{< /sections >}}

## Aligning your labels

There are instances when you want a label to be assigned to components that have more than one line or to a list of components. This can be achieved by putting the [Kirigami.FormData.label](docs:kirigami2;FormLayoutAttached::label) in the [ColumnLayout](https://doc.qt.io/qt-6/qml-qtquick-layouts-columnlayout.html), as you might have noticed in [Sections and Separators](#sections-and-separators). By default the label is positioned in the vertical center of the layout, which is not always desirable. We can change this with help of [Kirigami.FormData.labelAlignment](docs:kirigami2;FormLayoutAttached::labelAlignment).

{{< sections >}}

{{< section-left >}}

```qml
Kirigami.FormLayout {
    anchors.fill: parent

    ColumnLayout {
        Kirigami.FormData.label: "This is a label:"
        Kirigami.FormData.labelAlignment: Qt.AlignTop

        Controls.Label {
            text: "This is some rather long text \nthat should elide to multiple lines \nto show how the label gets aligned."
            elide: Text.elideLeft
        }
    }
}
```

{{< /section-left >}}

{{< section-right >}}

{{< figure class="text-center" caption="A form layout with top-aligned label" src="formlayouts-labelalignment.webp" >}}

{{< /section-right >}}

{{< /sections >}}

Setting the label alignment is particularly convenient to manage components or lists of components whose size you do not know beforehand. [Elisa](https://apps.kde.org/elisa) is a very good example of this:

{{< figure class="text-center" caption="The Comment label is only top aligned when its corresponding component has more than one line" src="elisa.webp" >}}

We can do something similar to this with a JavaScript ternary operator:

```qml
Kirigami.FormLayout {
    anchors.fill: parent

    ColumnLayout {
        Kirigami.FormData.label: "This is a label:"
        Kirigami.FormData.labelAlignment: labelText.text.lineCount > 1 ? Qt.AlignTop : Qt.AlignVCenter

        Controls.Label {
            id: labelText
            text: "This is some rather long text \nthat should elide to a new line \nso it appears below the Form Label."
            elide: Text.elideLeft
        }
    }
}
```
