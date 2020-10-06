---
title: Table View
---
==========

Purpose
-------

A table (also known as grid or spreadsheet) is a graphical control to
present data in an ordered arrangement of rows and columns. The
intersection of a row and a column is a cell. The elements of a table
may be grouped, segmented, or arranged in many different ways, and even
nested recursively. It provides a familiar way to convey information
that might otherwise not be obvious or readily understood.

Tables provide inline editing with the advance of a concise layout since
no additional control is needed for input. The approach is usually less
error-prone because a list with direct input has no dependency to other
controls (in contrast to the combination of a list with an edit which
needs to be enabled or disabled appropriate to the list entry the user
clicks). The drawback is reduced discoverability for lists with
restricted editing function, at least when only a few cells can be
changed. User does not know which cell is editable and which is not.

Guidelines
----------

### Is this the right control?

-   Use a table to arrange data in two dimensions.
-   Use a table for a concise layout with inline editing feature.
-   Don\'t use a table for read-only data. In this case use a simple
    `list view <list>`{.interpreted-text role="doc"} or a
    `tree view <tree>`{.interpreted-text role="doc"} with multiple
    columns.

### Behavior

-   Switch from viewing mode to edit mode after single click on the
    editable cell.
-   Change appearance of cells when switching from viewing to editing.
    Editable cells have a lowered bevel; they look like they can be
    filled.
-   Mark currently changed cells with a red corner.
-   Define keyboard navigation within the table since the control
    receives focus as a whole. By pressing arrow-down key the next row
    is focused; respectively arrow-up for previous row. The arrow-left
    or arrow-right key navigates to adjacent columns if available.
    Don\'t change tab key navigation to allow users to switch to other
    controls.
-   Use the appropriate control for constrained input. Show the
    control's UI (e.g. arrow for
    `drop-down list <dropdown>`{.interpreted-text role="doc"}) not until
    the cell is in edit mode.
-   Distinguish editable cells from those that are read-only.
-   Allow tables to be extended by users in both directions.
-   Provide copy/paste feature for single as well as multiple selected
    cells, if appropriate.

### Appearance

-   Avoid horizontal scrollbars. Size the table to a reasonable width.
-   Use fixed column header.
-   Label the table with a descriptive caption to the top left (cf.
    `/layout/alignment`{.interpreted-text role="doc"}).
-   Create a buddy relation so access keys are assigned.
