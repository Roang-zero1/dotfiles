#!/bin/bash

if cd $HOME; then
  echo "Changed dir to $HOME"
else
  echo "CD failed to change dir"
  exit 1
fi

echo "Removing existing config"
rm -f .zshrc
rm -f .gitconfig
rm -f .gitlocalconfig
rm -f .vimrc
rm -r .vim
rm -f .gnupg/gpg.conf
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

PS3="Please select the configuration to apply: "
options=("Own" "Uberspace" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Own")
      echo "Applying mapping specific to own devices"
      echo "Linking local config"
      ln -s ~/tools/git/travelbuntu .gitlocalconfig
      break
      ;;
    "Uberspace")
      echo "Applying mapping specific to Uberspaces"
      echo "Linkink userspace";
      rm -f .bash_profile
      rm -f .gemrc

      echo "Relinking .gemrc"
      ln -s ~/tools/ruby/gem-userinstall.rc .gemrc
      echo "Relinking bash_profile"
      ln -s ~/tools/bash/bash_profile_uberspace .bash_profile
      yes | cp $HOME/tools/tools/keychain/keychain.sh $HOME/bin/keychain
      echo "Linking local config"
      ln -s ~/tools/git/travelbuntu .gitlocalconfig
      break
      ;;
    "Quit")
      break
      ;;
    *) echo "invalid option $Reply";;
  esac
done
