---
title: Pages manipulation
description: "Add flow to your application: Add, remove and replace pages"
weight: 103
group: introduction
---

## The PageRow

The [PageRow](docs:kirigami2;PageRow) is a container that lays out items
horizontally in a row, when not all items fit in the PageRow, it will behave
like a Flickable and will be a scrollable view which shows only a determined
number of columns.

A PageRow can show a single page or a multiple set of columns, depending on
the window width: on a phone, a single column should be fullscreen, while on
a tablet or a desktop more than one column should be visible.

The columns can either all have the same fixed size, size themselves with
implicitWidth, or automatically expand to take all the available width: by
default the last column will always be the expanding one.

{{< img alt="Screenshot of a PageRow" src="columnview.png" >}}

You can access the column view methods from the `pageStack` property from your
[Kirigami.ApplicationWindow](docs:kirigami2;ApplicationWindow) element or
from anywhere else using `applicationWindow().pageStack`.

The initial page is added with the `pageStack.initialPage` property. For
example in a simple application that requires a user to authenticate themselves
with a server, the initial page should be the login page.

```qml
Kirigami.ApplicationWindow {
    pageStack.initialPage: LoginPage {}
}
```

Once the user logs into the application, we need to replace the login
page with the home page of the application. For this, we will use
`pageStack.replace`, to remove the LoginPage and replace it with an HomePage.

```
// LoginPage.qml
Kirigami.Page {
    // login formular

    Button {
        onClicked: {
            const user = Backend.authentificate(usernameField.text, passwordField.text);
            if (user) {
                applicationWindow().pageStack.replace("qrc:/HomePage.qml", {
                    user: user, // give the registerd user information to the homepage
                });
            } else {
                // display error message
            }
        }
    }
}
```

{{< alert color="info" title="Note" >}}
`pageStack.replace` takes either an url to a qml file or a QML Component.
{{< /alert >}}

Now let's imagine we have a configuration page and we want the user to
access it from the HomePage. Here we want the user to go back to the
HomePage, so we can't use `replace` and instead we will use `push` to
push a new page in the stack.

```qml
// ConfigurationPage.qml
Kirigami.Page {
    required property string var1
}
```

```js
// HomePage.qml
applicationWindow().pageStack.push("qrc:/MyPage.qml", {
    'var1': 'Hello',
});
```

A page row provides more than just the `replace` and `push` method. You can also [pop](docs:kirigami2;PageRow::pop)
a page, or use [insertPage](docs:kirigami2;PageRow::insertPage) to insert a page at a specific
position in the stack, use [movePage](docs:kirigami2;PageRow::movePage) to move pages or
[clear](docs:kirigami2;PageRow::clear) to remove all the page from stack.

You can also modify `currentIndex` to change the currently active page programmatically or
use [flickBack](docs;Kirigami2;PageRow::flickBack) to simulate moving a page back in the
stack.

## Layers

For the moment, we only saw horizontal navigation working in a 2 dimensional stack.
You can also use layers in your application to push full-screen page into your application.

In this case, only one page is visible at the same time on mobile and on the **desktop**.

The layers are accessible from `pageStack.layers` and use the same API as `pageStack`.
