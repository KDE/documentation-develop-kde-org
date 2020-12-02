/**
 * SPDX-FileCopyrightText: 2020 Carl Schwan <carl@carlschwan.eu>
 *
 * SPDX-License-Identifier: BSD-3-Clauses
 */
import QtQuick 2.2
import QtQuick.Controls 2.14
import org.kde.filesystembrowser 1.0
import org.kde.kirigami 2.14 as Kirigami
import org.kde.kirigamiaddons.treeview 1.0
import Qt.labs.qmlmodels 1.0

ApplicationWindow {
    visible: true
    width: 900
    height: 480
    title: i18n("File System")

    SplitView {
        anchors.fill: parent
        ScrollView {
            SplitView.preferredWidth: 300
            TreeListView {
                model: FileSystemModel {}
                expandsByDefault: false
                delegate: BasicTreeItem {
                    label: display
                }
            }
        }
        ScrollView {
            SplitView.preferredWidth: 600
            TreeTableView {
                model: FileSystemModel { }
                expandsByDefault: false
                columnWidthProvider: function (column) { return column === 0 ? 220 : 120 }
                delegate: DelegateChooser {
                    DelegateChoice {
                        column: 0
                        BasicTreeItem {
                            label: display
                        }
                    }
                    DelegateChoice {
                        Label {
                            text: display
                        }
                    }
                }
            }
        }
    }
}
