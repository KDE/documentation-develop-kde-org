---
title: "Appium automation testing"
description: Learn how to run Appium tests for applications on Linux
weight: 3
authors:
  - SPDX-FileCopyrightText: 2023 Nitin Tejuja <nitin.tejuja12@gmail.com>
  - SPDX-FileCopyrightText: 2023 Fushan Wen <qydwhotmail@gmail.com>
  - SPDX-FileCopyrightText: 2024 Thiago Masato Costa Sueto <thiago.sueto@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

## Introduction

KDE uses manually triggered unit tests as well as autotests to prevent code changes to our applications from introducing usability issues. Oftentimes, this is not enough for graphical applications, so testing the user interface directly is required. To automate this, KDE uses Appium tests.

[Appium](https://appium.io/) is an open source tool based on [Selenium](https://www.selenium.dev/) for automating applications on various mobile and desktop platforms.

Selenium itself is used to automate testing web applications. Appium derives from it to allow for application testing in multiple platforms and in multiple languages.

Appium does this leverage of multiple platforms and languages by using a *driver*. A driver is a component or interface that acts as a bridge between your test scripts and the application you want to automate. With it, developers can write Selenium-style user interface tests for manipulating the user interface, test accessibility, and measure power consumption.

## The Linux Driver: Selenium AT-SPI {#atspi}

Appium has the ability to automate Linux apps by using the Linux accessibility API [AT-SPI2](https://www.freedesktop.org/wiki/Accessibility/AT-SPI2/). KDE has a driver for this called [Selenium AT-SPI](https://invent.kde.org/sdk/selenium-webdriver-at-spi), a [WebDriver](https://www.w3.org/TR/webdriver/) server for Linux apps that runs the application in a localhost webserver so it can work in non-GUI environments (such as CI jobs), while also being able to run locally in a Wayland compositor (KWin) so the tester can run the tests manually and see the results.

The Linux Driver supports testing applications that implement the AT-SPI2 interface. Applications written in [Qt5/Qt6](https://invent.kde.org/qt/qt/qtbase/-/commit/8e1ff45e74f529c7f49688242ea0fd25ce2913f3) or [GTK3/GTK4](https://gitlab.gnome.org/GNOME/gtk/-/commit/773df067e8bb6f1932f6b3ad4e9c91d52187ccd6) have good support for the AT-SPI2 interface.

In Qt's case, all you need to do is to follow standard [Qt Accessibility](https://doc.qt.io/qt-6/accessible.html) practices.

This tutorial will provide a step-by-step guide to use Selenium AT-SPI to automate system testing of QtQuick applications using Python scripts.

## Installation

This tutorial requires Python 3.8+ which is included by default in most distributions.

Installation of [Accerciser](https://help.gnome.org/users/accerciser/stable/introduction.html.en) (an interactive accessibility explorer) and [Orca](https://help.gnome.org/users/orca/stable/introduction.html.en) (screen reader) are recommended if you want to test accessibility with Appium tests.

{{< installpackage
    ubuntu="accerciser orca"
    opensuse="accerciser orca"
    fedora="accerciser orca"
    arch="accerciser orca"
>}}

### Building from source

[kdesrc-build](https://invent.kde.org/sdk/kdesrc-build) is the recommended tool to build selenium-webdriver-at-spi from source. Learn [how to set up a KDE development environment using kdesrc-build]({{< ref "kdesrc-build-setup" >}}).

After the development environment is set up, run the command below to build both selenium-webdriver-at-spi and kcalc from source. The command will automatically install all the required dependencies:

```shell
kdesrc-build kcalc selenium-webdriver-at-spi
```

Run the example test script to check that your installation is working.

With kdesrc-build:

```shell
kdesrc-build --run --exec selenium-webdriver-at-spi-run selenium-webdriver-at-spi ~/kde/src/selenium-webdriver-at-spi/examples/calculatortest.py
```

With kde-builder:

```shell
kde-builder --run selenium-webdriver-at-spi-run ~/kde/src/selenium-webdriver-at-spi/examples/calculatortest.py
```

You will see a black window titled "KDE Wayland Compositor" running a KCalc window and having a few buttons getting highlighted (very fast!) as they're activated.

{{< figure class="text-center" caption="KCalc running in nested KWin" src="kcalc.avif" >}}

After the test is complete, the window will close itself automatically, and you can see the test result in the console output.

```shell
----------------------------------------------------------------------
Ran 6 tests in 38.326s

OK
I, [2023-10-17T20:37:55.194322 #32112]  INFO -- : tests done
I, [2023-10-17T20:37:55.217687 #32112]  INFO -- : run.rb exiting true
```

### Building manually

To build Selenium manually, you will need to install its dependencies first:

{{< installpackage
    ubuntu="extra-cmake-modules libkf5windowsystem-dev libkf5wayland-dev libkpipewire-dev kwin-dev libwayland-dev"
    opensuse="extra-cmake-modules kwindowsystem-devel kwayland-devel kpipewire-devel kwin5-devel wayland-devel"
    fedora="extra-cmake-modules kf5-kwindowsystem-devel kf5-kwayland-devel kpipewire-devel kwin-devel wayland-devel"
    arch="extra-cmake-modules kwindowsystem5 kwayland5 kpipewire kwin wayland"
>}}

Then clone the repository and build it:

```bash
git clone https://invent.kde.org/sdk/selenium-webdriver-at-spi.git
cd selenium-webdriver-at-spi
cmake -B build/
cmake --build build/
sudo cmake --install build/
```

This will install it in your host root.

## Running Tests

Since this tutorial will focus on test scripts, at first we will be using QML
code snippets instead of a full project to exemplify their use. First,
we should see how an Appium test looks like.

### Anatomy of an Appium test

Writing an Appium test consists of three things:

* a class that is initialized with Appium options
* class members that start with the name "test_"
* an entrypoint

At minimum, an Appium test should contain the following:

```python
import unittest
from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy
from appium.options.common.base import AppiumOptions
from selenium.webdriver.support.ui import WebDriverWait

class YourTestClass(unittest.TestCase):
    @classmethod
    def setUpClass(self) -> None:
        options = AppiumOptions()
        options.set_capability("app", "/path/to/program")
        self.driver = webdriver.Remote(command_executor='http://127.0.0.1:4723', options=options)
        self.driver.implicitly_wait = 10

    @classmethod
    def tearDownClass(self) -> None:
        self.driver.quit()

    @classmethod
    def test_something(self) -> None:
        # Do something here

if __name__ == '__main__':
    unittest.main()
```

The class can have any name you'd like, conventionally using uppercase, and
it must derive from
[Python's standard unittest library](https://docs.python.org/3/library/unittest.html).

The first class method is like a constructor where we perform some setup and can
have any name, but it is conventionally called "setUpClass()". `AppiumOptions()`
provides the default settings for our tests. `set_capability()` takes a
[Python dictionary](https://docs.python.org/3/tutorial/datastructures.html#dictionaries),
analogous to [C++ std::map](https://en.cppreference.com/w/cpp/container/map)
or [Qt's QMap](https://doc.qt.io/qt-6/qmap.html).

In this case, the first string is the key, the second string is the value.
The list of keys and values available can be seen in the
[Appium Documentation for Capabilities](https://appium.io/docs/en/2.0/guides/caps/).
As can be seen in the documentation, the string "app" used above corresponds
to the capability "appium:app".

The "app" capability points to the application that will be tested, and it can be:

* The absolute path to an executable and optionally its command line parameters.
* The relative path to an executable and optionally its command line parameters (used for autotests when the application is being built).
* The desktop file that runs the application, without the file path and including the `.desktop` extension.

The second class method functions like a destructor that makes sure the driver
will quit once the tests are done. It also lets you terminate any other
external processes you might have started for your tests, like a small
web server.

Next we use some boilerplate code that allows Appium to run at a localhost web
server at a certain port, passing the options and capabilities we have defined.
Then, we set a timeout of 10 seconds to allow the test to prepare and run
the application when it is executed.

As mentioned before, we need a class method that starts with the name "test_"
and that will perform the actual test.

Lastly we create the main entrypoint for our test.

### GUI interaction via Appium tests

For QML applications, interaction with Appium tests is simple and consists
of two steps:

1. Defining a property to a QML element that makes it locatable.
2. Using a Selenium Locator to find that QML element.

The Qt API that is required to make a QML element locatable is
[Accessible](https://doc.qt.io/qt-6/qml-qtquick-accessible.html). Typically
what is used is
[Accessible.name](https://doc.qt.io/qt-6/qml-qtquick-accessible.html#name-prop)
or [Accessible.description](https://doc.qt.io/qt-6/qml-qtquick-accessible.html#description-prop).

To find that QML element, we'd use the aptly named Appium function
[find_element()](https://www.selenium.dev/selenium/docs/api/py/webdriver_remote/selenium.webdriver.remote.webelement.html#selenium.webdriver.remote.webelement.WebElement.find_element),
to which we pass a
[Selenium Locator](https://www.selenium.dev/documentation/webdriver/elements/locators/).

#### Essential Locators

The locator that is most commonly used for tests in KDE software is
[NAME](https://www.selenium.dev/documentation/webdriver/elements/locators/#name).
It matches the `Accessible.name` set in the QML code.

For example, if we have a QtQuick.Controls.Button:

```qml
Controls.Button {
    text: "Hello World!"
    Accessible.name: "Button"
}
```

A test that clicks said button can be defined like the following:

```python
def test_click_button(self) -> None:
    self.driver.find_element(by=AppiumBy.NAME, value="Button").click()
    # Or the less direct but more legible:
    # button = self.driver.find_element(by=AppiumBy.NAME, value="Button")
    # button.click()
```

A string can be directly passed to `find_element()` as well.
This is useful to access the `Accessible.description` of an element:

```qml
Controls.Button {
    text: "Hello World!"
    Accessible.description: "A clickable button"
}
```

In a test, we'd use:

```python
def test_click_button(self) -> None:
    self.driver.find_element(by="description", value="A clickable button").click()
```

Another particularly useful Appium function we can use is [send_keys()](https://appium.github.io/python-client-sphinx/webdriver.html#webdriver.webelement.WebElement.send_keys), which allows to send keyboard input to the application. With a simple QtQuick.Controls.TextField for example:

```qml
Controls.TextField {
    placeholderText: "Hello World!"
    Accessible.name: "Text field"
}
```

You would simply do:

```python
def test_input(self) -> None:
    text_input = self.driver.find_element(by=AppiumBy.NAME, value="Text field")
    text_input.send_keys("Hello Appium")
```

If you need to enter certain non-typable keys, such as Enter/Return, you can
use [Selenium Keys](https://www.selenium.dev/selenium/docs/api/py/webdriver/selenium.webdriver.common.keys.html) for that:

```python
from selenium.webdriver.common.keys import Keys

# ...

def test_dialog_confirm(self) -> None:
    edit_field = self.driver.find_element(by=AppiumBy.NAME, value="Text field")
    edit_field.send_keys("myquery")
    edit_field.send_keys(Keys.ENTER)
```

Another commonly used function is
[get_attribute()](https://www.selenium.dev/selenium/docs/api/py/webdriver_remote/selenium.webdriver.remote.webelement.html#selenium.webdriver.remote.webelement.WebElement.get_attribute).
It can be used to determine whether an element currently has an `Accessible`
attribute such as
[focused](https://doc.qt.io/qt-6/qml-qtquick-accessible.html#focused-prop) or
[selected](https://doc.qt.io/qt-6/qml-qtquick-accessible.html#selected-prop)
enabled.

```python
searchFocused = searchField.get_attribute('focused')
```

There are many other convenience functions:

* [get_clipboard_text()](https://appium.readthedocs.io/en/latest/en/commands/device/clipboard/get-clipboard/)
* [double_click()](https://appium.readthedocs.io/en/latest/en/commands/interactions/mouse/doubleclick/)
* touchscreen [tap()](https://appium.readthedocs.io/en/latest/en/commands/interactions/touch/tap/)
* mouse [move_to()](https://appium.readthedocs.io/en/latest/en/commands/interactions/mouse/moveto/)
* [get_screenshot_as_file()](https://selenium-python.readthedocs.io/api.html#selenium.webdriver.remote.webdriver.WebDriver.get_screenshot_as_file)

These can be seen at the
[Appium Commands documentation](https://appium.readthedocs.io/en/latest/en/commands/README/).

Additional commands specific to using Python scripts can be seen at the
[Selenium Python documentation](https://selenium-python.readthedocs.io/api.html).

#### Other ways to use locators

In the introductory section [The Linux Driver: Selenium AT-SPI](#atspi), you became aware that Linux has a standard driver for handling accessibility. This driver is used, for example, in the Qt and GTK toolkits, and it specifies things such as accessibility IDs or Roles.

For the accessibility ID, which serves as a unique identifier for a user
interface element, we can use the Appium-provided locator
[ACCESSIBILITY_ID](https://appium.github.io/python-client-sphinx/webdriver.common.html#webdriver.common.appiumby.AppiumBy.ACCESSIBILITY_ID),
which should match the QML
[objectName](https://doc.qt.io/qt-6/qml-qtqml-qtobject.html#objectName-prop).

```qml
Item {
    objectName: "Button"
}
```

The locator would be used like so:

```python
def test_click_button(self) -> None:
    self.driver.find_element(by=AppiumBy.ACCESSIBILITY_ID, value="Button").click()
```

The accessibility ID can be used in a generic manner like NAME or "description"
as shown above, but its primary use is with QtWidgets applications. You can see
a live example of this in
[KDebugSettings](https://invent.kde.org/utilities/kdebugsettings/-/blob/master/src/seleniumtests/kdebugsettings.py).

While the accessibility ID is a unique identifier, the Role on the other hand
is a generic identifier for an element *type*, especially used for keyboard
navigation. It is used to determine how to traverse focus, for example,
in a menu bar, a tool bar, a check box, and other elements. In code terms,
this means a QtQuick.Controls.Button and a Kirigami.Action attached to a button
would share the same role of "push button", as they are both functionally
buttons.

You can view the available roles in an application by using
[Accerciser](https://help.gnome.org/users/accerciser/stable/introduction.html.en),
an application that allows you to explore accessibility properties in other
programs. KDE also has its own accessibility explorer,
[Accessibility Inspector](https://apps.kde.org/accessibilityinspector/),
which has not yet been packaged by distros.

To inspect roles in KDE applications, you first need to open Accerciser, and
then run the desired KDE application by passing the environment variable
`QT_LINUX_ACCESSIBILITY_ALWAYS_ON`, like so:

```bash
QT_LINUX_ACCESSIBILITY_ALWAYS_ON=1 plasma-discover
```

Discover for example has a test that first waits for the loading screen to
vanish before searching for certain user interface elements. To do so, it first
searches for the "Loading..." label's Role:

```qml
Kirigami.Action {
    text: {
        if (!root.isStateAvailable) {
            return i18nc("State being fetched", "Loading…")
        }
        // Rest of code here
    }
}
```

Then it uses the Selenium function
[invisibility_of_element_located()](https://www.selenium.dev/selenium/docs/api/py/webdriver_support/selenium.webdriver.support.expected_conditions.html#selenium.webdriver.support.expected_conditions.invisibility_of_element_located)
together with the Selenium locator
[CLASS_NAME](https://www.selenium.dev/documentation/webdriver/elements/locators/#class-name)
to be sure the "Loading..." element is no longer there.

```python
def test_search_install_uninstall(self):
    WebDriverWait(self.driver, 30).until(
        EC.invisibility_of_element_located((AppiumBy.CLASS_NAME, "[label | Loading…]"))
    )
    # Rest of code
```

### Testing and asserting

So far, we have seen how to interact with GUI elements, but we haven't tested
anything yet.

Generally, tests *assert* whether the performed action was successful
or not. This is done by using the
[Python unittest module's assert methods](https://docs.python.org/3/library/unittest.html#assert-methods).
The most common methods are:

```python
# a == b
assertEqual(a, b)
# a != b
assertNotEqual(a, b)
# bool(x) is True
assertTrue(x)
# bool(x) is False
assertFalse(x)
# member is in container
assertIn(member,container)
# member is not in container
assertNotIn(member, container)
```

A common pattern used in KDE software is to write a `getresults()` function
that retrieves a property from a certain element. This is useful for when
multiple UI elements are handled and the result culminates into a single
element. The standard `calculatortest.py` provided with Selenium AT-SPI
is an example of this, with the input of multiple calculator keys being probed
before checking the result in the text field:

```python
def getresults(self):
    displaytext = self.driver.find_element(by='description', value='Result Display').text
    return displaytext
```

Another assert pattern is used to test whether the values you get from
interacting with the application's UI matches an expected result. This can be
done with an `assertResult(self, actual, expected)` method. Generally you want
for the driver to have finished loading and having run the `getresults()` method,
so a timeout is needed.

```python
def assertResult(self, actual, expected):
    wait = WebDriverWait(self.driver, 20)
    wait.until(lambda x: self.getresults() == expected)
    self.assertEqual(self.getresults(), expected)

def test_addition(self):
    self.driver.find_element(by=AppiumBy.NAME, value="1").click()
    self.driver.find_element(by=AppiumBy.NAME, value="+").click()
    self.driver.find_element(by=AppiumBy.NAME, value="7").click()
    self.driver.find_element(by=AppiumBy.NAME, value="=").click()
    self.assertResult(self.getresults(), "8")
```

Whenever a test fails, it is customary to take a screenshot of the result so
that even tests done in the
[KDE CI](https://community.kde.org/Infrastructure/Continuous_Integration_System)
can be viewed by developers as downloadable artifacts. This can be achieved with
[get_screenshot_as_file(filename)](https://selenium-python.readthedocs.io/api.html#selenium.webdriver.remote.webdriver.WebDriver.get_screenshot_as_file)
in the `tearDownClass()` destructor:

```python
def tearDownClass(self) -> None:
    if not self._outcome.result.wasSuccessful():
        self.driver.get_screenshot_as_file("failed_test_shot_{}.png".format(self.id()))
```

Now you should know everything you need to write your own Appium tests! 🎉
