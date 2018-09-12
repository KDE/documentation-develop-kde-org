Architecture
============

There are three different UI toolkits you can use to development for `KDE Application <https://www.kde.org/applications/>`_ or the `Plasma Workspace <https://www.kde.org/plasma-desktop.php>`_ (Due to technical limitations, the toolkits have slight visual differences, but the recommended interaction patterns to be used are consistent regardless of the toolkit).

KDE Applications
----------------
There are two UI toolkits that can be used to develop KDE Applications:

* `Kirigami <https://www.kde.org/products/kirigami/>`_
* `Qt Widgets <http://doc.qt.io/qt-5/qtwidgets-index.html>`_

Kirigami is KDE’s lightweight user interface framework for mobile and convergent applications. It allows Qt developers to easily create applications that run on most major mobile and desktop platforms without modification (though adapted user interfaces for different form-factors are supported and recommended for optimal user experience). It extends the touch-friendly Qt Quick Controls with larger application building blocks.

Use Qt Widgets only if you plan to develop a desktop-only application with a complex UI, like KDevelop.

.. figure:: /img/kirigami.jpg
   :scale: 25%
   :alt: Discover, a convergent application build with Kirigami

   Discover, a convergent application build using Kirigami

Plasma Workspace
----------------
Plasma is built on widgets, allowing you to move, mix, add, and remove just about everything to perfect your personal workflow. Use `plasma components v3 <https://api.kde.org/frameworks/plasma-framework/html/plasmacomponents.html>`_ to develop widgets for the Plasma Mobile and Plasma Desktop workspace.

.. figure:: /img/plasma-workspace.jpg
   :scale: 25%
   :alt: Plasma desktop and mobile workspace

   Plasma desktop and mobile workspace.

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
