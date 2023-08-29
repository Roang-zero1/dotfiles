{
  # Disable correction.
  cp = "nocorrect cp -i";
  grep = "nocorrect grep --color=auto";
  ln = "nocorrect ln -i";
  man = "nocorrect man";
  mkdir = "nocorrect mkdir -p";
  mv = "nocorrect mv -i";
  rm = "nocorrect rm -i";

  # Disable globbing.
  bower = "noglob bower";
  find = "noglob find";
  history = "noglob history";
  locate = "noglob locate";
  rsync = "noglob rsync";
  scp = "noglob scp";
  sftp = "noglob sftp";
}
