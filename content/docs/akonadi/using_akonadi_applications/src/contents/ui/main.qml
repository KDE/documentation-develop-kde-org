import QtQuick 2.15
import QtQuick.Layouts 1.15
import org.kde.kirigami 2.14 as Kirigami
import QtQuick.Controls 2.15 as Controls
import org.kde.kitemmodels 1.0 as KItemModels
import org.kde.quickmail.private 1.0

Kirigami.ApplicationWindow {
    id: root

    title: i18n("KMailQuick")

    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }

//snippet_begin(initial)
    pageStack.initialPage: QuickMail.loading ? loadingPage : mainPageComponent

    Component {
        id: loadingPage
        Kirigami.Page {
            Kirigami.PlaceholderMessage {
                anchors.centerIn: parent
                text: i18n("Loading, please wait...")
            }
        }
    }
//@@snippet_end

//snippet_begin(mainPage)
    Component {
        id: mainPageComponent

        Kirigami.ScrollablePage {
            title: i18n("KMailQuick")

            ListView {
                model: QuickMail.descendantsProxyModel
                delegate: Kirigami.BasicListItem {
                    text: model.display
                    leftPadding: Kirigami.Units.gridUnit * model.kDescendantLevel
                    onClicked: {
                        QuickMail.loadMailCollection(model.index);
                        root.pageStack.push(folderPageComponent, {
                            title: model.display
                        });
                    }
                }
            }
        }
    }
//@@snippet_end

//snippet_begin(maillist)
    Component {
        id: folderPageComponent

        Kirigami.ScrollablePage {
            ListView {
                id: mails
                model: QuickMail.folderModel
                delegate: Kirigami.BasicListItem {
                    label: model.title
                    subtitle: sender
                    onClicked: {
                        root.pageStack.push(mailComponent, {
                            'mail': model.mail
                        });
                    }
                }
            }
        }
    }
//@@snippet_end

//snippet_begin(mail)
    Component {
        id: mailComponent

        Kirigami.ScrollablePage {
            required property var mail
            title: mail.subject

            ColumnLayout {
                Kirigami.FormLayout {
                    Layout.fillWidth: true
                    Controls.Label {
                        Kirigami.FormData.label: i18n("From:")
                        text: mail.from
                    }
                    Controls.Label {
                        Kirigami.FormData.label: i18n("To:")
                        text: mail.to.join(', ')
                    }
                    Controls.Label {
                        visible: mail.sender !== mail.from && mail.sender.length > 0
                        Kirigami.FormData.label: i18n("Sender:")
                        text: mail.sender
                    }
                    Controls.Label {
                        Kirigami.FormData.label: i18n("Date:")
                        text: mail.date.toLocaleDateString()
                    }
                }
                Kirigami.Separator {
                    Layout.fillWidth: true
                }
                Controls.TextArea {
                    background: Item {}
                    textFormat: TextEdit.AutoText
                    Layout.fillWidth: true
                    readOnly: true
                    selectByMouse: true
                    text: mail.content
                    wrapMode: Text.Wrap
                }
            }
        }
//@@snippet_end
    }
}
