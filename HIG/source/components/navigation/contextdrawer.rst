Context drawer
==============

.. container:: intend

   |desktopicon| |mobileicon|

.. container:: available plasma qwidgets

   |nbsp|


.. figure:: /img/Contextdrawer1.png
   :figclass: border
   :scale: 50 %
   :alt: Examples of a context drawer on mobile

   Examples of a context drawer on mobile

Purpose
-------

The Context Drawer is used to access controls that depend on the current
context. This can be, for example, controls that affect a selected
element in a list or that navigate through an opened document.

Is this the right control?
--------------------------

Use a Context Drawer if your application has any functions which are
only relevant in specific contexts, and which are not central enough to
the application's main purpose to put them in the main user interface or
in a toolbar. For actions which are always available, use the :doc:`Global Drawer <globaldrawer>`.

Guidelines
----------

-  The Context Drawer is opened by swiping in from the left or right
   edge of the screen (depending on a system-wide setting) and closed by
   swiping in the other direction or tapping outside of it.
-  At the top of the drawer, state which object the controls affect
   (e.g. "Selected email")
-  By default, the Context Drawer simply contains a vertical list of
   action buttons which affect the currently selected/opened element

   -  Center the list vertically instead of top-aligning, to allow an
      easier reach with the thumb

-  If needed, other controls related to the current context can be put
   in the Context Drawer

   -  Try to keep the content of the context drawer in one page. If
      there two distinct "modes" of contextual actions (for example
      navigating through a PDF either by table of contents or
      thumbnails), consider using two :doc:`Tabs <tab>` to separate them, but
      never use more than two tabs.

.. figure:: /img/Contextdrawer2.png
   :figclass: border
   :scale: 50 %
   :alt: Examples of a context drawer on desktop

   Examples of a context drawer on desktop
   
Code
----

Kirigami
^^^^^^^^

.. code-block:: qml

    ...
    import QtQuick.Controls 2.2 as Controls
    import org.kde.kirigami 2.4 as Kirigami
    ...
    
    Kirigami.ApplicationWindow {
        ...
        pageStack.initialPage: Kirigami.ScrollablePage {
            ...
            actions {
                ...
                contextualActions: [
                    Kirigami.Action {
                        iconName: "favorite"
                        text: i18n("&Select as favorite")
                    },
                    Kirigami.Action {
                        iconName: "document-share"
                        text: i18n("&Share")
                    },
                    Kirigami.Action {
                        iconName: "document-edit"
                        text: i18n("&Edit")
                    },
                    Kirigami.Action {
                        iconName: "edit-image-face-add"
                        text: i18n("&Choose photo")
                    },
                    Kirigami.Action {
                        iconName: "im-kick-user"
                        text: i18n("&Block number")
                    },
                    Kirigami.Action {
                        iconName: "delete"
                        text: i18n("&Delete contact")
                    },
                    Kirigami.Action {
                        iconName: "edit-clear-history"
                        text: i18n("&Delete history")
                    }
                ]
                ...
            }
        }
        ...
        contextDrawer: Kirigami.ContextDrawer {
        }
        ...
    }
