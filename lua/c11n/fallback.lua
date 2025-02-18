--- Fallback when lazy is not available somehow
local M = {}

function M.init()
  vim.api.nvim_echo({
    {"Using fallback implementation. You can install lazyvim with :C11n install_lazy"}
  }, true, {})

  for _, plugin in ipairs(require("c11n.settings").disabled_plugins) do
    vim.g["loaded_"..plugin] = true
  end

  require("config.options")
  require("config.keymaps")
  require("config.autocmds")
end

return M
