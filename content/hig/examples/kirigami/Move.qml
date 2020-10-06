...
import QtQuick 2.2
...

Kirigami.ApplicationWindow {
    ...
    Rectangle {
        ...
        NumberAnimation on y {
            running: true
            to: 30
            duration: Kirigami.Units.shortDuration
            easing.type: Easing.InOutQuad
        }
    }
    ...
}
