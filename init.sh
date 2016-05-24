#!/bin/bash

cd ~

# Default linking
echo "Linking defaults"
rm -f .zshrc
rm -f .gitconfig
rm -f .vimrc
rm -f .vim/bundle
rm -f .vim/plugin

echo "Relinking .zshrc"
ln -s ~/tools/zsh/zsh.rc .zshrc
echo "Relinking .gitconfig"
ln -s ~/tools/git/uberspace.conf .gitconfig
echo "Relinking vim files and dirs"
ln -s ~/tools/vim/vim.rc .vimrc
mkdir -p .vim
ln -s ~/tools/vim/bundle .vim/bundle
ln -s ~/tools/vim/plugin .vim/plugin

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
      ;;
  (*) ;;
esac
