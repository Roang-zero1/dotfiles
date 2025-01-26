{
  config,
  pkgs,
  ...
}:
let
  aliases = import ./aliases.nix;
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    alejandra
    awscli2
    bitwarden-cli
    chezmoi
    curl
    delta
    fd
    gh
    gitlint
    lazydocker
    nixd
    # will be renamed in the future
    nixfmt-rfc-style
    nodePackages.prettier
    rage
    shellcheck
    shfmt
    yarn-berry
    zinit
    zsh-forgit
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    (python312.withPackages (
      ps:
      with ps;
      with python312Packages;
      [
        ipython
        ruff
        uv
        virtualenv
      ]
    ))
    vivid
  ];

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -b | bat -l man -p'";
    COLORTERM = "truecolor";
    GREP_COLOR = "4;38;5;235;48;5;4";
    GREP_COLORS = "mt=4;38;5;235;48;5;4";
    EDITOR = "vim";
    IPYTHONDIR = "${config.xdg.dataHome}/ipython";
    LESSHISTFILE = "${config.xdg.dataHome}/less/history";
    PYTHONSTARTUP = "${config.xdg.dataHome}/python/startup.py";
    PYLINTHOME = "${config.xdg.dataHome}/pylint";
    PYLINTRC = "${config.xdg.dataHome}/pylint/pylintrc";
    YADM_DIR = "${config.xdg.dataHome}/yadm";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  ############## PROGRAMS ##############

  programs.bat = {
    enable = true;
    config.theme = "Dracula";
  };
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    stdlib = builtins.readFile ./direnv/direnvrc;
  };
  programs.eza.enable = true;
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .venv";
    fileWidgetCommand = "fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude .venv";
    defaultOptions = [
      "--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9"
      "--color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9"
      "--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6"
      "--color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4"
    ];
  };
  programs.git = {
    enable = true;

    userName = "Lucas Brandstaetter";
    userEmail = "lucas@brandstaetter.tech";

    aliases = {
      branches = "branch -a";
      tags = "tag";
      stashes = "stash list";

      amend = "commit --amend";
      ane = "commit --amend --no-edit";
      fu = "commit --fixup";
    };

    extraConfig = {
      commit.verbose = true;
      merge = {
        stat = true;
        conflictstyle = "zdiff3";
      };
      push.default = "simple";
      rebase = {
        autosquash = true;
        autostash = true;
      };
    };

    includes = [
      { path = "~/.config/git/config.local"; }
    ];

    delta = {
      enable = true;
      options = {
        navigate = "true";
        line-numbers = "true";
        decorations = {
          commit-decoration-style = "bold yellow box ul";
          file-decoration-style = "none";
          file-style = "bold yellow ul";
        };
        features = "decorations";
        whitespace-error-style = "22 reverse";
      };
    };
  };
  programs.nixvim.config = {
    enable = true;
    extraPlugins = [ pkgs.vimPlugins.dracula-nvim ];

    globals = {
      mapleader = " ";
    };
    viAlias = true;
    vimAlias = true;

    opts = {
      relativenumber = true; # Show relative line numbers
      mouse = "vn";
      splitright = true;
      splitbelow = true;
      expandtab = true;
      tabstop = 2;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 750;
      completeopt = [
        "menuone"
        "noinsert"
        "noselect"
      ];
    };

    colorscheme = "dracula";
    plugins.lualine = {
      enable = true;

      settings.options.icons_enabled = true;
    };
  };
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.starship = {
    enable = true;

    settings = pkgs.lib.importTOML ./starship.toml;

    enableNushellIntegration = true;
    enableBashIntegration = true;

    enableTransience = true;
  };

  ############## SHELLS ##############
  programs.bash = {
    enable = true;

    initExtra = ''
      export LS_COLORS="$(vivid generate dracula)"
    '';

    shellAliases = aliases.common // aliases.bash;
  };
  programs.nushell = {
    enable = true;
    configFile.source = ./nushell/config.nu;
    envFile.source = ./nushell/env.nu;

    extraLogin = ''
      $env.XDG_DATA_DIRS = $"/usr/local/share/:/usr/share/:($env.HOME)/.local/share:${config.home.profileDirectory}/share"
    '';

    environmentVariables = builtins.mapAttrs (
      name: value: "${builtins.toString value}"
    ) config.home.sessionVariables;

    shellAliases = aliases.common;
  };
  home.file."${config.xdg.configHome}/nushell/lib/" = {
    source = ./nushell/lib;
    recursive = true;
  };

  ############## SERVICES ##############
  # Create a ssh-agent service that can be used by all session
  # and services (e.g. code tunnel)
  systemd.user.services.ssh-agent = {
    Unit = {
      Description = "SSH-agent service.";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "/usr/bin/ssh-agent -D -a $SSH_AUTH_SOCK";
      Environment = [
        "SSH_AUTH_SOCK=%t/ssh-agent.socket"
      ];
    };
  };
  # Add an environment.d file, so other services know about the SSH_AUTH_SOCK
  home.file.".config/environment.d/20-ssh-auth-sochet.conf".text =
    "SSH_AUTH_SOCK=\"\${XDG_RUNTIME_DIR}/ssh-agent.socket\"";
}
