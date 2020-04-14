Architecture
============

All KDE software is built using the Qt toolkit. You will be using different
components depending on whether you are developing an
`application <https://www.kde.org/applications/>`_ or
`Plasma <https://www.kde.org/plasma-desktop.php>`_ and the nature of your
application. The interaction patterns of the HIG apply regardless of the
components you use.

KDE Applications
----------------

Qt offers two ways of defining the application UI. Which
one to choose depends on the nature of your application. The application logic
is written in C++ (or other supported languages) regardless of that.

Qt Widgets
^^^^^^^^^^

`Qt Widgets <http://doc.qt.io/qt-5/qtwidgets-index.html>`_ is the traditional
way of writing Qt applications. It is best suited for traditional desktop
applications with complex UI, e.g. KDevelop.

QML/QtQuick/Kirigami
^^^^^^^^^^^^^^^^^^^^

QML/QtQuick is the modern way of developing Qt applications. It features a
declarative approach to writing touch and mobile friendly UIs with fluent
gestures. It is best suited for mobile and convergent applications.

`Kirigami <https://www.kde.org/products/kirigami/>`_ builds on top of QtQuick
and helps you write convergent applications. It features controls that adapt
their presentation according to the device's form factor.

.. figure:: /img/kirigami.jpg
   :scale: 25%
   :alt: Discover, a convergent application built with Kirigami

   Discover, a convergent application built using Kirigami

.. hint::
   |devicon| To test qml scenes use

   * ``QT_QUICK_CONTROLS_MOBILE=1`` and ``QT_QUICK_CONTROLS_STYLE=Plasma``
     for mobile
   * ``QT_QUICK_CONTROLS_MOBILE=0`` and
     ``QT_QUICK_CONTROLS_STYLE=org.kde.desktop`` for desktop

Plasma
------
Plasma is built out of widgets (also called Plasmoids), allowing you to move,
mix, add, and remove just
about everything to perfect your personal workflow.` Those are built
using Plasma Components 3
<https://api.kde.org/frameworks/plasma-framework/html/plasmacomponents
.html>`_, which are based on Qt Quick Controls 2.

.. figure:: /img/plasma-workspace.jpg
   :scale: 25%
   :alt: Plasma desktop and mobile

   Plasma desktop and mobile.


Common Components
-----------------

The KDE HIG defines a set of common components which are independent of any 
:doc:`device type <devicetypes>`.

.. figure:: /img/Desktop_UX.png
   :scale: 25%
   :alt: Example showing the common components on a Desktop device type

   
- **Workspace**: The top-level container of the whole user interface. Often
  called "desktop", "home screen", or "shell", it shows the wallpaper and
  allows users to add widgets, app launchers, files or folders.

- **Application Launcher**: Provides an overview of installed applications and
  allows the user to launch one of them.

- **Application Shortcuts**: Provides quick access to frequently-used
  applications.

- **Active Application Overview**: Provides an overview of the active
  applications that are directly used by the user.

- **Workspace Tools**: Provides quick access to functionality integrated
  into the workspace that is both highly visible to the user and frequently
  changed, like enabling/disabling WiFi and Bluetooth, or whether or not to
  show notifications.

- **Application-Workspace Interaction**: Displays information about each
  application's windows, and provides ways to move or close them and change how
  they run within the workspace.

- **Application**: The top-level container of a single application.

- **Application Tools**: Provides access to an application's commonly-used
  functionality in an always-accessible toolbar or menubar. These tools should
  not change depending on what the application is displaying.

- **Application Content**: The actual content of an application. This depends
  on the application itself, but conformance to the KDE HIG should make it
  easier to allow :doc:`convergence <convergence>` for this  component. This 
  part of the application can also contain contextually-appropriate tools 
  that operate directly on the active or selected content.

.. figure:: /img/Mobile-UX.png
   :scale: 50%
   :alt: Example showing the common components on a Mobile device type
   
Theme
-----
There are three different kinds of themes influencing the the look-and-feel of KDE applications and the Plasma workspace.

* Workspace
* Application
* Window decoration

The default for all there of them is *Breeze*.

.. note::
   Only *Breeze*, *Breeze dark*, *Breeze Light*, *Breeze Highcontrast*  are covered by the HIG, all other themes are not covered.

.. figure:: /img/breeze.jpeg
   :scale: 50%
   :alt: Overview of breeze controls

   Overview of breeze controls
