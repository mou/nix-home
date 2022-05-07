require('packer').use {
  'nvim-lsp-installer',
  after = 'nvim-lspconfig',
  config = function()
    require('nvim-lsp-installer').setup()
    require('mou.plugins.lsp')
  end
}
