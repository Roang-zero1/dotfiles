{
  description = "Home Manager configuration of lucas";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    nixvimModule = nixvim.homeManagerModules.nixvim;
    dracula-dircolors-repo = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "dircolors";
      rev = "89479aa861c4193805076a00ef7f0932d5eea134";
      sha256 = "sha256-ZMBTKEp4oO1My53UYPcndwhZnh96FANsZk2+OD9Kxsc=";
      sparseCheckout = [".dircolors"];
    };
  in {
    homeConfigurations."lucas" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [./home.nix nixvimModule];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {inherit dracula-dircolors-repo;};
    };
  };
}
