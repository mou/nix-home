{
  pkgs,
  config,
  ...
}: let
  p = plugin: module: {optional ? false}: {
    inherit plugin optional;
    config =
      if builtins.stringLength module > 0
      then ''lua require("mou.plugins.${module}")''
      else "";
  };
  optional = {optional = true;};
in {
  programs.neovim = {
    enable = true;

    withPython3 = true;
    withRuby = true;
    withNodeJs = true;

    vimAlias = true;
    viAlias = true;

    extraPackages = with pkgs; [
      tree-sitter
      ripgrep
      
      nodePackages.pyright
      rust-analyzer
    ];
    plugins = with pkgs.vimPlugins; [
      tokyonight-nvim
      vim-nix
      # Packer
      (p packer-nvim "packer" {})
      # Libs
      (p plenary-nvim "plenary" {})
      (p popup-nvim "popup" {})
      (p nvim-notify "notify" {})
      (p nui-nvim "nui" optional)
      /*
         {
         plugin = lualine-nvim;
         config = "lua require(\"mou.plugins.lualine\")";
       }
       */
      # Treesitter
      (p nvim-treesitter "treesitter" optional)
      (p nvim-ts-autotag "ts_autotag" optional)
      (p nvim-ts-context-commentstring "ts_commentstring" optional)
      (p nvim-ts-rainbow "ts_rainbow" optional)
      # Buffer and status lines
      (p nvim-web-devicons "web_devicons" {})
      (p bufferline-nvim "bufferline" optional)
      # (p lualine-nvim "lualine" {})
      # Telescope
      (p telescope-nvim "telescope" optional)
      # Git
      (p gitsigns-nvim "gitsigns" optional)
      # LSP
      (p nvim-lspconfig "lspconfig" {})
      # Liniting
      (p null-ls-nvim "null_ls" optional)
      # Utils and small enchancements
      (p nvim-autopairs "autopairs" optional)
      (p vim-bbye "bbye" optional)
      (p better-escape-nvim "better_escape" optional)
      (p nvim-colorizer-lua "colorizer" optional)
      (p FixCursorHold-nvim "fixcursor" optional)
      # Completion
      (p friendly-snippets "friendly_snippets" {})
      (p luasnip "luasnip" {})
      (p nvim-cmp "cmp" optional)
      (p cmp_luasnip "cmp_luasnip" optional)
      (p cmp-buffer "cmp_buffer" optional)
      (p cmp-path "cmp_path" optional)
      # Neo Tree
      (p neo-tree-nvim "neotree" optional)
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
  home.file = {
    "${config.xdg.configHome}/nvim/parser/lua.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-lua}/parser";
    "${config.xdg.configHome}/nvim/parser/nix.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-nix}/parser";
    "${config.xdg.configHome}/nvim/parser/python.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-python}/parser";
    "${config.xdg.configHome}/nvim/parser/comment.so".source = "${pkgs.tree-sitter.builtGrammars.tree-sitter-comment}/parser";
  };
}
