{
  # File listing aliases
  ls = "eza";
  l = "eza -1a"; # Lists in one column, hidden files.
  ll = "eza -lb --git --time-style=long-iso"; # Lists in a list
  llt = "ll --tree --level=2"; # Lists in a tree
  lltt = "ll --tree"; # Lists in a deep tree
  lr = "ll -R"; # Lists human readable sizes, recursively.
  la = "ll -hHgma --color-scale"; # Lists human readable sizes, hidden files.
  lad = "la --group-directories-first"; # Lists human readable sizes, hidden files.
  lm = ''la | "$PAGER"''; # Lists human readable sizes, hidden files through pager.
  lk = "ll -s size"; # Lists sorted by size, largest last.
  lt = "ll -s modified"; # Lists sorted by date, most recent last.
  lc = "lt -U"; # Lists sorted by date, most recent last, shows created time.
  lu = "lt -u"; # Lists sorted by date, most recent last, shows access time.

  # git
  g = "git";
  gst = "git status";

  # Tool specific aliases
  cat = "bat -p";
  get = "curl --continue-at - --location --progress-bar --remote-name --remote-time";
  lzd = "lazydocker";
  n = "n -c";
  nnn = "nnn -c";

  apt = "sudo apt";
  ports = "ss -tulanp";

  df = "df -kh";
  du = "du -kh";
}
