{
  description = "MOU's home configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    alejandra,
    ...
  } @ inputs: {
    homeConfigurations = {
      linux-dev-laptop = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
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
          nixpkgs.config = {
            allowUnfree = true;
          };
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
            obsidian
            tmux
            nix-prefetch
            lazygit
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
