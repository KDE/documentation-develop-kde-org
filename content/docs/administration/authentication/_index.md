---
title: Authentication
group: administration
description: Configuration of PAM-based authentication methods

# SPDX-FileCopyrightText: 2026 Harald Sitter <sitter@kde.org>
SPDX-License-Identifier: CC-BY-SA-4.0
---


## Introduction

Authentication generally runs through a technology called *Pluggable Authentication Modules*, or “PAM”. PAM is supported in Plasma’s Login Manager, screen locker, and Polkit authentication dialog, as well as many other non-KDE technologies.

PAM uses configuration files (often referred to as “services”) that encode a set of rules that must be met in order for authentication to succeed. PAM services are generally provided by your OS vendor, not KDE.

This page describes how to configure which PAM-enabled authentication methods can be used in KDE software.

{{< alert color="info" >}}
If you only want or need to authenticate with a password, you can stop reading now.
{{< /alert >}}




## Enable multiple authentication methods on the lock screen
{{< alert color="warning" >}}
This feature is still experimental and may change in the future.
{{< /alert >}}

The lock screen will always accept a password if the system’s PAM services allow it (most do).

In Plasma 6.8 and later, the lock screen can also be configured to accept secondary authentication methods that the system’s PAM services support. To do this, edit `~/.config/kscreenlockerrc` to include the following:

```ini
[Authenticators]
# Set the ones you want to enable on the lock screen to "true"

# Fingerprint
Fingerprint=true

# Hardware 2-factor authentication dongle (e.g. Nitrokey or Yubikey)
Universal2Factor=true

# Smart card
Smartcard=true

# Facial recognition
Face=true
```

**Each enabled secondary authentication method enabled must have its PAM service appropriately configured.** Read on to learn how to do that for each one:


### Fingerprint authentication
If the system has an appropriate PAM service for authentication using a fingerprint reader, do the following to turn it on:

- GUI: *System Settings* >  *Users* > *Configure Fingerprint Authentication…*.
- CLI: Run `fprintd-enroll` in a terminal window


### Hardware 2-factor authentication dongle
If the system has an appropriate PAM service for authentication using a hardware 2-factor authentication dongle such as a Nitrokey or Yubikey, do the following to turn it on:

- GUI: Download the appropriate app ([Nitrokey](https://flathub.org/en/apps/com.nitrokey.nitrokey-app2) or [Yubikey](https://flathub.org/en/apps/com.yubico.yubioath)), launch it, and follow the instructions for enrolling a new device.
)
- CLI: run the following commands in a terminal window:
  ```sh
  [ -d ~/.config/Yubico ] || mkdir --parents ~/.config/Yubico
  pamu2fcfg > ~/.config/Yubico/u2f_keys
  ```

{{< alert color="info" >}}
During this process, your device may illuminate. When it does, touch it.

After setup, touch the device when using it to authenticate.
{{< /alert >}}


### Smart Card
{{< alert color="warning" >}}
This is by far the most complicated authentication method to set up.

These instructions will probably will be replaced with a server-side solution in the future, as this type of setup is usually only found in an organizational context with server-side support.

**If your organization provide its own instructions for setting up smart cards, follow those instead.**
{{< /alert >}}

If the system has an appropriate PAM service for authentication using a PKCS11-compatible device (smart card + reader, Nitrokey with PIV, or Yubikey with PIV), do the following to turn it on:

```sh

# Initialize your smart card if you haven’t yet:
pkcs11-tool \
  --init-token \
  --init-pin \
  --new-pin 123456 \ # Replace this with a PIN of your choosing
  --so-pin security-officer-123456 \ # Replace 123456 with the PIN you chose earlier
  --label MyCard

# Generate a key pair for login
pkcs11-tool \
  --login \
  --pin 123456 \ # Replace 123456 with the PIN you chose earlier
  --label LoginKey \
  --keypairgen \
  --key-type EC:prime256v1

# Note the URI of the private key in the output! We’ll need it for openssl.
URI="pkcs11:object=LoginKey;type=private"

# Create a certificate signing request (CSR):
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
  --pin 123456 \ # Replace 123456 with the PIN you chose earlier
  --label LoginKey \
  --write-object loginkey.crt \
  --type=cert

# Make the certificate a CA certificate
sudo cp loginkey.crt /etc/pam_pkcs11/cacerts
```

This should provide basic functionality.

For a more production-ready setup, you’ll likely need to tweak all sorts of configuration values in the `pam_pkcs11` PAM service provided by your OS to suit your organization’s security needs; follow their instructions to do so, as it is beyond the scope of this document.

The [pam_pkcs11 user manual](https://opensc.github.io/pam_pkcs11/doc/pam_pkcs11.html) should be a good starting point to find out more.


### Face
If the system has an appropriate PAM service for authentication using an infrared facial recognition camera, turning it on will require setup actions specific to the facial recognition software used. KDE currently has no recommendations for which software to use, as there are multiple options each with their own features and trade-offs.


## Multi-factor authentication or disabling password authentication
Most PAM services to enable non-password methods of authentication make them secondary and optional, so users can always authenticate with a password in addition to any of the secondary methods.

To disable password authentication or require multiple sources of authentication, the PAM services themselves must be edited accordingly. Instructions for doing so are beyond the scope of this document. To begin learning how to configure PAM services, take a look at the manual pages for [PAM](https://man7.org/linux/man-pages/man8/PAM.8.html) and [pam.conf](https://man7.org/linux/man-pages/man5/pam.conf.5.html).
