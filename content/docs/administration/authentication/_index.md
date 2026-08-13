---
title: Authentication
group: administration
description: Configuration of the PAM stack on Linux

# SPDX-FileCopyrightText: 2026 Harald Sitter <sitter@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---

## Introduction

Authentication on Linux generally runs through a technology called
Pluggable Authentication Modules, or “PAM”. This also applies to the Plasma Login Manager,
Screen Locker, and Polkit dialog.

PAM is configured using configuration files, they are also called services or service files. They
describe which plugins to load and how those plugins interact with the control flow of the authentication.

For more information about PAM and its service files take a look at the PAM manual pages
[PAM](https://man7.org/linux/man-pages/man8/PAM.8.html) and [pam.conf](https://man7.org/linux/man-pages/man5/pam.conf.5.html).

## Multiple prompt services in Plasma Screen Locker

{{< alert title="Warning" color="warning" >}}
This feature introduced in Plasma 6.8 is still experimental and may change in the future.
{{< /alert >}}

PAM configurations are done through so called *"services"*. Where each service
encodes a set of rules that need to be met in order to authenticate a user.

Plasma supports a number of extra service defintions that may be supplied by
the distributor and enabled by the user.

### Configuration

Assuming all service files are provided by your distribution,
the additional services may be enabled selectively in the user specific
`~/.config/kscreenlockerrc`. Please beware that the PAM modules often also require
individual configuration. The *kscreenlockerrc* only enables the visualization
in the UI and may malfunction if the modules are not configured correctly.

```ini
[Authenticators]
Face=true
Fingerprint=true
Smartcard=true
Universal2Factor=true
```

### Fingerprint with fprintd

Requirements: fingerprint reader, fprintd

Fingerprint may be enabled as a standalone authentication prompt.

Please note that fingerprint is also always available as secondary authentication
option regardless of the primary. For example when you have the smart card
authenticator enabled you will also be able to use the fingerprint so long as
the PAM service is available and you have a fingerprint enrolled.

To enable fingerprint login simply enroll a fingerprint with *Users* system setting.
Alternatively you can use the terminal command `fprintd-enroll`.

### Face

Requirements: camera (with infrared sensor)

Face-based authentication generally requires enrolling your face in a database.
How this works is depending on the specific facial authentication software.
We currently have no recommendations for which software to use. You can find
various options available on the internet, but will need to research which
best fits your use case with regards to security, reliability, and ease of use.

### U2F / FIDO using pam-u2f

Requirements: U2F device such as Nitrokey or Yubikey

Same as with the others, U2F requires enrolling your device into a database first.

The simplest, and default, way is to use a per-user database. You can enroll your
device by running the following commands. Please note that you need to touch
your device when it lights up.

```sh
[ -d ~/.config/Yubico ] || mkdir --parents ~/.config/Yubico
pamu2fcfg > ~/.config/Yubico/u2f_keys
```

You also need to touch when authenticating using the device.

### Smart Card using pkcs11

Requirements: PKCS11-compatible device (smart card + reader, Nitrokey with PIV, Yubikey with PIV), opensc

This is by far the most complicated to set up and probably will be replaced with
a server-side solution in the future as this type of set up is usually only
found in an organizational context with server-backing.

For practical reasons we'll discuss how to set this up using an actual smart card.

Setting up a Nitrokey or Yubikey is largely the same except that you can easily manage
your certificates using the relevant applications for [Nitrokey](https://flathub.org/en/apps/com.nitrokey.nitrokey-app2)
or [Yubikey](https://flathub.org/en/apps/com.yubico.yubioath).

#### Setting up a Smart Card

Initialize your smart card if you haven't yet.

```sh
pkcs11-tool \
  --init-token \
  --init-pin \
  --so-pin security-officer-123456 \
  --new-pin 123456 \
  --label MyCard
```

Once the token is initialized we can prepare our keys and certificate

```sh
# Generate a key pair for login
pkcs11-tool \
  --login \
  --pin 123456 \
  --label LoginKey \
  --keypairgen \
  --key-type EC:prime256v1

# Note the URI of the private key in the output! We'll need it for openssl.
URI="pkcs11:object=LoginKey;type=private"

# Create a certificate signing request
openssl req -new \
  -engine pkcs11 -keyform engine -key $URI \
  -subj "/CN=$(id --user --name)" \
  -out loginkey.csr

# Create the certificate from the CSR
openssl x509 -req \
  -engine pkcs11 -keyform engine -key $URI \
  -days 365 \
  -in loginkey.csr \
  -out loginkey.crt

# Write the certificate to the token
pkcs11-tool \
  --login \
  --pin 123456 \
  --label LoginKey \
  --write-object loginkey.crt \
  --type=cert

# Make the certificate a CA certificate
run0 cp loginkey.crt /etc/pam_pkcs11/cacerts
```

The kde-smartcard service will have to contain a line similar to

```pam
auth required pam_pkcs11.so wait_for_card card_only
```

This should give you a working prototype. Mind that for a more production
viable setup you'll want to tweak all sorts of configuration values in pam_pkcs11.
These are largely organization specific. The [pam_pkcs11 user manual](https://opensc.github.io/pam_pkcs11/doc/pam_pkcs11.html)
should be a good starting point to find out more.

### Overview of services

- kde: The main authentication service. It is always available and generally
  implements the common authentication flow of the system. Usually this will be
  password authentication, but it could also include multiple factors, such as
  a password and a smart card.
- kde-fingerprint: Is a special variant where providing a fingerprint is sufficient
  for authentication. This is generally implemented using *pam_fprintd*.
- kde-smartcard: Similarly establishes a smart card as sufficient authentication.
  This is generally implemented using either *pam_pkcs11*.
- kde-face: Establishes facial recognition as sufficient authentication.
  This may be implemented by a variety of available facial recognition software.
  A notable, but not very active, example would be *pam_howdy*.
- kde-u2f: Establishes a Universal 2nd Factor or FIDO token as sufficient.
  This is usually implemented using *pam_u2f*.

## Miscellaneous

### Writing a service file

For the multiple prompts feature to work you first need to have the relevant
service files.

Service files are very distribution-specific. We will outline some general
examples but for the most part your distribution should be providing these files
for you. As a distributor you should first read up on the PAM manpages and then
craft service files that match your distribution's PAM configurations.

The main *kde* service will mostly follow your system core services.

Here is the one from KDE Linux for illustration:

```pam
#% PAM - 1.0

# SPDX-License-Identifier: LGPL-2.0-or-later
# SPDX-FileCopyrightText: 2024 Antonio Rojas <arojas@archlinux.org>

# Everything simply delegates to the common system-local-login service.
auth       include                     system-local-login
account    include                     system-local-login
password   include                     system-local-login
session    include                     system-local-login
```

You may find a similar file on your system in either `/usr/lib/pam.d/kde` or
`/etc/pam.d/kde`.

The authentication types described on this page follow a common scheme for configuration
where the pivotal PAM module will be marked either *required* or *sufficient*

Here is the *kde-u2f* service from KDE Linux:

```pam
#%PAM-1.0

auth       requisite                   pam_nologin.so
auth       required                    pam_u2f.so cue # <------- u2f is required
auth       required                    pam_shells.so
auth       optional                    pam_permit.so
auth       required                    pam_env.so

# Only support authentication. Deny all others.
account    required                    pam_deny.so
session    required                    pam_deny.so
password   required                    pam_deny.so
```

For the most part all other services will follow this example and simply load a
different pam module in place of pam_u2f.
