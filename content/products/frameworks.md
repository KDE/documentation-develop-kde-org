---
title: KDE Frameworks
subtitle: The KDE Frameworks are a set of 83 add-on libraries for programming with Qt.
description: The KDE Frameworks are a set of 83 add-on libraries for programming with Qt.
layout: products
logo: /img/kde-logo-white-blue-rounded-source.svg
scss: "scss/framework.scss"
---

<article class="section-links container">
  <h2 class="h1">Get Started</h2>
  <div class="row">
    <div class="p-3 col-12 col-md-6">
      <a href="https://api-staging.kde.org/index.html" class="shadow p-3 h-100">
        <h2>Developer Documentation</h2>
        <p>
          Code an application in C++ with Qt and QML.
        </p>
      </a>
    </div>
    <div class="p-3 col-12 col-md-6 h-100">
      <a class="shadow p-3" href="https://hig.kde.org/">
        <h2>Design Guidelines</h2>
        <p>
          Use our UI standards to their fullest for a flexible and consistent user experience if you are creating an app for the Linux desktop.
        </p>
      </a>
    </div>
  </div>
</article>

<article class="container">
  <div class="d-flex py-3 flex-lg-row flex-column">
    <div class="order-1">
      <h1>Features</h1>
      <p>
          The KDE Frameworks are <?php print $numberOfFrameworks ?> add-on libraries for coding applications with Qt.
      </p>
      <p>
          The individual Frameworks are well documented, tested and their API style will be familiar to Qt developers.
      </p>
      <p>
           Frameworks are developed under the proven KDE governance model with a predictable release schedule, a clear and vendor neutral contributor process, open governance and flexible LGPL or MIT licensing.
      </p>
      <p>
          The frameworks are cross-platform and function on Windows, Mac, Android and Linux.
      </p>
    </div>
    <div class="image align-self-center order-3 order-lg-0">
      <img src="platform-icons.png" style="margin: auto; max-width: 90%; height: auto;" alt="some operating systems supported by the KDE Frameworks"/>
    </div>
  </div>
</article>

<article class="section-blue">
  <div class="container py-3">
    <h2 class="h1">Organization</h2>
    <p>
      The Frameworks have a clear dependency structure, divided into Categories and Tiers. The Categories refer to runtime dependencies:
    </p>
    <p>
      <b>Functional</b> elements have no runtime dependencies.<br />
      <b>Integration</b> designates code that may require runtime dependencies for integration depending on what the OS or platform offers.<br />
      <b>Solutions</b> have mandatory runtime dependencies.
    </p>
    <p>
      The Tiers refer to compile-time dependencies on other Frameworks.
    </p>
    <p>
      <b>Tier 1</b> Frameworks have no dependencies within Frameworks and only need Qt and other relevant libraries.<br />
      <b>Tier 2</b> Frameworks can depend only on Tier 1.<br />
      <b>Tier 3</b> Frameworks can depend on other Tier 3 Frameworks as well as Tier 2 and Tier 1.
    </p>
  </div>
</article>

<article class="section-green">
  <div class="container py-3">
    <h2 class="h1 mb-5">Highlights:</h2>
    <div>
      <p>
        <b>KArchive</b> offers support for many popular compression codecs in a self-contained, featureful and easy-to-use file archiving and extracting library. Just feed it files; there's no need to reinvent an archiving function in your Qt-based application!
      </p>
      <p>
        <b>ThreadWeaver</b> offers a high-level API to manage threads using job- and queue-based interfaces. It allows easy scheduling of thread execution by specifying dependencies between the threads and executing them satisfying these dependencies, greatly simplifying the use of multiple threads.
      </p>
      <p>
        <b>Breeze Icons</b>. KDE Frameworks includes two icon themes for your applications.  Breeze icons is a modern, recognisable theme which fits in with all form factors.
      </p>
      <p>
        <b>KConfig</b> is a Framework to deal with storing and retrieving configuration settings. It features a group-oriented API. It works with INI files and XDG-compliant cascading directories. It generates code based on XML files.
      </p>
      <p>
        <b>KI18n</b> adds Gettext support to applications, making it easier to integrate the translation workflow of Qt applications in the general translation infrastructure of many projects.
      </p>
      <p>
        <a href="/frameworks/kirigami"><b>Kirigami</b></a> is a responsive UI framework for QML.
      </p>
    </div>
  </div>
</article>

<article class="container-fluid mx-auto" style="max-width: 1400px">
  <h2 class="h1 text-center">Examples</h2>
    <div class="row my-3">
        <div class="col-12 col-sm-4 align-self-center">
          <p>
            GammaRay is a cross platform (Linux, Windows, Mac) inspection tool for Qt apps from KDAB.  It uses <a href="https://api-staging.kde.org/ksyntaxhighlighting-index.html">KSyntaxHighlighting</a> to colour text it shows.
          </p>
        </div>
        <img class="img-fluid col-12 col-sm-8" src="gammaray.png" alt="screenshot of app GammaRay"/>
    </div>
    <div class="row my-3">
      <div class="col-12 col-sm-4 order-sm-1 align-self-center">
        <p>
          LXQt is a simple desktop environment for Linux.  It uses <a href="https://api-staging.kde.org/solid-index.html">Solid</a> for hardware integration, <a href="https://api-staging.kde.org/kwindowsystem-index.html">KWindowSystem</a> for window management and <a href="https://api-staging.kde.org/kidletime-index.html">KIdleTime</a> for power management.
        </p>
        <p>
          Good looks are added with <a href="https://invent.kde.org/frameworks/oxygen-icons">Oxygen Icons</a>, one of our icon theme frameworks.
        </p>
      </div>
      <img class="img-fluid col-12 col-sm-8 order-sm-0" src="lxqt.png" alt="screenshot of the desktop environment LXQt" />
    </div>
</article>
<article class="container-fluid">
  <h1>Get The Frameworks</h1>
  <div class="row">
    <div class="p-2 col-12 col-md-4">
      <div class="shadow p-3 h-100">
        <h2>Latest Version</h2>
        <p>
          Download the latest release
        </p>
        <a href="https://www.kde.org/announcements/" target="_blank">Release Announcements</a>
      </div>
    </div>
    <div class="p-2 col-12 col-md-4">
      <div class="shadow p-3 h-100">
        <h2>Build it Yourself</h2>
        <p>
            Our tool to compile KDE software
        </p>
        <a href="https://develop.kde.org/docs/getting-started/building/kde-builder-setup" target="_blank">kde-builder</a>
      </div>
    </div>
    <div class="p-2 col-12 col-md-4">
      <div class="shadow p-3 h-100">
        <h2>Linux Packages</h2>
        <p>
            Linux distros already package KDE Frameworks
        </p>
        <a href="https://community.kde.org/Get_KDE_Software_on_Your_Linux_Distro" target="_blank">Binary Packages</a>
      </div>
    </div>
    <div class="p-2 col-12 col-md-4">
      <div class="shadow p-3 h-100">
        <h2>Windows</h2>
        <p>
            Our Craft tool builds KDE software on Windows and other platforms
        </p>
        <a href="https://community.kde.org/Craft" target="_blank">Craft</a>
      </div>
    </div>
    <div class="p-2 col-12 col-md-4">
      <div class="shadow p-3 h-100">
        <h2>Android</h2>
        <p>
            Use KDE Frameworks on mobile
        </p>
        <a href="https://community.kde.org/Android" target="_blank">Android Tutorial</a>
      </div>
    </div>
  </div>
</article>

</main>
<?php
  require('../../aether/footer.php');
