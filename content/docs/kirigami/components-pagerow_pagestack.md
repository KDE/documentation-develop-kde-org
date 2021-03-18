---
title: Pagerows and page stacks
description: "Add flow to your application: Add, remove and replace pages in different ways"
weight: 102
group: introduction
---

## The PageRow

The [PageRow](docs:kirigami2;PageRow) is a container that lays out items
horizontally in a row. If all child items don't fit in the PageRow, it will behave
like a `Flickable` surface and will become a horizontal scrollable view of columns.

A PageRow can show a single page or several of them as columns, depending on
the window width. On a phone, a single column will be viewable, while on
a tablet or a desktop more than one column should be visible at once.

The columns can either all have the same fixed size, size themselves with
`implicitWidth`, or automatically expand to take up all available width. By
default, the last column will expand to take up all available space.

{{< img alt="Screenshot of a PageRow" src="columnview.png" >}}

You can access the column view methods from the `pageStack` property of your
[Kirigami.ApplicationWindow](docs:kirigami2;ApplicationWindow) element or
from anywhere else using `applicationWindow().pageStack`.

The initial page is added with the `pageStack.initialPage` property. As an example: in a simple application 
that required the user to authenticate themselves, the initial page would be a login page.

```qml
Kirigami.ApplicationWindow {
    pageStack.initialPage: LoginPage {}
}
```

Once the user logged into the application, you would need to replace the login
page with the home page of the application. To do this, you would use
`pageStack.replace`, removing the LoginPage and replacing it with a HomePage.

```qml
// LoginPage.qml
Kirigami.Page {
    // login formular

    Button {
        onClicked: {
            const user = Backend.authentificate(usernameField.text, passwordField.text);
            if (user) {
                applicationWindow().pageStack.replace("qrc:/HomePage.qml", {
                    user: user, // give the registered user information to the homepage
                });
            } else {
                // display error message
            }
        }
    }
}
```

{{< alert color="info" title="Note" >}}
`pageStack.replace` accepts either a QML Component or aurl to a QML file.
{{< /alert >}}

Now let's imagine you had a configuration page you wanted the user to
access from the HomePage. You'd want the user to go back to the
HomePage, so you can't use `replace`. Instead, you would use `push` to
push a new page in the stack.

```qml
// ConfigurationPage.qml
Kirigami.Page {
    required property string var1
}
```

```qml
// HomePage.qml
applicationWindow().pageStack.push("qrc:/MyPage.qml", {
    'var1': 'Hello',
});
```

You can also: 
- [pop](docs:kirigami2;PageRow::pop) a page (which removes the last page in the stack) or 
- use [insertPage](docs:kirigami2;PageRow::insertPage) to insert a page at a specific position in the stack, 
- use [movePage](docs:kirigami2;PageRow::movePage) to move specific pages within the stack, or
- [clear](docs:kirigami2;PageRow::clear) all pages from the stack.

You can also modify `currentIndex` to change the currently active page programmatically, or
use [flickBack](docs;Kirigami2;PageRow::flickBack) to simulate moving a page backwards in the
stack.

## Layers

For the moment, we only saw horizontal navigation working in a 2 dimensional stack.
You can also use layers in your application to push full-screen page into your application.

In this case, only one page is visible at the same time on mobile and on the **desktop**.

The layers are accessible from `pageStack.layers` and use the same API as `pageStack`.
