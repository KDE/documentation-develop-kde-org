import QtQuick 2.11
import QtQuick.Controls 2.2 as Controls
import org.kde kirigami 2.9 as Kirigami

// The comments assume the system uses the Breeze Light color theme 
...
Rectangle {
    // A gray color will be used, as the default color set is Window
    color: Kirigami.Theme.backgroundColor

    Controls.Label {
        // The text will be near-black, as is defined in the Window 
        // color set
        text: i18n("hello")
    }

    Rectangle {
        ...
        // Use the set for ItemViews
        Kirigami.Theme.colorSet: Kirigami.Theme.View  

        // Do not inherit from the parent
        Kirigami.Theme.inherit: false

        // This will be a near-white color
        color: Kirigami.Theme.backgroundColor

        Rectangle {
            ...
            // This will be a near-white color too, as the colorSet 
            // is inherited from the parent and will be View
            color: Kirigami.Theme.backgroundColor

            Controls.Label {
                // The text will be near-black, as is defined in the View 
                // color set
                text: i18n("hello")
            }
        }
        Rectangle {
            ...
            // Use the Complementary set
            Kirigami.Theme.colorSet: Kirigami.Theme.Complementary  

            // Do not inherit from the parent
            Kirigami.Theme.inherit: false

            // This will be near-black as in the Complementary color set 
            // the background color is dark.
            color: Kirigami.Theme.backgroundColor  

            Controls.Label {
                // The text will be near-white, as is defined in the 
                // Complementary color set
                text: i18n("hello")
            }
        }
    }
}
