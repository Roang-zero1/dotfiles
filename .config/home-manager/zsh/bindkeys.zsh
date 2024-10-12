#!/bin/zsh

bindkey -e

bindkey "\e[2~" overwrite-mode
bindkey "\e[3~" delete-char

# # Home- und End-Keys.
if [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; then
  bindkey "^[[1~" beginning-of-line
  bindkey "^[[4~" end-of-line
else
  # Assign these keys if tmux is NOT being used:
  bindkey "^[[H" beginning-of-line
  bindkey "^[[F" end-of-line
fi

bindkey "^[[5~" beginning-of-history #PageUp
bindkey "^[[6~" end-of-history #PageDown

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Keypad
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[On" ","
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ol" "+"
bindkey -s "^[OS" "-"
bindkey -s "^[OR" "*"
bindkey -s "^[OQ" "/"
