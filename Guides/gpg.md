# GPG Key management

## Preparation

set keyid=<Main Key ID>
set keyname=<Key Name>

## Generate Backup

```
gpg --output %keyname%.gpg-revocation-certificate.asc --gen-revoke %keyid%
gpg --armor --export %keyid% > %keyname%.public.asc
gpg --armor --export-secret-keys %keyid% > %keyname%.private.asc
gpg --armor --export-secret-subkeys %keyid% > %keyname%.subkeys.private.asc
```

## Add new subkey

```
# switch to gpg main home
gpg --edit-key %keyid%
gpg> addkey
# Select RSA (sign only)
Your selection? 4
# Select desired validity
Key is valid for? (0) 1y
gpg> save
```

Generate Backup Files

## Export single subkey

```
gpg --export-secret-subkeys <subkey ID>! > subkey.asc
# Switch to subkey environment
# Clear environment
gpg --import %keyname%.public.asc
gpg --import subkey.asc
gpg --edit-key %keyip%
gpg> passwd
gpg --export-secret-subkeys <subkey ID>! > subkey.asc
```
