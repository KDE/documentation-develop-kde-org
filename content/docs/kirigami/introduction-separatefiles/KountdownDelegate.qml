import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami

Kirigami.AbstractCard {
	id: kountdownDelegate
	// contentItem property includes the content to be displayed on the card
	contentItem: Item {
    	// implicitWidth/Height define the natural width/height of an item if no width or height is specified
		// The setting below defines a component's preferred size based on its content
		implicitWidth: delegateLayout.implicitWidth
		implicitHeight: delegateLayout.implicitHeight
		GridLayout {
			id: delegateLayout
			// QtQuick anchoring system allows quick definition of anchor points for positioning
			anchors {
				left: parent.left
				top: parent.top
				right: parent.right
			}
			rowSpacing: Kirigami.Units.largeSpacing
			columnSpacing: Kirigami.Units.largeSpacing
			columns: root.wideScreen ? 4 : 2
				
			Kirigami.Heading {
				// Heading will be as tall as possible while respecting constraints
				Layout.fillHeight: true
				// Level determines the size of the heading
				level: 1
				text: i18n("%1 days", Math.round((date-Date.now())/86400000))
			}
			
			// Layout for positioning elements vertically
			ColumnLayout {
				Kirigami.Heading {
					Layout.fillWidth: true
					level: 2
					text: name
				}
				// Horizontal rule
				Kirigami.Separator {
					Layout.fillWidth: true
					visible: description.length > 0
				}
				// Labels contain text
				Controls.Label {
					Layout.fillWidth: true
					// Word wrap makes text stay within box and shift with size
					wrapMode: Text.WordWrap
					text: description
					visible: description.length > 0
				}
			}
			Controls.Button {
				Layout.alignment: Qt.AlignRight
				// Column spanning within grid layout (vertically in this case)
				Layout.columnSpan: 2
				text: i18n("Edit")
				onClicked: openPopulateSheet("edit", index, name, description, date = new Date(date).toISOString().slice(0,10))
			}
		}
	}
}
