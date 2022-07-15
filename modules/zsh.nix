{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = ["git" "gcloud" "kubectl" "helm" "aws"];
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
        src = lib.cleanSource ../config/zsh/p10k-config;
        file = "p10k.zsh";
      }
    ];
    initExtra = ''
      source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      export NIX_PATH=''${NIX_PATH:+$NIX_PATH:}''$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
      export PATH=''${PATH}:''$HOME/.local/bin
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        source ~/.nix-profile/etc/profile.d/nix.sh
      fi
      source ''$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      export SSH_AUTH_SOCK=''$(gpgconf --list-dirs agent-ssh-socket)
    '';
  };
}
