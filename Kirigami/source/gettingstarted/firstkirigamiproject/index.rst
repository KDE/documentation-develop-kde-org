First Kirigami Project
======================

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   cmakedynamic
   cmakestatic
   qmakestatic
   

Kirigami can be used in your project in different ways, depending from the 
build system and the deployment needs.

CMake
-----
CMake is the recommended build system for Kirigami based applications. It can 
be built and used in two ways
- Dynamic: This is the preferred way. Kirigami is built and linked as a dynamic 
plugin and library. Usually system packages of Kirigami are used, tough this 
mode can also be used with containerized solutions such as flatpak, Snap and 
Appimage.
- Static: Kirigami is statically linked inside the application executable: it 
simplified deployment but some features are lost. It is not recommended to use 
this for deployment on Linux desktop systems.

* :doc:`cmakedynamic`
* :doc:`cmakestatic`

QMake
-----
The Kirigami dynamic build can also be used from a qmake-based project.
QMake can also be used to statically build and link Kirigami into a qmake-based 
project.

* :doc:`qmakestatic`

