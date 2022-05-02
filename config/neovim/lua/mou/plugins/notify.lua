require('packer').use {
  'nvim-notify',
  config = function() 
    local plugin_config = {
      stages = "fade",
    }
    local notify = require('notify')
    notify.setup(plugin_config)
    vim.notify = notify
  end
}
