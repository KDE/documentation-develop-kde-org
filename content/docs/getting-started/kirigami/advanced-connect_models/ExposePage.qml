import QtQuick.Controls as Controls
import org.kde.kirigami as Kirigami
import org.kde.tutorial.components

Kirigami.Page {
    title: "Exposing to QML Tutorial"

    Kirigami.Heading {
        anchors.centerIn: parent
        text: Backend.introductionText
    }
}
