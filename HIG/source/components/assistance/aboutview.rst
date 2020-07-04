About Application
=================

Every application should have a view that contains basic information about the
application. This includes a short description of the application, the version,
license, and authors and contributors of the application.

The about view should be accessible via an action in the application's primary
means of navigation, e.g. the menu bar, side bar or hamburger menu. The action
should have ``About MyApplication`` as text and use the ``help-about`` icon.

QML/Kirigami
~~~~~~~~~~~~
Kirigami apps should use the :kirigamiapi:`Kirigami.AboutPage <AboutPage>`
component. It consumes the data set by :kcoreaddonsapi:`KAboutData`. It should
cover all existing pages and must have a way to close it again. This can be
achieved by using the :kirigamiapi:`pageStack.layers <PageRow>` mechanism. It
should not be possible to open the AboutPage more than once.
::

    Component {
        id: aboutPage
        Kirigami.AboutPage {
            aboutData: theAboutData
        }
    }

    Kirigami.Action {
        text: i18n("About MyApplication")
        iconName: "help-about"
        onTriggered: {
            if (window.pageStack.layers.depth < 2) {
                window.pageStack.layers.push(aboutPage)
            }
        }
    }

Usage example

Qt Widgets
~~~~~~~~~~

When using the `KXmlGui
<https://api.kde.org/frameworks/kxmlgui/html/index.html>`_ framework an
appropriate about view is added automatically.
