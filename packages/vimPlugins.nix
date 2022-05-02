{ vimUtils, fetchFromGitHub }:
{
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
}
