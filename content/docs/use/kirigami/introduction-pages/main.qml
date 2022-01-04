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
	
	// Initial page to be loaded on app load
	pageStack.initialPage: Kirigami.ScrollablePage {
		// Title for the current page, placed on the toolbar
		title: i18nc("@title", "Kountdown")

	}
}
