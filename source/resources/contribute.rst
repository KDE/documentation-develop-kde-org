Contribute
==========

The HIG is written in `reStructuredText <http://www.sphinx-doc.org/en/stable/rest.html>`_, a lightweight markup language.
For example the chapter heading together with the first paragraph looks like this in reStructuredText::

   Contribute
   ==========

   The HIG is written in `reStructuredText <http://www.sphinx-doc.org/en/stable/rest.html>`_, a light weight markup language.
   For example the chapter heading together with the first paragraph look in reStructuredText like this

The restructuredText of the full HIG is organized into several source files. You can view and modify these source files with any text editor.

The source files are hosted in a `Git repo <https://cgit.kde.org/websites/hig-kde-org.git/>`_. `Sphinx <http://www.sphinx-doc.org>`_ is used to generate HTML pages from these source files. Tasks and changes are organized via `Phabricator <https://phabricator.kde.org/project/board/264/>`_.

.. note:: On every page of the HIG, there is a *View page source* link in the top right corner.

For more information and help you can find us on 
`Matrix <https://matrix.to/#/#kde_vdg:matrix.org>`_, 
`IRC <irc://chat.freenode.net/kde-vdg>`_ or 
`Telegram <https://telegram.me/vdgmainroom>`_
.

If you are new to KDE devlopment, make sure to read `how to become a kde developer <https://community.kde.org/Get_Involved/development>`_ first.

Getting started
---------------
#. Install git with your distro's package manager

   * openSuse ``sudo zypper in git``
   * Debian/Ubuntu/KDE Neon ``sudo apt install git``

#. Clone HIG repositories into an empty folder
   ``git clone https://anongit.kde.org/websites/hig-kde-org.git``

Now you are ready to contribute to the HIG!

Spinx
^^^^^
You only need to install Sphinx, if you want to preview changes on your local machine.

#. Install Spinx with your distro's package manager

   * openSuse ``sudo zypper in git python3-Sphinx python3-sphinx_rtd_theme``
   * Debian/Ubuntu/KDE Neon ``sudo apt install git build-essential python3-sphinx python3-sphinx-rtd-theme``

#. Clone HIG repositories into an empty folder
   ``git clone https://anongit.kde.org/websites/hig-kde-org.git``
#. ``cd hig-kde-org.git``
#. Run ``make html`` to create the HTML pages
#. Open ``build/html/index.html`` in your browser

Page structure
--------------

This defines the structure that should be used for writing pattern and 
component pages for the HIG.

Pattern
^^^^^^^

::
    
    Pattern name
    ==============
    
    Give a short into into the pattern.
    
    Examples
    --------
    
    Showcase the pattern with videos or images.
    
    When to use
    -----------
    
    Describe when to use this pattern and when not to use it.
    
    How to use
    ----------
    
    Describe how to use this pattern.
    
Pages about patterns should not include any details on implementation, about 
behavior or appearance, but rather link to the corresponding components needed 
to implement a pattern.

Optional: you can add subsections for desktop and mobile.

::

    When to use
    -----------
    
    Desktop
    ^^^^^^^
    
    Mobile
    ^^^^^^

Component
^^^^^^^^^

::

    Component name
    ==============

    Purpose
    -------
    
    A very short description on why and how to use the component. This should 
    primarily link to the corresponding pattern pages.
    
    Example
    -------
    
    Showcase the component with a video or image.
    
    Guidelines
    ----------

    Is this the right control
    ~~~~~~~~~~~~~~~~~~~~~~~~~
    
    Describe when to use a component and when not.
    
    Behavior
    ~~~~~~~~
    
    Describe the behavior of the component.
    
    Appearance
    ~~~~~~~~~~

    Describe the appearance of the component.
    
    Code
    ----
    
    Kirigami
    ~~~~~~~~
    
    Example code how to use the component with QML and Kirigami.
    
    Qt Widgets
    ~~~~~~~~~~
    
    Example code how to use the component with Qt Widgets.
    
    API
    ~~~
    
    Link to KDE and Qt API pages.
    
Optional: you can add subsections for desktop and mobile.

::

    Behavior
    ~~~~~~~~
    
    Desktop
    """""""
    
    Mobile
    """"""
