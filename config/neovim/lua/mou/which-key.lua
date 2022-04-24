local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<leader>", ":<c-u>WhichKey '<Space>'<CR>", opts)
keymap("", "<localleader>", ":<c-u>WhichKey  ','<CR>", opts)
