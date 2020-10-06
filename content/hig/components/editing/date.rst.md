---
title: Date and Time Picker
---
====================

Purpose
-------

The date/time picker is a control that provides a convenient way to
select a certain date or time. The time picker works just like a
`spin box <spinbox>`{.interpreted-text role="doc"} with an adopted mask.
The date picker shows all days of a month in weekly columns, has small
navigation buttons to access previous and next month or years as well as
interactive controls to chose month and year directly. The user
\'picks\' the date per single click on a particular day. An additional
\'today\' button can be used to navigate back. The benefit of date/time
picker is that these controls prevent format error and provide feedback
on wrong input.

Guidelines
----------

-   Use a date/time picker as a convenient way to select a certain day
    or time.
    -   In situations where users enter a date that they already know
        for certain (e.g. their birthday), use a KDateWidget.
    -   If they want to enter a date and time they already know exactly,
        use a KDateTimeWidget.
    -   If users want to choose a date and time using the application
        (e.g. while scheduling an appointment or choosing a date for a
        vacation), use the KDatePicker or KDateComboBox (depending on
        the amount of space available) and KTimeComboBox or
        KTimeComboBox.
    -   If users want to browse through dates (for example when viewing
        a calendar or browsing a history based on the date), use a
        KDatePicker for convenient switching with a single click.\"
-   When user must select both start and end date/times, make the
    default end date/time aware of the start date/time: when the user
    sets a start date, switch the end date at least to the same date.
-   Avoid wrong input by restricting the period to a reasonable range
    (for instance when a range is being selected).
-   Don\'t modify localization settings (i.e. first day of week, date
    label etc.)
-   Use controls consistently; either all date input should be done by
    date picker or none.
-   Insert current time or date into into input field on user reset.
