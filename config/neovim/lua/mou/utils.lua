local M = {}

function M.add_cmp_source(source, priority)
  local cmp = require('cmp')
  local config = cmp.get_config()
  table.insert(config.sources, { name = source, priority = priority })
  cmp.setup(config)
end

return M
