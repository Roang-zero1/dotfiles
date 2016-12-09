#!/bin/bash

if cd $HOME; then
  echo "Changed dir to $HOME"
else
  echo "CD failed to change dir"
  exit 1
fi

# Default linking
echo "Linking defaults"
rm -f .zshrc
rm -f .gitconfig
rm -f .vimrc
rm -r .vim
rm -f .gnupg/gpg.conf

echo "Relinking .zshrc"
ln -s ~/tools/zsh/zsh.rc .zshrc
echo "Relinking .gitconfig"
ln -s ~/tools/git/git.conf .gitconfig
echo "Relinking vim files and dirs"
ln -s ~/tools/vim/vim.rc .vimrc
ln -s ~/tools/vim/ .vim
echo "Relinking gnupg configuration"
ln -s ~/tools/gnupg/gpg.conf .gnupg/gpg.conf

# Host specific linking
case $HOSTNAME in
  (canopus.uberspace.de)
      echo "Linkink userspace";
      rm -f .bash_profile
      rm -f .gemrc

      echo "Relinking .gemrc"
      ln -s ~/tools/ruby/gem-userinstall.rc .gemrc
      echo "Relinking bash_profile"
      ln -s ~/tools/bash/bash_profile_uberspace .bash_profile
      yes | cp $HOME/tools/tools/keychain/keychain.sh $HOME/bin/keychain
      ;;
  (*) sudo yes | cp $HOME/tools/tools/keychain/keychain.sh /usr/bin/keychain
  ;;
esac
