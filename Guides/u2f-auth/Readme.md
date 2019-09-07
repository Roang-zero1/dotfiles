# Authentication with U2F

Follow the [guide](https://support.yubico.com/support/solutions/articles/15000011356-ubuntu-linux-login-guide-u2f) on the yubico support to set up the basics required for 2fa.

## Associating the U2F Key(s) With Your Account

To allow the login with the same key on multiple computers we have to define an application and origin when adding keys.
Do this with the following commands:

```bash
pamu2fcfg -opam://ubuntu -ipam://ubuntu > .config/Yubico/u2f_keys
pamu2fcfg -opam://ubuntu -ipam://ubuntu -n >> .config/Yubico/u2f_keys

```

## Activating the 2fa

Copy the less restrictive optional 2fa to test it with sudo:

```bash
sudo cp pam.d/common-auth /etc/pam.d/common-auth
```

Open a new window and test if sudo works with Yubikey, if it does activate the mandatory 2fa for sudo.

```bash
sudo cp pam.d/common-auth-2fa /etc/pam.d/common-auth-2fa
sudo cp pam.d/sudo /etc/pam.d/sudo
```
