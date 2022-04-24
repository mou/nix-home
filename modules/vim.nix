{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraPackages = with pkgs; [
      tree-sitter
      ripgrep
    ];
    plugins = with pkgs.vimPlugins; [
      nvim-cmp
      cmp-buffer
      cmp-cmdline
      cmp-path
      tokyonight-nvim
      plenary-nvim
      popup-nvim
      telescope-nvim
      vim-nix
      vim-which-key
    ];
    extraConfig = builtins.concatStringsSep "\n" [
      ''
        luafile ${builtins.toString ../config/neovim/init_lua.lua}
      ''
    ];
  };
  xdg.configFile.nvim = {
    source = ../config/neovim;
    recursive = true;
  };
}
