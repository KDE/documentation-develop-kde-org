import QtQuick 2.11
import QtQuick.Controls 2.2 as Controls
import QtQuick.Layouts 1.14
import org.kde.kirigami 2.9 as Kirigami

Rectangle {
    RowLayout {
        Kirigami.Theme.colorSet: Kirigami.Theme.View  
    anchors.centerIn: parent
    spacing: 20
        Controls.Button {
            Kirigami.Theme.inherit: true
            text: i18n("Inherit")
        }
        Controls.Button {
            text: i18n("Don't inherit")
        }
    }
}
