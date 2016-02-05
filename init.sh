#!/bin/bash

cd ~

# Initialize zsh
echo "Relinkin .zshrc"
rm -f .zshrc
ln -s ~/tools/zsh/zshrc .zshrc

# Initialize gem local environment
echo "Relinkin .gemrc"
rm -f .gemrc
case $HOSTNAME in
  (canopus.uberspace.de) echo "Linkink userspace";ln -s ~/tools/ruby/gemrc-userinstall .gemrc;;
  (*) ;;
esac

# Initialize vim
echo "Relinkin .vimrc"
rm -f .vimrc
ln -s ~/tools/vim/vimrc .vimrc

mkdir -p .vim
rm -f .vim/bundle
ln -s ~/tools/vim/bundle .vim/bundle
rm -f .vim/plugin
ln -s ~/tools/vim/plugin .vim/plugin