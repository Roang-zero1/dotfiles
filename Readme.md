# Linux and Windows Tools

This is my personal tools collection which includes my dotfiles, some Windows Documentation and scripts written for development convenience.

## Setup

Install `chezmoi` and nix with home-manager on the system.

### Nix

#### Package manager

Instal nix as multi-user installation as documented at <https://nixos.org/download/>.

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

### chezmoi

With nix ready we can use it to run `chezmoi` and init our dotfiles:

```bash
nix-env -i chezmoi
chezmoi init --apply Roang-zero1
```

#### Home Manager

Finally run the `home-manager` initialization. 
Follow the home manager installation guide for systems with flake support: <https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone>.

```bash
nix run home-manager/master -- init --switch
```
