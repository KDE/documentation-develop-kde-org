...
ListView {
    ...

    delegate: Kirigami.SwipeListItem {
        id: lineItem
        
        contentItem: Row {
            spacing: lineItem.leftPadding

            Item {
                width: Kirigami.Units.iconSizes.medium
                height: width

                Image {
                    id: avatar
                    width: parent.width
                    height: width
                    source: "..."
                    visible: false
                }
                OpacityMask {
                    anchors.fill: avatar
                    source: avatar
                    maskSource: Rectangle {
                        height: avatar.width
                        width: height
                        radius: height / 2
                    }
                }
            }
            Label {
                anchors.verticalCenter: parent.verticalCenter
                text: "..."
            }
        }
        actions: [
            Kirigami.Action {
                text: i18n("&Make call")
                iconName: "call-start"
            },
            Kirigami.Action {
                text: i18n("&Write mail")
                iconName: "mail-message"
            }
        ]
    }
    
    ...
}
...
