import QtQuick 2.15
import QtQuick.Layouts 1.15

import org.kde.kirigami 2.15 as Kirigami
import org.kde.kirigamiaddons.formcard 1.0 as FormCard

import org.kde.about 1.0

Kirigami.ApplicationWindow {
    id: root
    width: 600
    height: 700

    pageStack.initialPage: Kirigami.ScrollablePage {
        ColumnLayout {
            FormCard.FormCard {
                // Our buttons will go here
            }
        }
    }
}
