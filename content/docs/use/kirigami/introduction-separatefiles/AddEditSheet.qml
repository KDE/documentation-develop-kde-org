import QtQuick 2.6
import QtQuick.Controls 2.3 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami

// Overlay sheets appear over a part of the window
Kirigami.OverlaySheet {
	id: addEditSheet
	
	// Sheet mode
	property string mode: "add"
	
	property int index: -1
	property string name: ""
	property string description: ""
	property string kdate: ""
	
	// Signals can be read and certain actions performed when these happen
	signal added (string name, string description, var kdate)
	signal edited(int index, string name, string description, var kdate)
	signal removed(int index)
	
	header: Kirigami.Heading {
		// i18nc is useful for adding context for translators
		text: mode === "add" ? i18nc("@title:window", "Add kountdown") : 
			i18nc("@title:window", "Edit kountdown")
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
			text: mode === "add" ? "" : name
			onAccepted: descriptionField.forceActiveFocus()
		}
		Controls.TextField {
			id: descriptionField
			Kirigami.FormData.label: i18nc("@label:textbox", "Description:")
			placeholderText: i18n("Optional")
			text: mode === "add" ? "" : description
			onAccepted: dateField.forceActiveFocus()
		}
		Controls.TextField {
			id: dateField
			Kirigami.FormData.label: i18nc("@label:textbox", "Date:")
			inputMask: "0000-00-00"
			placeholderText: i18n("YYYY-MM-DD")
			text: mode === "add" ? "" : kdate
		}
		// This is a button.
		Controls.Button {
			id: deleteButton
			Layout.fillWidth: true
			text: i18nc("@action:button", "Delete")
			visible: mode === "edit"
			onClicked: {
				addEditSheet.removed(addEditSheet.index)
				close();
			}
		}
		Controls.Button {
			id: doneButton
			Layout.fillWidth: true
			text: i18nc("@action:button", "Done")
			// Button is only enabled if the user has entered something into the nameField
			enabled: nameField.text.length > 0
			onClicked: {
				// Add a listelement to the kountdownModel ListModel
				if(mode === "add") {
					addEditSheet.added(
						nameField.text, 
						descriptionField.text, 
						dateField.text
					);
				}
				else {
					addEditSheet.edited(
						index, 
						nameField.text, 
						descriptionField.text, 
						dateField.text 
					);
				}
				close();
			}
		}
	}
}
