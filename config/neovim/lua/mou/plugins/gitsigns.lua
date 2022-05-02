require('packer').use {
  'gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "契" },
        changedelete = { text = "▎" },
      },
    }
  end,
  setup = function()
    vim.defer_fn(function()
      require('packer').loader('gitsigns.nvim')
    end, 0)
  end,
}
