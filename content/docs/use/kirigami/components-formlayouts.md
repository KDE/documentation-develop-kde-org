---
title: Form Layouts
weight: 108
description: Easily create attractive interaction areas with Kirigami FormLayouts
group: components
aliases:
  - /docs/kirigami/components-formlayouts/
---

`Kirigami.FormLayout` components make it easy for you to create forms that conform to the KDE Human Interface Guidelines. They are optimal for settings dialogs and for large groups of controls and input fields that are related to each other.

When provided with enough space, form layouts will take up two columns. The column on the left will be occupied by the labels provided for the form's children components, while the right will be taken up by the children itself. In more space-constrained windows (or on mobile), forms will consist of a single vertical column with children components' labels being placed above their respective component.

## Simple form

`Kirigami.FormLayout` components are similar in use to QtQuick Layout components such as `ColumnLayout` or `RowLayout`. The child components will be automatically arranged according to the size available to the form layout.

Children of a `Kirigami.FormLayout` have a property named `Kirigami.FormData.label`. This property lets you set the label that will be provided for the child component in question.

{{< sections >}}
{{< section-left >}}

```qml
import QtQuick 2.6
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.2 as Controls
import org.kde.kirigami 2.4 as Kirigami

Kirigami.Page {

    Kirigami.FormLayout {
        id: layout
        Layout.fillWidth: true

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
```

{{< /section-left >}}
{{< section-right >}}

![A simple formlayout](/docs/use/kirigami/components-formlayouts/formlayouts-simple.png)

{{< /section-right >}}
{{< /sections >}}

## Sections and separators

FormLayouts can also be divided into sections. Setting where a section starts is as easy as setting a child component's `Kirigami.FormData.isSection` to true. This will provide the component with some extra margin at the top to demarcate the start of the new section.

`Kirigami.Separator` components are best suited for starting new sections. A `Kirigami.Separator` will draw a thin horizontal line, demarcating the end of a section. If you would rather not have a line drawn between sections, you can use a standard QML `Item` property. Alternatively you could use the `Kirigami.FormData.isSection` property on any other component.

However, this is not recommended. On components where `Kirigami.FormData.isSection` is set to true, the label text provided for this component's `Kirigami.FormData.label` property will be displayed as the section's header text. **This does not apply to every component, hence the recommendation that you use `Kirigami.Separator` or `Item` components in places where you would like to use a header text.** This header text is larger than the normal label text, and provides users with a nice visual cue of what the form layout section is about.

{{< sections >}}
{{< section-left >}}

```qml
Kirigami.FormLayout {
    id: layout
    Layout.fillWidth: true

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

![A formlayout with sections](/docs/use/kirigami/components-formlayouts/formlayouts-sections.png)

{{< /section-right >}}
{{< /sections >}}


## Checkable children

A handy feature of `Kirigami.FormLayout` is that you can add checkboxes to its children. This can be useful in settings pages where you might want to let the user enable or disable a setting, and also want the user to provide some extra information in a component such as a textfield.

{{< sections >}}
{{< section-left >}}

```qml
Kirigami.FormLayout {
    id: layout
    Layout.fillWidth: true

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

![A formlayout with checkable child](/docs/use/kirigami/components-formlayouts/formlayouts-checkable.png)

{{< /section-right >}}
{{< /sections >}}

## Forcing a desktop or mobile layout

If you would rather have your form layout stay consistent regardless of your application's environment, you can use the `wideMode` property of the `Kirigami.FormLayout` component. `wideMode` is a boolean property:

- When set to `true`, the form layout will be structured in a desktop-optimized widescreen (double-column) layout
- When set to `false`, the form layout will be structured in a mobile layout (single column)

{{< sections >}}
{{< section-left >}}

```qml
Kirigami.FormLayout {
    id: layout
    Layout.fillWidth: true
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

![A formlayout with forced mobile layout](/docs/use/kirigami/components-formlayouts/formlayouts-widemode.png)

{{< /section-right >}}
{{< /sections >}}
