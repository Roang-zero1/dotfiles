{
  config,
  pkgs,
  dracula-dircolors-repo,
  ...
}: {
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
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.alejandra
    pkgs.bitwarden-cli
    pkgs.carapace
    pkgs.delta
    pkgs.fd
    pkgs.gitlint
    pkgs.glibc
    pkgs.lazydocker
    # will be renamed in the future
    pkgs.nixfmt-rfc-style
    pkgs.shellcheck
    pkgs.zinit
    pkgs.zsh-forgit
    pkgs.nixd
    pkgs.curl
    pkgs.python313
    pkgs.pdm
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.shellAliases = import ./aliases.nix;
  programs.zsh.shellAliases = import ./zsh/aliases.nix;

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/lucas/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
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
    ZDOTDIR = "${config.xdg.dataHome}/zsh";
    ZINIT_HOME = "${config.xdg.dataHome}/zinit";
  };

  # dircolors
  home.file.".dir_colors".text =
    builtins.readFile "${dracula-dircolors-repo}/.dircolors";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat = {
    enable = true;

    config.theme = "Dracula";
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
  };

  programs.nixvim.config = {
    enable = true;
    extraPlugins = [pkgs.vimPlugins.dracula-nvim];

    globals = {mapleader = " ";};
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
      completeopt = ["menuone" "noinsert" "noselect"];
    };

    colorscheme = "dracula";
    plugins.lualine = {
      enable = true;

      settings.options.icons_enabled = true;
    };
  };

  programs.nnn = {
    enable = true;

    package = pkgs.nnn.overrideAttrs (finalAttrs: previousAttrs: {
      makeFlags = ["PREFIX=$(out)" "O_NERD=1" "O_GITSTATUS=1" "O_NAMEFIRST=1"];
    });

    plugins.src =
      (pkgs.fetchFromGitHub {
        owner = "jarun";
        repo = "nnn";
        rev = "v4.0";
        sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
      })
      + "/plugins";
    plugins.mappings = {
      p = "preview-tui";
      d = "dups";
      c = "diffs";
      f = "fzopen";
      s = "finder";
      g = "-!git diff";
      e = ''-!code "$nnn"'';
    };
  };
  home.sessionVariables = {
    NNN_FCOLORS = "C1E20402036033F7C6D6ABC4";
    NNN_FIFO = "/tmp/nnn.fifo";
    NNN_OPENER = "${config.xdg.dataHome}/nnn/plugins/nuke";
  };

  programs.pyenv.enable = true;
  programs.starship = {enable = true;};
  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";

    # History settings
    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreAllDups = true;
      path = "${config.xdg.dataHome}/zsh/history";
      share = true;
    };

    plugins = [
      {
        name = "forgit";
        src = "${pkgs.zsh-forgit}/share/zsh/zsh-forgit";
      }
    ];
    initExtraFirst = ''
      source ${pkgs.zinit}/share/zinit/zinit.zsh
    '';
    initExtraBeforeCompInit = ''
      eval $(${pkgs.coreutils}/bin/dircolors -b ~/.dir_colors)
      source ${pkgs.nnn.src}/misc/quitcd/quitcd.bash_sh_zsh

      if type "fd" >> /dev/null; then
        _fzf_compgen_path() {
          fd --hidden --follow --exclude ".git" . "$1"
        }

        _fzf_compgen_dir() {
          fd --type d --hidden --follow --exclude ".git" . "$1"
        }
      fi

      zinit wait lucid for \
        OMZP::extract \
        OMZP::cp

      source <(carapace chmod zsh)
    '';
    initExtra = ''
      ${builtins.readFile ./zsh/bindkeys.zsh}
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4,underline"
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
      ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"

      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':fzf-tab:*' switch-group ',' '.'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
      zstyle ':fzf-tab:*' query-string '''
      zstyle ":completion:*" list-colors ''${(s.:.)LS_COLORS}
    '';
    completionInit = ''
      zinit wait lucid for \
          light-mode "Aloxaf/fzf-tab" \
        atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
          zdharma-continuum/fast-syntax-highlighting \
        atload"!_zsh_autosuggest_start" \
          zsh-users/zsh-autosuggestions
    '';
  };
}
