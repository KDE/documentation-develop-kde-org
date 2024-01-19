---
title: Generate media
aliases:
- /hig/media
---

Most media files used in the HIG are generated from QML files.

The command line tool
[qmlgrabber](https://invent.kde.org/mart/qmlgrabber) is used
to create media from the source files.

Source files are located in `HIG/source/qml`.

If you are new to KDE development, make sure to read [how to become a kde
developer](https://community.kde.org/Get_Involved/development) first.

Getting Started
---------------

1.  Install some tools with your distro\'s package manager:

  Distribution               Command
  -------------------------- --------------------------------
  Arch, Manjaro              `sudo pacman -S ffmpeg`
  Debian, Ubuntu, KDE Neon   `sudo apt install ffmpeg`
  openSUSE                   `sudo zypper install ffmpeg-4`
  Fedora                     `sudo dnf install ffmpeg`
  CentOS/RHEL                `sudo yum install ffmpeg`

1.  Clone qmlgrabber source code repository into an empty folder:

    ``` {.sh}
    git clone https://invent.kde.org/mart/qmlgrabber.git
    cd qmlgrabber
    qmake PREFIX=~/.local/bin
    make
    make install
    ```

    If you install it in you home directory, make sure you have the
    installed packages in your path by adding it to your .profile:

    ``` {.sh}
    echo "PATH=~/.local/bin:\$PATH" >> ~/.profile
    source ~/.profile
    ```

Now you are ready to create media files for the the HIG!

1.  Change to a directory containing qml source files. E.g.
    `cd HIG/source/qml/components/actionbutton`
2.  Run `makemedia.php Actionbutton1.qml` or `makemedia.php .` to create
    media files.
