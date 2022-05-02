require('packer').use {
  'null-ls.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = function()
    require('null-ls').setup()
  end
}
