---
title: Develop
subtitle: Develop featurful applications with KDE and Qt technologies
layout: area
linkTitle: Develop
weight: 20
---

<section class="container">
  <div class="mx-auto">
    <p>
      Focused on speed and multiplatform technologies, Qt and KDE technologies is
      the fastest and smartest way to produce industry-leading software that users
      love.
    </p>
    <p>
      Use KDE Frameworks to solve common problems. Write your applications inside
      KDevelop, the powerful KDE IDE. Improve the performace of your apps using 
      KDE profilers and analyse your application for common problems with the
      Clazy static code analyser.
    </p>
  </div>
</section>

<section>
  <div class="container">
    <h2 class="text-center">KDE Frameworks</h2>
    <p>
      The KDE Frameworks build on the Qt framework, providing everything from
      simple utility classes (such as those in KCoreAddons) to integrated
      solutions for common requirements of desktop applications (such as
      KNewStuff, for fetching downloadable add-on content in an application,
      or the powerful KIO multi-protocol file access framework).
    <p>
    <p>
      The KDE Frameworks can be used in CMake-based and QMake-based projects,
      and most of them are portable to at least Windows, Mac and Linux. The
      documentation of each framework has code snippets that show how to
      include the framework in a QMake or CMake project.
    </p>
    <p>
      The frameworks are divided into four tiers, based on the kind of
      dependencies that they have. For instance, Tier 1 frameworks depend
      on Qt and possibly some third-party libraries, but not on other
      frameworks. This makes them easy to integrate into existing
      applications.
    </p>
    <div class="d-flex justify-content-center">
      <a href="/product/framework" class="button learn-more ml-2 mr-2">Learn More</a>
      <a href="https://api.kde.org/frameworks/" class="ml-2 mr-2 button learn-more">Documentation</a>
    </div>
  </div>
</section>

<section id="kirigami">
  <div class="text-center pl-5 pr-5 img-fluid container">
    <h2>Develop Convergent Apps with Kirigami</h2>
    <p class="mb-5">Kirigami is a new, convergent, responsive, elegant, and open cross-platform toolkit using QML.</p>
    <div class="laptop-with-overlay text-center position-relative">
      <img class="laptop img-fluid mb-3" src="https://kde.org/content/plasma-desktop/laptop.png" alt="">
      <div class="laptop-overlay">
        <img class="img-fluid mb-3" src="/develop/kirigami_code_view.png" alt="Kirigami application with source code" />
      </div>
    </div>
    <a class="learn-more" href="https://kde.org/products/kirigami/">Learn more</a>
  </div>
</section>

<section>
  <div class="container text-center">
    <h2>Tools</h2> 
    <p>KDE develops a variety of tools to help you develop the best applications you possibly can.</p>
    <div class="tools">
      <a class="tool" href="https://kdevelop.org">
        <div>
          <h3>KDevelop</h3>
          <p>KDE's full-fledged development environment</p>
        </div>
        <div>
          <img class="img-fluid" src="https://kde.org/applications/icons/org.kde.kdevelop.svg">
        </div>
      </a>
      <a class="tool" href="https://kate-editor.org">
        <div>
          <h3>Kate</h3>
          <p>KDE's lightweight but feature-rich text editor</p>
        </div>
        <div>
          <img class="img-fluid" src="https://kde.org/applications/icons/org.kde.kate.svg">
        </div>
      </a>
    </div>
    <div class="tool flex-column  mt-5">
      <h3>And a lot more tools</h3>
      <div class="more-apps">
        <a href="https://umbrello.kde.org">
          <img src="https://kde.org/applications/icons/org.kde.umbrello.svg" />
          Umbrello
        </a>
        <a href="https://kde.org/applications/development/org.kde.clazy">
          <img src="https://kde.org/applications/icons/org.kde.clazy.svg" />
          Clazy
        </a>
        <a href="https://kde.org/applications/development/org.kde.kcachegrind">
          <img src="https://kde.org/applications/icons/org.kde.kcachegrind.svg" />
          KCacheGrind
        </a>
        <a href="https://kde.org/applications/development/org.kde.heaptrack">
          <img src="https://kde.org/applications/icons/org.kde.heaptrack.svg" />
          Heaptrack
        </a>
        <a href="https://kde.org/applications/development/org.kde.massif-visualizer">
          <img src="https://kde.org/applications/icons/org.kde.massif-visualizer.svg" />
          Massif-Visualizer
        </a>
      </div>
      <a href="/applications/development" class="learn-more mt-3">See All Tools</a>
    </div>
  </div>
</section>

<section>
  <div class="container">
    <h2 style="margin-bottom: -20px;">Resources</h2>
    <div class="row bottomAlignRow" style="border-bottom: solid 1px #EEE; padding-bottom: 20px;">
      <div class="col-sm">
        <h3>Getting Started tutorial</h3>
        <p>
          Learn how to develop a KDE application. From a simple dialog to a full featured application
          integrated with Plasma and with translations.
        </p>
        <a href="/docs/" class="learn-more button">View documentation</a>
      </div>
      <div class="col-sm">
        <h3>Kirigami Documentation</h3>
        <p>
          Want to create a convergent application for mobile and desktop? Learn how to do it here
        </p>
        <a href="/kirigami" class="learn-more button">View Documentation</a>
      </div>
      <div class="col-sm">
        <h3>API Documentation</h3>
        <p>
          Api Documentation for each class and component in KDE Frameworks.
        </p>
        <a href="https://api.kde.org" class="learn-more button">View API</a>
      </div>
    </div>
  </div>
</section>
