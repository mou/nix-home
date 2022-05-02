local function find_pack_path(suffix)                                                                                                                                       
  for _, path in pairs(vim.opt.pp:get()) do
    if path:sub(-#suffix) == suffix then
      return path
    end
  end
  return false
end

local util = require 'packer.util'
local packer = require 'packer'
packer.init({
  ensure_dependencies = false,
  plugin_package = "home-manager",
  package_root = util.join_paths(find_pack_path("vim-pack-dir"), "pack"),
  disable_commands = true,
})
packer.reset()
