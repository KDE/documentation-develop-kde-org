Contribute
==========

The HIG is written in `reStructuredText <http://www.sphinx-doc.org/en/stable/rest.html>`_, a lightweight markup language.
For example the chapter heading together with the first paragraph looks like this in reStructuredText::

   Contribute
   ==========

   The HIG is written in `reStructuredText <http://www.sphinx-doc.org/en/stable/rest.html>`_, a light weight markup language.
   For example the chapter heading together with the first paragraph look in reStructuredText like this

The restructuredText of the full HIG is organized into several source files. You can view and modify these source files with any text editor.

The source files are hosted in a `Git repo <https://cgit.kde.org/websites/hig-kde-org.git/>`_. `Sphinx <http://www.sphinx-doc.org>`_ is used to generate HTML pages from these source files. Tasks and changes are organized via `Phabricator <https://phabricator.kde.org/project/profile/264/>`_.

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
   * Debian/Ubuntu/KDE Neon ``sudo apt install git build-essential python3-sphinx``

#. Clone HIG repositories into an empty folder
   ``git clone https://anongit.kde.org/websites/hig-kde-org.git``
#. ``cd hig-kde-org.git``
#. Run ``make html`` to create the HTML pages
#. Open ``build/html/index.html`` in your browser
