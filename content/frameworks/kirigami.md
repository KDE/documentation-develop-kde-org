---
layout: single
scss: "scss/kirigami.scss"
layout: framework
title: Kirigami UI Framework
---

<div class="container-fluid">
<section class="kirigami-header">
  <img src="./kirigami-horizontal.svg" class="img-fluid" alt="Kirigami UI Framework logo">
  <h2>Build beautiful apps that run on computers, phones, TVs and everything in between.</h2>
</section>
</div>

<div>
  <div class="container text-center block-navs">
    <a href="/docs/getting-started/kirigami/" target="_blank" class="block-nav">
      <i class="icon icon_document-share"></i>
      <h2>Learn</h2>
      <p>Learn how to build beautiful apps with Kirigami</p>
    </a>
    <a href="https://hig.kde.org/" target="_blank" class="block-nav">
      <i class="icon icon_draw-watercolor"></i>
      <h2>HIG</h2>
      <p>Discover the design principles that power Kirigami apps</p>
    </a>
    <a href="https://api.kde.org/kirigami-index.html" class="block-nav">
      <i class="icon icon_anchor"></i>
      <h2>API Reference</h2>
      <p>Find out what Kirigami can bring to your apps</p>
    </a>
  </div>
</div>

<div class="container-fluid app-grid pt-5">
  <img src="kirigami-app-grid.svg" class="w-100" alt="Grid of application using Kirigami" />
</div>

<section class="container my-5">
  <div class="row">
    <div class="col-12 col-lg-6">
      <h2 class="h1">Convergent and everywhere</h2>
      <p>The line between desktop and mobile is blurring. Users expect the same quality
      experience on every device, and applications using Kirigami adapt brilliantly to
      mobile, desktop, TVs, household appliances, and everything in between.</p>
      <div class="d-flex flex-column mt-4 gap-3">
        <div class="position-relative ps-5">
          <dt class="d-inline font-semibold text-gray-900">
            <img src="android.svg" alt="" width="40" height="40" class="position-absolute top-0 start-0">
            Android ready.
          </dt>
          <!-- space -->
          <dd class="d-inline">Yes, Kirigami officially supports Android! KDE provides multiple applications on <a href="https://community.kde.org/Android/FDroid">F-Droid</a> and the <a href="https://play.google.com/store/apps/dev?id=4758894585905287660">Play Store</a>. See our <a href="/docs/packaging/android/">documentation</a> for more information.</dd>
        </div>
        <div class="position-relative ps-5">
          <dt class="d-inline font-semibold text-gray-900">
            <img src="plasma-mobile-logo.svg" alt="" width="40" height="40" class="position-absolute top-0 start-0">
            Perfect for Plasma Mobile.
          </dt>
          <!-- space -->
          <dd class="d-inline">Kirigami is the preferred framework for your Plasma Mobile application. You can find a list of many existing Kirigami applications for Plasma Mobile on the <a href="https://plasma-mobile.org/#applications">Plasma Mobile website</a></dd>
        </div>
        <div class="position-relative ps-5">
          <dt class="d-inline font-semibold text-gray-900">
            <img src="kde-cpu.svg" alt="" width="40" height="40" class="position-absolute top-0 start-0">
            And everything else.
          </dt>
          <!-- space -->
          <dd class="d-inline">Besides providing high level components, to make it easier to support multiple form factors, Kirigami also provides a wide variety of low level components that can be used in your embedded Linux QML app. For example, check out the high performance <a href="https://api.kde.org/qml-org-kde-kirigami-primitives-shadowedrectangle.html">ShadowedRectangle</a> and an <a href="/docs/getting-started/kirigami/style-colors/">extensible theming API</a>.</dd>
        </div>
      </div>
    </div>
    <div class="col-12 col-lg-6 align-self-center">
      <img src="tokodon-desktop.png" class="img-fluid kirigami-devices" alt="the app Tokodon works correctly both on a Linux desktop computer and on a phone running KDE Plasma Mobile">
    </div>
  </div>
</section>

{{< sections class="container" >}}

{{< section-left class="align-self-center" >}}
```qml
import org.kde.kirigami

Kirigami.ScrollablePage {
    actions: Kirigami.Action {
       icon.name: 'document-info'
       text: "Information"
    }

    ListView {
        id: dragonList

        delegate: DragonItemDelegate {}
        model: DragonListModel {}

        Kirigami.PlaceholderMessage {
            visible: dragonList.count === 0
            text: 'No dragon in the list :('
        }
    }
}
```
{{< /section-left >}}

{{< section-right  class="align-self-center" >}}
<h2 class="h1">Declarative UI, Any Language</h2>

Built on QML, a powerful declarative language, Kirigami makes UI development faster, clearer, and more expressive. Letting you describe what your interface should look like, not how to render it. This results in cleaner code, rapid prototyping, and highly maintainable applications.

Kirigami integrates effortlessly with **C++**, **Rust**, and **Python**, giving developers the freedom to use the language they love while benefiting from KDE’s robust ecosystem and proven cross-platform technologies.

<a href="/docs/getting-started/kirigami/" class="learn-more">Get Started!</a>
{{< /section-right >}}

{{< /sections >}}

<section class="container">
  <div class="row">
    <div class="col-12 col-lg-6  align-self-center">
      <h2 class="h1">Open and trusted</h2>
      <p>Kirigami is developed by the KDE community. We have been around since 1997, and we develop high quality open source software used by millions of people worldwide. Kirigami is released under <a href="https://invent.kde.org/frameworks/kirigami/-/tree/master/LICENSES/LGPL-2.0-or-later.txt">LGPL-2.0-or-later</a>, and, as such, can be used in your open source or commercial project.</p>
      <p>Kirigami is one of the 80 <a href="/products/frameworks">KDE Frameworks</a> produced by KDE, part of a collection of high quality add-on libraries for Qt apps with long ABI and API stability guarantees. And, in case you need support, there is a <a href="https://ev.kde.org/consultants/">network of trusted consultants</a> available to assist you with your project.</p>
    </div>
    <div class="col-12 col-lg-6 align-self-center">
      <img src="https://origin.cdn.kde.org/screenshots/neochat/application.png" class="img-fluid kirigami-devices" alt="screenshot of the app NeoChat">
    </div>
  </div>
</section>
