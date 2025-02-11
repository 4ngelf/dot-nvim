--- Fallback when lazy is not available somehow
local M = {}

function M.init()
  vim.api.nvim_echo({
    {"Using fallback implementation. You can install lazyvim with :C11n install_lazy"}
  }, true, {})

  require("config.options")
  require("config.keymaps")
  require("config.autocmds")
end

return M
