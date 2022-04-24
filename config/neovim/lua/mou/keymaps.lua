local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("", "<Space>", "<Nop>", opts)
-- Leader is Space
vim.g.mapleader = " "
-- Local leader is coma
vim.g.maplocalleader = ","
