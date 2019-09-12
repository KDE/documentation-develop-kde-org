...
import org.kde kirigami 2.9 as Kirigami
...

Kirigami.ApplicationWindow {
    ...
    Kirigami.Card {
        actions: [
            Kirigami.Action {
                text: "Action1"
                icon.name: "add-placemark"
            },
            Kirigami.Action {
                text: "Action2"
                icon.name: "address-book-new-symbolic"
            }
        ]
        banner {
            imageSource: "..."
            title: "Hello World"
        }
        contentItem: Controls.Label {
            wrapMode: Text.WordWrap
            text: "Lorem ipsum ..."
        }
    }
    ...
}
