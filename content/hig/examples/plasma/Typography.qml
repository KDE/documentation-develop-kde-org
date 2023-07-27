...
import org.kde.kirigami 2.20 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents
...
Kirigami.Heading {
    level: 1
    text: "Header 1"
}
Kirigami.Heading {
    level: 4
    text: "Header 4"
}
PlasmaComponents.Label {
    font.pointSize: PlasmaComponents.theme.defaultFont.pointSize * 3
    text: "Extra large title"
}
PlasmaComponents.Label {
    text: "Normal text in your application"
}
PlasmaComponents.Label {
    text: "Use this to label buttons, checkboxes, ..."
}
