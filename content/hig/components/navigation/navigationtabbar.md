---
title: Navigation Tab Bar
available: ['plasma', 'qwidgets']
group: navigation
weight: 6
---

Purpose
-------

The Navigation Tab Bar provides horizontal/lateral navigation for applications
with a small number of top-level pages.

![Navigation Tab Bar with 3 items and a toolbar above](/hig/Navigationtabbar1.png)

![Navigation Tab Bar with 5 items](/hig/Navigationtabbar2.png)

Guidelines
----------

### Is this the right control?

Use a Navigation Tab Bar in place of a Sidebar in an application with three to 
five top level pages that the user will frequently navigate between. A Sidebar 
is more appropriate for applications with many top-level pages.

Code
----

### Kirigami

{{< readfile file="/content/hig/examples/kirigami/ClockNavigationTabBar.qml" highlight="qml" >}}
 
