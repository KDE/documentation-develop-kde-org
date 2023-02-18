import QtQuick 2.15
import QtQuick.Controls 2.15 as Controls
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.20 as Kirigami

Kirigami.ApplicationWindow {
    id: root

    title: i18nc("@title:window", "Day Kountdown")

    pageStack.initialPage: Kirigami.ScrollablePage {
        title: i18nc("@title", "Kountdown")
    }
}
