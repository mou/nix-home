{
  description = "MOU's home configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    alejandra = {
      url = "github:kamadorueda/alejandra/2.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    alejandra,
    ...
  } @ inputs: let
    pkgs_overlays = import ./packages/overlay.nix;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = pkgs_overlays;
    };
  in {
    homeConfigurations = {
      linux-dev-laptop = inputs.home-manager.lib.homeManagerConfiguration {
        inherit system pkgs;
        homeDirectory = "/home/mou";
        username = "mou";
        configuration = {
          pkgs,
          config,
          lib,
          ...
        }: {
          imports = [
            ./modules/vim.nix
            ./modules/zsh.nix
            ./modules/git.nix
          ];
          fonts.fontconfig.enable = true;
          home.packages = with pkgs; [
            tig
            htop
            amfora
            tree
            fira-code
            jetbrains-mono
            (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "Meslo"];})
            _1password
            alejandra.defaultPackage.${system}
            restic
            ripgrep
            tmux
            nix-prefetch
            lazygit
            obsidian-export
          ];
          programs.direnv = {
            enable = true;
            enableZshIntegration = true;
            nix-direnv.enable = true;
          };
          xdg.enable = true;
        };
      };
    };
    linux-dev-laptop = self.homeConfigurations.linux-dev-laptop.activationPackage;
  };
}
