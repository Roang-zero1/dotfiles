# Using gpg for ssh auth on Windows

## Configuring Gpg4Win

This is based on the guide [My Perfect GnuPG / SSH Agent Setup](http://www.bootc.net/archives/2013/06/09/my-perfect-gnupg-ssh-agent-setup/) by [Chris Boot](http://www.bootc.net/archives/author/bootc/).

* Install the latest version of [Gpg4win](https://www.gpg4win.org/).  
For convenience you can install GPA, but it is not needed.
* Activating gpg putty support:
  * Via GPA:  
  Edit -> Backend Preferences -> GPG Agent  
  enable-putty-support
  * Edit or create the file %APPDATA%\gnupg\gpg-agent.conf.  
  Add the line `enable-putty-support`
* Restart the gpg agent with:
  * `gpg-connect-agent killagent /bye`
  * `gpg-connect-agent /bye`
* Add `gpg-connect-agent /bye` to the Windows start-up for instant availability

## git configuration

### SSH Keys

In order to use the configuration above you will need to set git up in a way where it uses the agent provided by gpg.

In order to do this download the plink executable provided by putty and add the following environment variable:
```
Name: GIT_SSH
Value: <Path to plink>\plink.exe
```

### Singing with gpg4win

In order to use gpg4win in git code signing you have set it up this way:
* Add a signing key to gpg4win
* Set the singing key in git  
`git config --global user.signingkey <key hash>`
* Tell git to use gpg  
`git config --global commit.gpgsign true`
* Change the gpg exe used by git  
`git config --global gpg.program "c:/Program Files (x86)/GNU/GnuPG/gpg2.exe"`
