#!/bin/bash

cd ~
rm -f .zshrc
rm -f .gemrc
rm -f .vimrc
ln -s ~/tools/zsh/zshrc .zshrc
ln -s ~/tools/ruby/gemrc .gemrc
ln -s ~/tools/vim/vimrc .vimrc
