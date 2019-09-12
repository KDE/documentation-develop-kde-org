Contribute
==========

The HIG is written in 
`reStructuredText <http://www.sphinx-doc.org/en/stable/rest.html>`_, a 
lightweight markup language. For example the chapter heading together with the 
first paragraph looks like this in reStructuredText

.. code-block:: rst

   Contribute
   ==========

   The HIG is written in 
   `reStructuredText <http://www.sphinx-doc.org/en/stable/rest.html>`_, a light 
   weight markup language. For example the chapter heading together with the 
   first paragraph looks like this in reStructuredText

The restructuredText of the full HIG is organized into several source files. 
You can view and modify these source files with any text editor.

The source files are hosted in a 
`Git repo <https://cgit.kde.org/websites/hig-kde-org.git/>`_. 
`Sphinx <http://www.sphinx-doc.org>`_ is used to generate HTML pages from these 
source files. Tasks and changes are organized via 
`https://invent.kde.org <https://invent.kde.org/websites/hig-kde-org>`_.

.. note:: On every page of the HIG, there is a *View page source* link in the top right corner.

For more information and help you can find us on 
`Matrix <https://matrix.to/#/#kde_vdg:matrix.org>`_, 
`IRC <irc://chat.freenode.net/kde-vdg>`_ or 
`Telegram <https://telegram.me/vdgmainroom>`_
.

If you are new to KDE devlopment, make sure to read 
`how to become a kde developer 
<https://community.kde.org/Get_Involved/development>`_ first.

Getting Started
---------------

#. Install some tools with your distro's package manager:

================================== ================================
Distribution                       Command
================================== ================================
Arch, Manjaro                      ``sudo pacman -S git make``
Debian, Ubuntu, KDE Neon           ``sudo apt install git make``
openSUSE                           ``sudo zypper install git make``
Fedora                             ``sudo dnf install git make``
CentOS/RHEL                        ``sudo yum install git make``
================================== ================================

#. Clone the HIG source code repository into an empty folder:

   .. code-block:: sh

      git clone https://invent.kde.org/websites/hig-kde-org.git
      cd hig-kde-org
      
#. Install some tools with Python's package manager, Pip. Pip should already be
   Installed, but if for some reason it is not, here are instructions for
   getting it: https://pip.pypa.io/en/stable/installing/
   
   You can use Pip to install the required python modules either globally:
   
   .. code-block:: sh

      sudo pip install -r HIG/requirements.txt

   ...or in your home directory:
    
   .. code-block:: sh

      pip install -r HIG/requirements.txt --user
       
   If you install it in you home directory, make sure you have the 
   installed packages in your path by adding it to your .profile:
   
   .. code-block:: sh

      echo "PATH=~/.local/lib:\$PATH" >> ~/.profile
      source ~/.profile

   
Now you are ready to contribute to the HIG! To preview changes on your local
machine, do the following:

#. Enter the HIG directory with ``cd HIG``
#. Run ``make html`` to create the HTML pages
#. Open ``build/html/index.html`` in your browser (e.g. run
   ``firefox build/html/index.html``)

Page Structure
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
    
    Link to the API and example code how to use the component with QML and 
    Kirigami.
    
    Qt Widgets
    ~~~~~~~~~~
    
    Link to the API and example code how to use the component with Qt Widgets.
    
Optional: you can add subsections for desktop and mobile.

::

    Behavior
    ~~~~~~~~
    
    Desktop
    """""""
    
    Mobile
    """"""

Code Examples
-------------

Adding examples to the HIG is very easy.

#. Add a file with source code in the ``./examples/`` folder.
#. Add the following markup at the point you want to insert the example:

   .. code-block:: rst
   
      .. literalinclude:: /../../examples/kirigami/InlineMessage.qml
         :language: qml

Creating media
-------------

See :doc:`media` on how to create media files for the HIG.
