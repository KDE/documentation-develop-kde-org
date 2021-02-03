---
title: Progress Indicator
group: assistance
subgroup: notifications
---

Purpose
-------

If a foreground task lasts longer than expected or when calculation
takes some time, the system should provide some feedback on the task's
progress. Users are aware of response times of over one second and
shorter. Consequently, operations that take two seconds or longer to
complete should be considered to be lengthy and need of some type of
progress feedback. But even in cases of short delays the user should be
assured that the system is not hung or waiting for user input. Such a
feedback is done by changing the mouse cursor to a busy pointer (aka
throbber or spinner). When operation lasts longer the user should be
able to anticipate when it's finished. The appropriate graphical control
for this task is a progress bar.

Guidelines
----------

### Is this the right control?

-   Provide progress feedback when performing a lengthy operation. Users
    should never have to guess if progress is being made.
-   Show a busy pointer when the operation takes longer than 500 ms and
    a progress bar in case of 5 seconds or more.
-   Consider to move very long lasting operations to the background and
    notify on completion only.

### Behavior

-   User should be able to pause and cancel operations which last very
    long.
-   Clearly indicate real progress -- and lack of progress. The progress
    bar must advance if progress is being made and not advance if no
    progress is being made.
-   Show progress by steps in respect to context. For instance, don't
    inform about the number of files that have been downloaded but
    rather the total size in bytes.
-   Provide additional progress information, but only if users can do
    something with it, e.g. cancel the processing, relate an error to a
    particular processing step, etc. Don't provide unnecessary details.
-   Don't use progress bars if the time needed to complete the task
    cannot be estimated, as well not per waiting bar (aka marquee
    style). In that case, if the task will likely take only a few
    seconds, use a spinner. If it takes longer, move the task to the
    background.
-   Don't combine a progress bar with a busy pointer.
