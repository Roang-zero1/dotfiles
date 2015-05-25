source ~/ext_tools/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES
composer
common-aliases
dirhistory
extract
git
git-extras
mosh
wd
Tarrasch/zsh-bd
EOBUNDLES

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme desyncr/zshrc themes/af-magic-mod
#antigen theme clean

# Tell antigen that you're done.
antigen apply


HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=5000
setopt incappendhistory
setopt sharehistory
setopt extendedhistory

#ssh-agent via keychain
eval $(keychain --eval --agents ssh -Q id_rsa)
