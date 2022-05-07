require('packer').use {
  'cmp-nvim-lsp',
  after = 'nvim-cmp',
  config = function()
    require('mou.utils').add_cmp_source('nvim_lsp', 1000)
  end
}
