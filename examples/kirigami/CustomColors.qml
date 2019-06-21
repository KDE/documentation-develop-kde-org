import QtQuick 2.11
import QtQuick.Controls 2.2 as Controls
import org.kde kirigami 2.9 as Kirigami

Rectangle {
    Kirigami.Theme.inherit: false
    // NOTE: regardless of the color set used, it's recommended to replace 
    // all available colors in Theme, to avoid badly contrasting colors
    Kirigami.Theme.colorSet: Kirigami.Theme.Window
    Kirigami.Theme.backgroundColor: "#b9d795"
    Kirigami.Theme.textColor: "#465c2b"
    Kirigami.Theme.highlightColor: "#89e51c"
    ... // Redefine all the others

    // This will be "#b9d795"
    color: Kirigami.Theme.backgroundColor

    Rectangle {
        // This will be "#465c2b"
        color: Kirigami.Theme.textColor
    }
}
