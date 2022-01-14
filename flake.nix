{
  description = "MOU's home configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, ... }@inputs: 
  {
    homeConfigurations = {
      linux-dev-laptop = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/mou";
        username = "mou";
        configuration = { pkgs, config, ... }:
        {
          fonts.fontconfig.enable = true;
          home.packages = with pkgs; [
            git
            fira-code
            jetbrains-mono
          ];
          programs.zsh = {
            enable = true;
            oh-my-zsh = {
              enable = true;
              plugins = [ "git" ];
              theme = "simple";
            };
            initExtra = ''
              source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
              export NIX_PATH=''${NIX_PATH:+$NIX_PATH:}''$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
              if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
                source ~/.nix-profile/etc/profile.d/nix.sh
              fi
              source ''$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
              export SSH_AUTH_SOCK=''$(gpgconf --list-dirs agent-ssh-socket)
            '';
          };
      	  programs.neovim = {
            enable = true;
            vimAlias = true;
            viAlias = true;
          };
          programs.git = {
            enable = true;
            userEmail = "anlarionov@gmail.com";
            userName = "Andrey \"MOU\" Larionov";
            signing = {
              key = "59033F59EC3C7FB7";
              signByDefault = true;
            };
            extraConfig = {
              init = {
                defaultBranch = "main";
              };
            };
          };
          xdg = {
            enable = true;
            configFile = {
              nvim = {
                source = ./config/neovim;
                recursive = true;
              };
            };
          };
        };
      };
    };
    linux-dev-laptop = self.homeConfigurations.linux-dev-laptop.activationPackage;
  };
}
