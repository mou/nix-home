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
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      alejandra,
      ...
    } @ inputs:
    let
      system = "x86_64-linux";
    in {
      homeConfigurations = {
        linux-dev-laptop = inputs.home-manager.lib.homeManagerConfiguration {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          homeDirectory = "/home/mou";
          username = "mou";
          configuration =
            {
              pkgs,
              config,
              lib,
              ...
            }:
            {
              fonts.fontconfig.enable = true;
              home.packages = with pkgs; [
                tig
                htop
                amfora
                tree
                fira-code
                jetbrains-mono
                (nerdfonts.override { fonts = ["FiraCode" "JetBrainsMono" "Meslo"]; })
                _1password
                alejandra.defaultPackage.${system}
              ];
              programs.zsh = {
                enable = true;
                oh-my-zsh = {
                  enable = true;
                  plugins = ["git"];
                  theme = "simple";
                };
                plugins = [
                  {
                    name = "powerlevel10k";
                    src = pkgs.zsh-powerlevel10k;
                    file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
                  }
                  {
                    name = "powerlevel10k-config";
                    src = lib.cleanSource ./config/zsh/p10k-config;
                    file = "p10k.zsh";
                  }
                ];
                initExtra =
                  ''
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
                extraConfig = builtins.concatStringsSep "\n" [
                  ''
                    luafile ${builtins.toString ./config/neovim/init_lua.lua}
                  ''
                ];
              };
              programs.git = {
                enable = true;
                userEmail = "anlarionov@gmail.com";
                userName = "Andrey \"MOU\" Larionov";
                signing = {
                  key = "5FF293FC94C01D6A";
                  signByDefault = true;
                };
                extraConfig = {
                  init = {
                    defaultBranch = "main";
                  };
                  rerere = {
                    enabled = true;
                  };
                };
              };
              programs.direnv = {
                enable = true;
                enableZshIntegration = true;
                nix-direnv.enable = true;
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
