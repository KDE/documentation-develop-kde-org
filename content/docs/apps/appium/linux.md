---
title: "Run tests on Linux"
description: Learn how to run Appium tests for applications on Linux
weight: 1
authors:
  - SPDX-FileCopyrightText: 2023 Nitin Tejuja <nitin.tejuja12@gmail.com>
  - SPDX-FileCopyrightText: 2023 Fushan Wen <qydwhotmail@gmail.com>
SPDX-License-Identifier: CC-BY-SA-4.0
---

## Introduction

[Appium](https://appium.io/) (based on [Selenium](https://www.selenium.dev/)) is an open-source tool for automating applications on various mobile and desktop platforms.

Appium automates applications using a *driver*. A driver refers to a component or interface that acts as a bridge between your test scripts and the application you want to automate. It enables developers to write Selenium-style user interface tests for manipulating the user interface. It can also be used to test accessibility and measure power consumption.

### The Linux Driver: Selenium AT-SPI

Appium has the ability to automate Linux apps. This driver relies on a project from KDE called [Selenium AT-SPI](https://invent.kde.org/sdk/selenium-webdriver-at-spi), which provides an Appium-compatible [WebDriver](https://www.w3.org/TR/webdriver/) server for Linux apps using the Linux accessibility API [AT-SPI2](https://www.freedesktop.org/wiki/Accessibility/AT-SPI2/). The driver is not bundled with Appium, so it needs to be installed separately.

The Linux Driver supports testing applications that implement the AT-SPI2 interface. Applications written in [Qt5+](https://invent.kde.org/qt/qt/qtbase/-/commit/8e1ff45e74f529c7f49688242ea0fd25ce2913f3) or [GTK3+](https://gitlab.gnome.org/GNOME/gtk/-/commit/773df067e8bb6f1932f6b3ad4e9c91d52187ccd6) have good support for the AT-SPI2 interface.

This tutorial will provide a step-by-step guide to use Selenium AT-SPI to automate system testing of Qt applications.

## Installation

Selenium Webdriver AT-SPI requires Python 3.8+ which is included by default in most distributions.

### Building from source

[kdesrc-build](https://community.kde.org/Get_Involved/development/Build_software_with_kdesrc-build) is the recommend tool to build selenium-webdriver-at-spi from source. Learn [how to set up a development environment](https://community.kde.org/Get_Involved/development/Set_up_a_development_environment).

After the development environment is set up, run the command below to build selenium-webdriver-at-spi from source. The command will automatically install all the required dependencies for selenium-webdriver-at-spi.

```shell
kdesrc-build selenium-webdriver-at-spi
```

Installation of [Accerciser](https://help.gnome.org/users/accerciser/stable/introduction.html.en) (an interactive accessibility explorer) and [Orca](https://help.gnome.org/users/orca/stable/introduction.html.en) (screen reader) are recommended if you want to test accessibility.

```shell
sudo apt install accerciser orca
```

Install KCalc if it is not already present on your computer.

```sudo apt install accerciser orca
sudo apt install kcalc
```

Run the example test script to check that your installation is working.

```shell
selenium-webdriver-at-spi-run ${PATH_TO_SELENIUM_WEBDRIVER_AT_SPI_SOURCE}/examples/calculatortest.py
```

You will see a black window titled "KDE Wayland Compositor" running a KCalc window and having a few buttons getting highlighted (very fast!) as they're activated.

{{< figure class="text-center" caption="KCalc running in nested KWin" src="screenshots/kcalc.avif" >}}

After the test is complete, the window will close itself automatically, and you can see the test result in the console output.

```shell
----------------------------------------------------------------------
Ran 6 tests in 38.326s

OK
I, [2023-10-17T20:37:55.194322 #32112]  INFO -- : tests done
I, [2023-10-17T20:37:55.217687 #32112]  INFO -- : run.rb exiting true
```

## Running Tests

### Modifying and Compiling Your Application

This guide is based around the automation tests in [GCompris](https://gcompris.net/) which aim to test usage over a full day to measure its power consumption. GCompris is a KDE education application running on Linux, Windows, Android with more than 180 activities for children. You can also choose your own application to run tests.

During the power consumption test we use Selenium to access and play several of its activities: a word processor for children, the GCompris configuration screen, a chess activity and a world music presentation activity.

In order to access UI elements of these activities, we need to change their code by adding some accessible properties, and then recompile GCompris.

### Compiling GCompris

To compile GCompris, you can follow [this guide](https://gcompris.net/wiki/Qt_Quick_development_process).

### Modifying the Source Code

To explain how to add accessibility to the source code, the tutorial will take the "Baby Keyboard" example that sends some keys to a text field.

The Baby Keyboard activity is very simple: when the user presses a letter key, its corresponding letter is shown on the screen and GCompris pronounces the name of the letter. It can be found under [`src/activities/baby_keyboard/Baby_keyboard.qml`](https://invent.kde.org/education/gcompris/-/blob/master/src/activities/baby_keyboard/Baby_keyboard.qml) in the GCompris source code.

The activity contains three QML elements:

- `TextEdit` (to ask for user input),
- `GCText` (contains the user-typed text),
- `Rectangle` (displays the user-typed text in a rectangle shape)

Below Is the code for the `TextEdit` element which handles the key input from the user.

```qml
TextEdit {
    id: textinput
    focus: true
    visible: false
    inputMethodHints: Qt.ImhNoPredictiveText
    onTextChanged: {
        if (text != "") {
            Activity.Process KeyPress (text).
            text = "";
        }
    }
}
```

Since we need to send the letters to the above element using our Selenium script, we need to assign an `Accessible.name` to this element, so the driver can locate the `TextEdit` element using its name as a condition in the test script.

Here is the same code with added Accessible code for the `TextEdit` element:

```qml
TextEdit {
    id: textinput
    Accessible.name: "Text Input"
    focus: true
    visible: false
    inputMethodHints: Qt.ImhNoPredictiveText
    onTextChanged: {
        if (text != "") {
            Activity.processKeyPress(text);
            text = "";
        }
    }
}
```

Below is the code for the Rectangle element that displays the user-typed text (`GCText` element) in a rectangle shape.

```qml
GCText {
    id: typedText
    anchors.centerIn: textBG
    text: ""
    fontSize: 54
    font.bold: true
    color: "#d2611d"
    style: Text.Outline
    styleColor: "white"
}

Rectangle {
    id: textBG
    visible: typedText.text != ""
    color: "#80ffffff"
    width: typedText.contentWidth * 2
    height: typedText.contentHeight
    radius: 16
}
```

To read the text displayed in the rectangle, we need to first find the rectangle element using the name locator. We set the accessible name as "Text results" and the description as the text value entered by user. In the Selenium script, we find an element using the description locator and query its name to obtain user input text.

```qml
Rectangle {
    id: textBG
    Accessible.name: typedText.text
    Accessible.description: "Text results"
    visible: typedText.text != ""
    color: "#80ffffff"
    width: typedText.contentWidth * 2
    height: typedText.contentHeight
    radius: 16
}
```

You can learn more about how Qt handles accessibility in QML in the [documentation for QML Accessible properties](https://doc.qt.io/qt-6/qml-qtquick-accessible.html).

### Selenium Script

Below is the Python Selenium script used to test the `baby_keyboard` activity.

{{< readfile file="/content/docs/apps/appium/BabyKeyboardActivityTestCase.py" highlight="python" >}}

The syntax is very similar to that in Selenium scripts for web browsers, and the main difference is the driver does not automate a web page but an application. Those comments can also help you understand the script in detail.

Now run the test script file using the command below, assuming you saved the test script as `baby_keyboard.py` in the current directory.

```shell
selenium-webdriver-at-spi-run ./baby_keyboard.py
```

