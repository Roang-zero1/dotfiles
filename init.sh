#!/bin/bash

cd ~

# Initialize zsh
echo "Relinking .zshrc"
rm -f .zshrc
ln -s ~/tools/zsh/zshrc .zshrc

echo "Relinking .gitconfig"
rm -f .gitconfig                                                                                                                                   
case $HOSTNAME in
  (canopus.uberspace.de) echo "Linkink userspace";ln -s ~/tools/git/uberspace .gitconfig;;
  (*) ;;
esac

# Initialize gem local environment
echo "Relinking .gemrc"
rm -f .gemrc
case $HOSTNAME in
  (canopus.uberspace.de) echo "Linkink userspace";ln -s ~/tools/ruby/gemrc-userinstall .gemrc;;
  (*) ;;
esac

# Initialize vim
echo "Relinking .vimrc"
rm -f .vimrc
ln -s ~/tools/vim/vimrc .vimrc

mkdir -p .vim
rm -f .vim/bundle
ln -s ~/tools/vim/bundle .vim/bundle
rm -f .vim/plugin
ln -s ~/tools/vim/plugin .vim/plugin

