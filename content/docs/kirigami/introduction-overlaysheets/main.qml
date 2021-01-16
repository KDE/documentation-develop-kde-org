import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami

// Base element, provides basic features needed for all kirigami applications
Kirigami.ApplicationWindow {
	// ID provides unique identifier to reference this element
	id: root
	
	// Window title
	title: i18nc("@title:window", "Day Kountdown")

	// Global drawer element with app-wide actions
	globalDrawer: Kirigami.GlobalDrawer {
		// Makes drawer a small menu rather than sliding pane
		isMenu: true
		actions: [
			Kirigami.Action {
				text: i18n("Quit")
				icon.name: "gtk-quit"
				shortcut: StandardKey.Quit
				onTriggered: Qt.quit()
			}
		]
	}
	
	// ListModel needed for ListView, contains elements to be displayed
	ListModel {
		id: kountdownModel
	}
	
	Component {
		id: kountdownDelegate
		Kirigami.AbstractCard {
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
						//onClicked: to be done... soon!
					}
				}
			}
		}
	}

	// Overlay sheets appear over a part of the window
	Kirigami.OverlaySheet {
		id: addSheet
		header: Kirigami.Heading {
			text: i18nc("@title:window", "Add kountdown")
		}
		// Form layouts help align and structure a layout with several inputs
		Kirigami.FormLayout {
			// Textfields let you input text in a thin textbox
			Controls.TextField {
				id: nameField
				// Provides label attached to the textfield
				Kirigami.FormData.label: i18nc("@label:textbox", "Name:")
				// Placeholder text is visible before you enter anything
				placeholderText: i18n("Event name (required)")
				// What to do after input is accepted (i.e. pressed enter)
				// In this case, it moves the focus to the next field
				onAccepted: descriptionField.forceActiveFocus()
			}
			Controls.TextField {
				id: descriptionField
				Kirigami.FormData.label: i18nc("@label:textbox", "Description:")
				placeholderText: i18n("Optional")
				onAccepted: dateField.forceActiveFocus()
			}
			Controls.TextField {
				id: dateField
				Kirigami.FormData.label: i18nc("@label:textbox", "Date:")
				placeholderText: i18n("YYYY-MM-DD")
				inputMask: "0000-00-00"
			}
			Controls.Button {
				id: doneButton
				Layout.fillWidth: true
				text: i18nc("@action:button", "Done")
				// Button is only enabled if the user has entered something into the nameField
				enabled: nameField.text.length > 0
				onClicked: {
					// Add a listelement to the kountdownModel ListModel
					kountdownModel.append({
						name: nameField.text, 
						description: descriptionField.text, 
						date: Date.parse(dateField.text)
					});
					nameField.text = ""
					descriptionField.text = ""
					dateField.text = ""
					addSheet.close();
				}
			}
		}
	}

	
	// Initial page to be loaded on app load
	pageStack.initialPage: Kirigami.ScrollablePage {
		// Title for the current page, placed on the toolbar
		title: i18nc("@title", "Kountdown")

		// Kirigami.Action encapsulates a UI action. Inherits from QQC2 Action
		actions.main: Kirigami.Action {
			id: addAction
			// Name of icon associated with the action
			icon.name: "list-add"
			// Action text, i18n function returns translated string
			text: i18nc("@action:button", "Add kountdown")
			// What to do when triggering the action
			onTriggered: loadedAddSheet.item.open()
		}
		
		// List view for card elements
		Kirigami.CardsListView {
			id: layout
			// Model contains info to be displayed
			model: kountdownModel
			// Delegate is how the information will be presented in the ListView
			delegate: kountdownDelegate
		}
	}
}
