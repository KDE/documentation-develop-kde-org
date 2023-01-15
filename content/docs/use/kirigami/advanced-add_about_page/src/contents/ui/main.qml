import QtQuick 2.6
import QtQuick.Controls 2.0 as Controls
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.13 as Kirigami

import org.kde.example 1.0

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
			},
			Kirigami.Action {
				text: i18n("About")
				icon.name: "help-about"
				onTriggered: pageStack.layers.push(aboutPage)
			}
		]
	}

	Component {
		id: aboutPage

		Kirigami.AboutPage {
			aboutData: AboutType.aboutData
		}
	}

	
	// ListModel needed for ListView, contains elements to be displayed
	ListModel {
		id: kountdownModel
	}
	
	// Fetches item from addEditSheet.qml and does action on signal
	AddEditSheet { 
		id: addEditSheet
		onAdded: kountdownModel.append({
			"name": name, 
			"description": description, 
			"date": Date.parse(kdate)
		});
		onEdited: kountdownModel.set(index, {
			"name": name, 
			"description": description, 
			"date": Date.parse(kdate) 
		});
		onRemoved: kountdownModel.remove(index, 1)
	}

	// Function called by 'edit' button on card and by 'add'-Action
	function openPopulateSheet(mode, index = -1, listName = "", listDesc = "", listDate = "") {
		addEditSheet.mode = mode
		addEditSheet.index = index;
		addEditSheet.name = listName
		addEditSheet.description = listDesc
		addEditSheet.kdate = listDate

		addEditSheet.open()
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
			onTriggered: openPopulateSheet("add")
		}
		
		// List view for card elements
		Kirigami.CardsListView {
			id: layout
			// Model contains info to be displayed
			model: kountdownModel
			// Delegate is how the information will be presented in the ListView
			delegate: KountdownDelegate {}
		}
	}
}
