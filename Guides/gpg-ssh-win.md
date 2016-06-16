# Using gpg for ssh auth on Windows

This is based on the guide [My Perfect GnuPG / SSH Agent Setup](http://www.bootc.net/archives/2013/06/09/my-perfect-gnupg-ssh-agent-setup/) by [Chris Boot](http://www.bootc.net/archives/author/bootc/).

* Install the latest version of [Gpg4win](https://www.gpg4win.org/).  
For convenience you can install GPA, but it is not needed.
* Activating gpg putty support:
  * Via GPA:  
  Edit -> Backend Preferences -> GPG Agent  
  enable-putty-support
  * Edit or create the file %APPDATA%\gnupg\gpg-agent.conf.  
  Add the line enable-putty-support
* Restart the gpg agent with:
  * `gpg-connect-agent killagent /bye`
  * `gpg-connect-agent /bye`
* Add `gpg-connect-agent /bye` to the Windows start-up for instant availability
