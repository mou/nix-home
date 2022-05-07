require('packer').use {
  'nvim-lspconfig',
  config = function()
    require('mou.plugins.lsp')
  end
}
