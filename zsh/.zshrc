source ~/tools/zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES
composer
common-aliases
dirhistory
extract
gem
git
git-extras
mosh
npm
tmux
wd
Tarrasch/zsh-bd
EOBUNDLES

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
#antigen theme desyncr/zshrc themes/af-magic-mod
antigen theme robbyrussell/oh-my-zsh themes/ys
#antigen theme clean

# Tell antigen that you're done.
antigen apply

# Change history to be shared
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=5000
setopt incappendhistory
setopt sharehistory
setopt extendedhistory

#ssh-agent via keychain
eval $(keychain --eval --agents ssh -Q id_rsa)

# bindkey
bindkey -e
bindkey "\e[3~" delete-char
# # Home- und End-Keys.
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# Initialize solarized ansi dircolors
eval `dircolors ~/tools/zsh/dircolors/dircolors.ansi-dark`

typeset -U path

path[1,0]=/package/host/localhost/ruby-2.2.0/bin
path[1,0]=~/.gem/ruby/2.2.0/bin
path[1,0]=/package/host/localhost/nodejs-0.10.40/bin
