Contribute
==========

The HIG source code is managed using Git and is hosted on https://cgit.kde.org/websites/hig-kde-org.git/ . `Sphinx <http://www.sphinx-doc.org>`_ is used to create HTML pages from the source files. `Phabricator <https://phabricator.kde.org/project/profile/264/>`_ is used to organize tasks and todos.

If you are new to KDE devlopment, make sure to read `how to become a kde developer <https://community.kde.org/Get_Involved/development>`_ first.

Getting started
---------------

#. Install Spinx with your distro's package manager

   * openSuse ``sudo zypper in git python3-Sphinx python3-sphinx_rtd_theme``
   * Debian/Ubuntu/KDE Neon ``sudo apt install git build-essential python3-sphinx``

#. Clone HIG repositories into an empty folder
   ``git clone https://anongit.kde.org/websites/hig-kde-org.git``
#. ``cd hig-kde-org.git``
#. Run ``make html`` to create the HTML pages
#. Open ``build/html/index.html`` in your browser
