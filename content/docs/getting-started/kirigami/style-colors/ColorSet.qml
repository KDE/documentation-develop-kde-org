import QtQuick
import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami

// The comments assume the system uses the Breeze color theme

Kirigami.ApplicationWindow {
    height: 500
    width: 800

    Rectangle {
        anchors.fill: parent
        border.width: 5

        // A gray color will be used, as the default color set is Window
        color: Kirigami.Theme.backgroundColor

        Controls.Label {
            // The text will be near-black, as defined in the Window color set for light themes
            text: "Rectangle that uses default background color\nfrom the Window color set"
            padding: 100
        }
        Rectangle {
            anchors.bottom: parent.bottom
            border.width: 5
            width: parent.width
            height: Math.round(parent.height / 2)

            // Use the color set used for Views
            Kirigami.Theme.colorSet: Kirigami.Theme.View
            // Do not inherit from the parent
            Kirigami.Theme.inherit: false
            // This will be a near-white color in light themes
            color: Kirigami.Theme.backgroundColor

            Controls.Label {
                text: "Rectangle that does not inherit the default background color\nand uses the Theme.View color set"
                padding: 50

            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                border.width: 5
                width: Math.round(parent.width / 2)
                height: Math.round(parent.height / 2)

                // This will be a near-white color too, as the color set
                // is inherited from the parent and will be View
                color: Kirigami.Theme.backgroundColor

                Controls.Label {
                    // The text will be near-black, as defined in the View color set for light themes
                    text: "Rectangle that inherits the Theme.View color set"
                    anchors.centerIn: parent
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                border.width: 5
                width: Math.round(parent.width / 2)
                height: Math.round(parent.height / 2)

                // Use the Complementary set
                Kirigami.Theme.colorSet: Kirigami.Theme.Complementary
                // Do not inherit from the parent
                Kirigami.Theme.inherit: false
                // This will be near-black as the background color
                // of the Complementary color set is dark in light themes
                color: Kirigami.Theme.backgroundColor

                Controls.Label {
                    // The text will be near-white, as defined in the Complementary color set for light themes
                    text: "Rectangle that does not inherit the Theme.View\nand uses Theme.Complementary instead"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
