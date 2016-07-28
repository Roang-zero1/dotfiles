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

echo "Relinking .zshrc"
ln -s ~/tools/zsh/zsh.rc .zshrc
echo "Relinking .gitconfig"
ln -s ~/tools/git/git.conf .gitconfig
echo "Relinking vim files and dirs"
ln -s ~/tools/vim/vim.rc .vimrc
ln -s ~/tools/vim/ .vim

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
