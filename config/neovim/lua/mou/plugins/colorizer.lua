require('packer').use {
  'nvim-colorizer.lua',
  event = { 'BufRead', 'BufNewFile' },
  config = function()
    require('colorizer').setup(
      { '*' },
      {
        RGB = true,
        RRGGBB = true,
        names = false,
        RRGGBBAA = false,
        rgb_fn = false,
        hsl_fn = false,
        css = false,
        css_fn = false,
        mode = "background",
      })
  end
}
