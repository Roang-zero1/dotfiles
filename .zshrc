TMPPREFIX=~/tmp/zsh-
mkdir -p ~/tmp
export TERM="xterm-256color"

## Powerlevel Theme settings

# Enable fa icon support
P9K_MODE='nerdfont-complete'

DEFAULT_USER='lucas'
P9K_LEFT_PROMPT_ELEMENTS=('root_indicator' 'background_jobs' 'context' 'dir' 'vcs' 'status')
P9K_RIGHT_PROMPT_ELEMENTS=('virtualenv' 'history' 'time' 'battery')
P9K_PROMPT_ON_NEWLINE=true
P9K_MULTILINE_FIRST_PROMPT_PREFIX_ICON=""
P9K_MULTILINE_LAST_PROMPT_PREFIX_ICON=$'%K{green}%F{black} \uf155 %f%F{green}%k\ue0b0%f '

P9K_STATUS_OK_ICON=$'\uf164'
P9K_STATUS_ERROR_ICON=$'\uf165'
P9K_STATUS_CR_ICON=$'\uf165'

P9K_DIR_SHORTEN_LENGTH=3
P9K_DIR_SHORTEN_STRATEGY="truncate_middle"
P9K_VCS_INCOMING_CHANGES_ICON="\u2193"
P9K_VCS_OUTGOING_CHANGES_ICON="\u2191"
P9K_VCS_SHOW_CHANGESET="true"
P9K_VCS_CHANGESET_HASH_LENGTH="12"
P9K_HISTORY_ICON="\uf1da"
P9K_TIME_FORMAT="%D{%H:%M \uf017 %d.%m.%y \uf073}"
P9K_TIME_ICON=""
P9K_STATUS_VERBOSE="true"
P9K_BATTERY_STAGES=($'\uf579' $'\uf57a' $'\uf57b' $'\uf57c' $'\uf57d' $'\uf57e' $'\uf57f' $'\uf580' $'\uf581' $'\uf578')
P9K_BATTERY_LEVEL_BACKGROUND=(clear)
P9K_BATTERY_LOW_THRESHOLD=15

case $USER in
 # Uberspace path maniplulation
  (denocte)
    P9K_CONTEXT_DEFAULT_FOREGROUND="red"
      ;;
  (*) ;;
esac

P9K_CONTEXT_DEFAULT_FOREGROUD=""

source ~/.zsh/zgen/zgen.zsh
# if the init script doesn't exist
if ! zgen saved; then

  # Load plugins
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/common-aliases
  zgen oh-my-zsh plugins/dirhistory
  zgen oh-my-zsh plugins/extract
  zgen oh-my-zsh plugins/git
  zgen oh-my-zsh plugins/git-extras
  zgen oh-my-zsh plugins/mosh
  zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/wd

  # Tips for defined aliases
  zgen load djui/alias-tips

  # Peco History search
  zgen load jimeh/zsh-peco-history

  # Better directory listings
  zgen load supercrabtree/k

  # Load Theme
  zgen load bhilburn/powerlevel9k powerlevel9k next

  zgen load joel-porquet/zsh-dircolors-solarized
  zgen load zlsun/solarized-man

  # Load additional completions
  zgen load zsh-users/zsh-completions src

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions

  # Load 256 Term colors
  zgen load chrissicool/zsh-256color

  # generate the init script from plugins above
  zgen save
fi


# Get hostname if environment variable is empty
if [ -z "$HOSTNAME" ]; then
  HOSTNAME=$(hostname)
fi

# Update history settings to provide larger shared history
HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=5000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt incappendhistory
setopt sharehistory
setopt extendedhistory

# Change autosuggestions colour
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=fg=4

bindkey -e
source ~/.zsh/bindkeys.zsh

source ~/.zsh/aliases.zsh
source ~/.zsh/completion/init.zsh

# Init solarized dir colours
setupsolarized dircolors.ansi-dark
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

alias ls='ls --color=auto'
alias vi='vim'

typeset -U path

# Export for tmux
export EDITOR='vim'

case $HOSTNAME in
  # Uberspace path maniplulation
  (canopus.uberspace.de)
    path=($HOME/.toast/armed/bin/zsh $path)
    path=(/package/host/localhost/nodejs-5/bin $path)
    path+=($HOME/.composer/vendor/bin)
    path+=(~/.gem/ruby/2.2.0/bin)
    path+=(~/src/go/bin)
    export MANPATH=$HOME/.toast/armed/share/man:/usr/local/share/man:/usr/share/man/overrides:/usr/share/man/en:/usr/share/man:/var/qmail/man:/usr/man:/usr/local/man
    export GOPATH=~/src/go
      ;;
  (travelbuntu)
      ;;
  (*) ;;
esac

