#!/bin/bash

cd ~
rm -f .zshrc
rm -f .gemrc
ln -s ~/tools/zsh/zshrc .zshrc
ln -s ~/tools/ruby/gemrc .gemrc
