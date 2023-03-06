import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import org.kde.kirigami 2.20 as Kirigami

Rectangle {
    Kirigami.Theme.inherit: false
    // NOTE: regardless of the color set used, it is recommended to replace 
    // all available colors in Theme, to avoid badly contrasting colors
    Kirigami.Theme.colorSet: Kirigami.Theme.Window
    Kirigami.Theme.backgroundColor: "#b9d795"
    Kirigami.Theme.textColor: "#465c2b"
    Kirigami.Theme.highlightColor: "#89e51c"
    // Redefine all the others

    // This will be "#b9d795"
    color: Kirigami.Theme.backgroundColor

    Rectangle {
        // This will be "#465c2b"
        anchors.centerIn: parent
        height: Math.round(parent.height / 2)
        width: Math.round(parent.width / 2)
        color: Kirigami.Theme.textColor
    }
}
