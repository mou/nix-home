{
  vimUtils,
  fetchFromGitHub,
}: {
  neo-tree-nvim = vimUtils.buildVimPluginFrom2Nix {
    pname = "neo-tree.nvim";
    version = "2.21";
    src = fetchFromGitHub {
      owner = "nvim-neo-tree";
      repo = "neo-tree.nvim";
      rev = "v2.21";
      sha256 = "sha256-UbnEVgDWf23xskIqgXrz/hUdtzv0mglicSW/uuCAHF8=";
    };

    meta.homepage = "https://github.com/nvim-neo-tree/neo-tree.nvim";
  };
  nvim-lsp-installer = vimUtils.buildVimPluginFrom2Nix {
      pname = "nvim-lsp-installer";
      version = "20220507";
      src = fetchFromGitHub {
          owner = "williamboman";
          repo = "nvim-lsp-installer";
          rev = "6f82a174709c2767281916d02e2cac1d7a6dba6e";
          sha256 = "sha256-zEkpTOHNN+CSgzNpJg+hY5XicMw7zresN0RhmzlFzcE=";
      };

      meta.homepage = "https://github.com/williamboman/nvim-lsp-installer";
        };
}
