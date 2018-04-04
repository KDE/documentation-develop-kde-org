.. KDE HIG documentation master file, created by
   sphinx-quickstart on Tue Feb  6 13:29:47 2018.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

KDE Human Interface Guidelines (Desktop Platform)
=================================================

.. toctree::
   :caption: Contents:
   :titlesonly:

   introduction/index
   layout/index
   style/index
   components/index
   patterns/command/index
   patterns/navigation/index
   patterns/iconandtext
   resources/contribute


.. Indices and tables
   ==================

   * :ref:`genindex`
   * :ref:`modindex`
   * :ref:`search`

The Classic KDE Human Interface Guidelines (HIG) offer application designers and developers a set of recommendations for designing and developing user interfaces for QWidget-based, desktop-only applictions. Their aim is to improve the experience for users by making application interfaces more consistent and hence more intuitive and learnable.

For applications which are supposed to run on both desktop and mobile systems, consult the [[../KirigamiHIG | Kirigami Human Interface Guidelines (HIG)]]

Getting Started
---------------
* :doc:`introduction/vision` - The overall vision and principles that guide the design and development of user interfaces for KDE software.
* :ref:`Concept` -  Creating a project vision, determining the users, and the scenarios of use.
*  :ref:`Organization` - Guidelines on how an application’s content and functionality are ordered and categorized.
* :doc:`introduction/architecture` Architecture of KDE
* :ref:`Contribute` Contribute to the HIG]]

Behaviour
---------
This section contains guidelines for application behaviour.

* :ref:`ViewingAndNavigation` Guidelines on controls and patterns to use for viewing, navigating and performing actions on application content.
* :ref:`EditingAndManipulation` Guidelines on controls and patterns to use for selection and input.
* :ref:`UserAssistance` Guidelines on tooltips, notifications, messages and help.
* :ref:`Patterns` Patterns - Guidelines on how to use controls in different combinations to accomplish specific behaviors.

Presentation
------------
Presentation deals with the visual design of the user interface.

* :ref:`Layout` Guidelines regarding the placement and ordering of onscreen elements. Includes guidance on layout patterns, alignment, size and spacing.
* :ref:`Style` Guidelines on the use of colour, icon design and the typography to communicate with a consistent visual vocabulary.
* :ref:`Text` Guidelines for the written, language-based elements of the interface. Includes guidelines on wording, capitalization and localization.
* :doc:`style/typography`

Tools and Resources
-------------------
The following tools and resources are offered to help with following these guidelines.

* :ref:`ControlsList` A complete listing of all user interface controls and their guidelines in alphabetical order.
* :ref:`MockupToolkit` Includes UI controls stencils, color swatches and fonts to help create the visual design your application.
* :ref:`About` Learn more about the philosophy behind the KDE HIG.
* [http://forum.kde.org/viewforum.php?f=285 Visual Design Group forum] - Ask for help and share your design ideas.

Quick index for the new mobile-oriented HIG (work in progress)
--------------------------------------------------------------
Drawers & FAB
^^^^^^^^^^^^^
* :ref:`GlobalDrawer`
* :ref:`ContextDrawer`
* :ref:`FloatingActionButton`
* :ref:`QuickContentActions`

Navigation
^^^^^^^^^^
* :ref:`ViewsByColumns`
* :ref:`ContentsFilter`
* :ref:`Views-by-tabs`

Editing
^^^^^^^
* :ref:`RearrangeListItems` | Rearrange list's items]]

App settings
^^^^^^^^^^^^
* :ref:`VBCtoSettings` | Views-by-columns approach applied to settings]]

Cross-apps interactions
-----------------------
* :ref:`SharingContents` | Sharing contents to an other app]]

Complete app examples
---------------------
* App store (to be applied to Muon Mobile)
* E-mail client
* Media player
