local lspconfig = require('lspconfig')
local handlers = require('mou.plugins.lsp.handlers')
handlers.setup()

local servers = { "pyright", "rust_analyzer" }

for _, server in ipairs(servers) do
  local old_on_attach = lspconfig[server].on_attach
  local opts = {
    on_attach = function(client, bufnr)
      if old_on_attach then
        old_on_attach(client, bufnr)
      end
      handlers.on_attach(client, bufnr)
    end,
    capabilities = vim.tbl_deep_extend("force", handlers.capabilities, lspconfig[server].capabilities or {}),
  }
  local present, overrides = pcall(require, "mou.plugins.lsp.server-settings." .. server)
  if present then
    opts = vim.tbl_deep_extend("force", overrides, opts)
  end

  lspconfig[server].setup(opts)
end
