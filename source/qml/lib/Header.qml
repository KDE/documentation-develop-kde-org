//import related modules
import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.4 as Kirigami
import QtGraphicalEffects 1.0

//import "MMCQ.js" as MMCQ


Rectangle {
    id: root
    width: parent.width
    height: Kirigami.Units.gridUnit * 11 * status
    clip: true
    default property alias contents: content.data
    property alias content: contentContainer
    property alias stripContent: strip.data

    property string source;
    property string title;
    property string subtitle;
    property string overview;
    property real status : 1;

    // Background image
    Image {
        anchors.fill: parent
        id: bg
        source: root.source
        fillMode: Image.PreserveAspectCrop

    }

    FastBlur {
        anchors.fill: bg
        source: bg
        radius: 48

        ColorOverlay {
            anchors.fill: parent
            source: parent
            color: "#66808080"

            BrightnessContrast {
                anchors.fill: parent
                source: parent
                brightness: 0
                contrast: 0
            }
        }
    }


    // Container for the content of the header
    Item {
        anchors.fill: parent
        anchors.bottomMargin: strip.children.length > 0 ? strip.height : 0

        Item {
            id: contentContainer
            anchors.fill: parent
            anchors.margins: Kirigami.Units.gridUnit
            anchors.leftMargin: 200

            Image {
                id: img
                source: root.source
                height: contentContainer.height
                width: contentContainer.height
                fillMode: Image.PreserveAspectCrop
                //visible: false
            }
            /*OpacityMask {
                anchors.fill: img
                source: img
                maskSource: Rectangle {
                    height: img.width
                    width: height
                    radius: height / 2
                }
            }*/
            Item {
                id: content
                height: childrenRect.height
                anchors.left: img.right
                anchors.leftMargin: Kirigami.Units.gridUnit
                anchors.bottom: img.bottom
            }
        }

        /*
          TODO show on desktop only
        Rectangle {
            color: "#eff0f1"
            anchors.top: parent.top;
            anchors.right: parent.right;
            anchors.margins: Kirigami.Units.largeSpacing
            radius: 12
            width: 24
            height: 24
            Kirigami.Icon {
                source: "application-menu"
                anchors.fill: parent
                anchors.margins: Kirigami.Units.smallSpacing
            }
        }*/
    }

    Rectangle {
        id: strip
        color: "#66F0F0F0"
        anchors.bottom: parent.bottom;
        height: 2 * Kirigami.Units.gridUnit
        width: parent.width
        visible: children.length > 0
    }

    /*states: [
        State {
            name: "small"
            PropertyChanges {
                target: root;
                height:  2 * Kirigami.Units.gridUnit
            }

        },
        State {
            name: "default"
        },
        State {
            name: "large"
            PropertyChanges { target: myRect; color: "red" }
        }
    ]*/
}
