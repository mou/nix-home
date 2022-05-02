require('packer').use {
  'better-escape.nvim',
  event = 'InsertEnter',
  config = function()
    local config = {
      mapping = { "ii", "jj", "jk", "kj" },
      timeout = vim.o.timeoutlen,
      keys = "<ESC>",
    }

    require("better_escape").setup(config)
  end
}
