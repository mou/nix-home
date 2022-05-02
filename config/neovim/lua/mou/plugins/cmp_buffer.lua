require('packer').use {
  'cmp-buffer',
  after = 'nvim-cmp',
  config = function()
    require('mou.utils').add_cmp_source('buffer', 500)
  end
}
