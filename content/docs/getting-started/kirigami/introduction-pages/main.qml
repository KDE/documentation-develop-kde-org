import QtQuick
import QtQuick.Controls as Controls
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: i18nc("@title:window", "Day Kountdown")

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: i18nc("@title", "Kountdown")
    }
}
