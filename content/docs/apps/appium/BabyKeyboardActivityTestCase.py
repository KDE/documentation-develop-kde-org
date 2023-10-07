#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2023 Nitin Tejuja <nitin.tejuja12@gmail.com>
# SPDX-FileCopyrightText: 2023 Fushan Wen <qydwhotmail@gmail.com>
# SPDX-License-Identifier: MIT

# Import the Selenium WebDriver libraries required for the test
import unittest
from appium import webdriver
from appium.webdriver.common.appiumby import AppiumBy
from appium.options.common.base import AppiumOptions
from selenium.webdriver.support.ui import WebDriverWait


class BabyKeyboardActivityTestCase(unittest.TestCase):
    """
    A test class for baby keyboard activity
    """

    @classmethod
    def setUpClass(cls) -> None:
        """
        Initialize the `TestCase` class and set up the driver
        """
        options = AppiumOptions()
        # The app capability may be a command line or a desktop file id.
        # Comment below code if gcompris is installed globally
        options.set_capability("app", "org.kde.gcompris.desktop")
        # options.set_capability("app", "/home/username/build-gcompris-Desktop-Debug/bin/gcompris-qt")

        # Set a timeout for waiting to find elements. If elements cannot be found
        # in time we'll get a test failure. This should be somewhat long so as to
        # not fall over when the system is under load, but also not too long that
        # the test takes forever.
        options.set_capability("timeouts", {'implicit': 10000})

        # Boilerplate, always the same
        cls.driver = webdriver.Remote(command_executor="http://127.0.0.1:4723", options=options)

    @classmethod
    def tearDownClass(cls) -> None:
        """
        Terminate the driver after execution of all testcases using tearDownClass method.
        """
        # Make sure to terminate the driver again, lest it dangles.
        cls.driver.quit()

    def setUp(self) -> None:
        """
        Set the configuration required for test fixture using `setUp` method.
        This method is called immediately before calling the test method.
        Other than `AssertionError` or `SkipTest`, any exception raised by this method will be thrown as error.
        """
        # Find the UI element with name "computer", and click it
        self.driver.find_element(by=AppiumBy.NAME, value="computer").click()

    def get_results(self) -> str:
        # Find the UI element using its accessible description as locator.
        results = self.driver.find_element(by="description", value="Text results")
        return results.text  # Returns the text entered by user from its accessible name

    def test_type_keys(self) -> None:
        """
        Initialize the testcase step
        """
        # Click on "baby_keyboard" activity icon
        self.driver.find_element(by=AppiumBy.NAME, value="baby_keyboard/baby_keyboard.svg").click()
        # Initialize WebDriverWait to wait for maximum 10s
        wait = WebDriverWait(self.driver, 10)
        # Get "TextEdit" element using its accessible name as locator.
        text_input = self.driver.find_element(by=AppiumBy.NAME, value="Text Input")
        # Initialize the keys list and send keys to the above "TextEdit" element one by one.
        keys_list = ["E", "C", "O", "K", "D", "E"]

        for k in keys_list:
            # Send a key to the "TextEdit" element
            text_input.send_keys(k)
            # Wait until the text field accepts the key and shows the correct result
            wait.until(lambda x: self.get_results() == k)

        self.driver.find_element(by=AppiumBy.NAME, value='bar_home').click()  # Click on Home icon in activity


if __name__ == "__main__":
    # Set the unittest config required to run the testcase
    unittest.main()
