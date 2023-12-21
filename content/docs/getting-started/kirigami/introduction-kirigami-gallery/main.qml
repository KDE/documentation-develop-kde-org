import QtQuick 2.15
import org.kde.kirigami 2.20 as Kirigami
import QtQuick.Controls 2.15 as Controls

Kirigami.ApplicationWindow {
    id: root
    title: "Kirigami Tutorial"
    pageStack.initialPage: mainPageComponent

    Component {
        id: mainPageComponent

        Kirigami.ScrollablePage {
            title: "Address book (prototype)"
            
            Kirigami.CardsGridView{
                id: view
                model: ListModel {
                    id: mainModel
                }
                delegate: card
            }

            Component.onCompleted: {
                mainModel.append({
                    "firstname": "Pablo",
                    "lastname": "Doe",
                    "cellphone": "6300000002",
                    "email" : "jane-doe@example.com",
                    "photo": "qrc:/konqi.jpg"
                });
                mainModel.append({
                    "firstname": "Paul",
                    "lastname": "Adams",
                    "cellphone": "6300000003",
                    "email" : "paul-adams@example.com",
                    "photo": "qrc:/katie.jpg"
                });
                mainModel.append({
                    "firstname": "John",
                    "lastname": "Doe",
                    "cellphone": "6300000001",
                    "email" : "john-doe@example.com",
                    "photo": "qrc:/konqi.jpg"
                });
                mainModel.append({
                    "firstname": "Ken",
                    "lastname": "Brown",
                    "cellphone": "6300000004",
                    "email" : "ken-brown@example.com",
                    "photo": "qrc:/konqi.jpg"
                });
                mainModel.append({
                    "firstname": "Al",
                    "lastname": "Anderson",
                    "cellphone": "6300000005",
                    "email" : "al-anderson@example.com",
                    "photo": "qrc:/katie.jpg"
                });
                mainModel.append({
                    "firstname": "Kate",
                    "lastname": "Adams",
                    "cellphone": "6300000005",
                    "email" : "kate-adams@example.com",
                    "photo": "qrc:/konqi.jpg"
                });
            }

            Component {
                id: card
                Kirigami.Card {
                    height: view.cellHeight - Kirigami.Units.largeSpacing
                    banner {
                        title: i18nc("@title", "%1 %2", model.firstname, model.lastname)
                        titleIcon: "im-user"
                    }
                    contentItem: Column {
                        id: content
                        spacing: Kirigami.Units.smallSpacing

                        Controls.Label {
                            wrapMode: Text.WordWrap
                            text: i18nc("@label", "Mobile: %1", model.cellphone)
                        }

                        Controls.Label {
                            wrapMode: Text.WordWrap
                            text: i18nc("@label", "Email: %1", model.email)
                        }
                    }

                    actions: [
                        Kirigami.Action {
                            text: "Call"
                            icon.name: "call-start"
                            onTriggered: {
                                showPassiveNotification("Calling %1 %2...".arg(model.firstname).arg(model.lastname))
                            }
                        }                                        
                    ]
                }
            }
        }
    }
}

