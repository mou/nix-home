require('packer').use {
  'cmp-path',
  after = 'nvim-cmp',
  config = function()
    require('mou.utils').add_cmp_source('path', 250)
  end
}
