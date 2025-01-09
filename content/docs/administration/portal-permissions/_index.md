---
title: XDG Portal Pre-Authorization
group: administration
description: Pre-authorize applications to allow usage of XDG portal tech without interactive dialogs
---

This feature was introduced in Plasma 6.3.

Interactive permission prompts are nice, but sometimes users need to authorize access to resources non-interactively. This can be done as follows:

```bash
flatpak permission-set kde-authorized [thing to authorize] [app to authorize] yes
```

Accepted values for `[thing to authorize]`:

- `remote-desktop`

Accepted values for `[app to authorize]`:
- The ID of an application packaged with Flatpak or Snap (can be found with `flatpak list` or `snap list`)
- The systemd unit name of a distro-packaged service, omitting the `.service` suffix.
- An empty string (`""`) to authorize all distro-packaged applications and services.


## Example

```bash
flatpak permission-set kde-authorized remote-desktop org.kde.krdpserver yes
```


## Caveats

* Distro-packaged applications may impersonate any `app_id`.
* An empty `app_id` may match too broadly. It's advisable to get the application to provide an `app_id` instead. See https://systemd.io/DESKTOP_ENVIRONMENTS/. In the future possibly also via https://github.com/flatpak/xdg-desktop-portal/pull/1521.
