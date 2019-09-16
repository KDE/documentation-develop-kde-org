import QtQuick 2.11
import org.kde kirigami 2.9 as Kirigami
import org.kde.kcm 1.1 as KCM

...
KCM.GridViewKCM {
    KCM.ConfigModule.quickHelp: i18n("This module lets you choose the global look and feel.")

    view.model: kcm.lookAndFeelModel
    view.currentIndex: kcm.selectedPluginIndex
    view.delegate: KCM.GridDelegate {
        id: delegate

        text: model.display
        toolTip: model.description

        thumbnailAvailable: model.screenshot
        thumbnail: Image {
            anchors.fill: parent
            source: model.screenshot || ""
            sourceSize: Qt.size(delegate.GridView.view.cellWidth * Screen.devicePixelRatio,
                                delegate.GridView.view.cellHeight * Screen.devicePixelRatio)
        }
        actions: [
            Kirigami.Action {
                visible: model.fullScreenPreview !== ""
                iconName: "view-preview"
                tooltip: i18n("Preview Theme")
                onTriggered: {
                    previewWindow.url = model.fullScreenPreview;
                    previewWindow.showFullScreen();
                }
            }
        ]
        onClicked: {
            kcm.selectedPlugin = model.pluginName;
            view.forceActiveFocus();
            resetCheckbox.checked = false;
        }
    }

    footer: ColumnLayout {
        Kirigami.InlineMessage {
            Layout.fillWidth: true
            type: Kirigami.MessageType.Warning
            text: i18n("Your desktop layout will be lost and reset to the default layout provided by the selected theme.")
            visible: resetCheckbox.checked
        }

        RowLayout {
            Layout.fillWidth: true

            QtControls.CheckBox {
                id: resetCheckbox
                checked: kcm.resetDefaultLayout
                text: i18n("Use desktop layout from theme")
                onCheckedChanged: kcm.resetDefaultLayout = checked;
            }
            Item {
                Layout.fillWidth: true
            }
            QtControls.Button {
                text: i18n("Get New Global Themes...")
                icon.name: "get-hot-new-stuff"
                onClicked: kcm.getNewStuff(this);
                visible: KAuthorized.authorize("ghns")
            }
        }
    }

    Window {
        id: previewWindow
        property alias url: previewImage.source
        color: Qt.rgba(0, 0, 0, 0.7)
        MouseArea {
            anchors.fill: parent
            Image {
                id: previewImage
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                width: Math.min(parent.width, sourceSize.width)
                height: Math.min(parent.height, sourceSize.height)
            }
            onClicked: previewWindow.close()
            QtControls.ToolButton {
                anchors {
                    top: parent.top
                    right: parent.right
                }
                icon.name: "window-close"
                onClicked: previewWindow.close()
            }
            Shortcut {
                onActivated: previewWindow.close()
                sequence: "Esc"
            }
        }
    }
}
