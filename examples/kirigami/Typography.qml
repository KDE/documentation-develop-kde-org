...
import QtQuick.Controls 2.2 as Controls
import org.kde.kirigami 2.9 as Kirigami
...
Kirigami.Heading {
    level: 1
    text: "Header 1"
}
Kirigami.Heading {
    level: 4
    text: "Header 4"
}
Controls.Label {
    font.pointSize: 24
    text: "Extra large title"
}
Controls.Label {
    text: "Normal text in your application"
}
Controls.Label {
    text: "Use this to label buttons, checkboxes, ..."
}
