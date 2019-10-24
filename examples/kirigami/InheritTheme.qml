import QtQuick 2.11
import QtQuick.Controls 2.2 as Controls
import org.kde.kirigami 2.9 as Kirigami

...
Controls.Button {
    Kirigami.Theme.inherit: true
    text: i18n("ok")
}
