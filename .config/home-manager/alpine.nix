{...}: {
  imports = [./home.nix];

  home.shellAliases.poweroff = "doas /sbin/poweroff";
}
