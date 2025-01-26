{
  common = {
    # File listing aliases
    ll = "ls -l"; # Lists in a list
    la = "ls -la"; # Lists in a list, hidden files.

    l = "eza -1a"; # Lists in one column, hidden files.
    llt = "eza -l --tree --level=2"; # Lists in a tree
    lltt = "eza -l --tree"; # Lists in a deep tree
    lr = "eza -lR"; # Lists human readable sizes, recursively.

    lad = "eza -l --group-directories-first"; # Lists human readable sizes, hidden files.
    lk = "eza -ls size"; # Lists sorted by size, largest last.
    lt = "eza -ls modified"; # Lists sorted by date, most recent last.
    lc = "eza -lUs modified"; # Lists sorted by date, most recent last, shows created time.
    lu = "eza -lus modified"; # Lists sorted by date, most recent last, shows access time.

    g = "git";
    gst = "git status";

    # ForGit aliases
    ga = "git forgit add";
    gco = "git forgit checkout_branch";
    gfu = "git forgit fixup";
    grb = "git forgit rebase";
    grl = "git forgit reflog";
    devgit = "git --git-dir=.gitdev";

    # Tool specific aliases
    cat = "bat -p";
    dl = "curl --continue-at - --location --progress-bar --remote-name --remote-time";
    lzd = "lazydocker";

    apt = "sudo nala";
    nala = "sudo nala";
    ports = "ss -tulanp";
    cm = "chezmoi";

    df = "df -h";
  };

  bash = {
    ls = "eza";
    la = "eza -l -hHgma --color-scale"; # Lists human readable sizes, hidden files.
    ll = "eza -lb --git --time-style=long-iso";
    du = "du -kh";
  };
}
