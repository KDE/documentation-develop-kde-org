...
import org.kde.kirigami 2.9 as Kirigami
...

Kirigami.ApplicationWindow {
    ...
    menuBar: MenuBar {
        Menu {
            title: i18n("&File")
            Action { text: i18n("&New...") }
            Action { text: i18n("&Import") }
            Action { text: i18n("&Export") }
        }
        Menu {
            title: i18n("&Edit")
            Action { text: i18n("&Merge contacts") }
            Action { text: i18n("&Search dupplicate contacts") }
            Action { text: i18n("&Export") }
        }
        Menu {
            title: i18n("&Settings")
            Action { text: i18n("&Settings") }
            Action { text: i18n("&Configure shortcuts") }
        }
        Menu {
            title: i18n("&Help")
            Action { text: i18n("&Report Bug...") }
            Action { text: i18n("&Donate") }
            Action { text: i18n("&About Addressbook") }
            Action { text: i18n("&About KDE") }
        }
    }
    ...
}
