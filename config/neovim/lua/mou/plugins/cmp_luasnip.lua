require('packer').use {
  'cmp_luasnip',
  after = 'nvim-cmp',
  config = function()
    require('mou.utils').add_cmp_source('luasnip', 750)
  end
}
