import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.2
import org.kde.kirigami 2.19 as Kirigami

Kirigami.ApplicationWindow {
    title: "Clock"

    pageStack.initialPage: worldPage
    Kirigami.Page {
        id: worldPage
        title: "World"
        visible: false
    }
    Kirigami.Page {
        id: timersPage
        title: "Timers"
        visible: false
    }
    Kirigami.Page {
        id: stopwatchPage
        title: "Stopwatch"
        visible: false
    }
    Kirigami.Page {
        id: alarmsPage
        title: "Alarms"
        visible: false
    }
    
    
    footer: Kirigami.NavigationTabBar {
        actions: [
            Kirigami.Action {
                iconName: "globe"
                text: "World"
                checked: worldPage.visible
                onTriggered: {
                    while (pageStack.depth > 0) {
                        pageStack.pop();
                    }
                    pageStack.push(worldPage);
                }
            },
            Kirigami.Action {
                iconName: "player-time"
                text: "Timers"
                checked: timersPage.visible
                onTriggered: {
                    while (pageStack.depth > 0) {
                        pageStack.pop();
                    }
                    pageStack.push(timersPage);
                }
            },
            Kirigami.Action {
                iconName: "chronometer"
                text: "Stopwatch"
                checked: stopwatchPage.visible
                onTriggered: {
                    while (pageStack.depth > 0) {
                        pageStack.pop();
                    }
                    pageStack.push(stopwatchPage);
                }
            },
            Kirigami.Action {
                iconName: "notifications"
                text: "Alarms"
                checked: alarmsPage.visible
                onTriggered: {
                    while (pageStack.depth > 0) {
                        pageStack.pop();
                    }
                    pageStack.push(alarmsPage);
                }
            }
        ]
    }
}
