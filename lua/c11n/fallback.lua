--- Fallback when lazy is not available somehow
local M = {}

function M.init()
  require("c11n.util").log "using fallback implementation"

  for _, plugin in ipairs(require("c11n.settings").disabled_plugins) do
    vim.g["loaded_"..plugin] = true
  end

  require("config.options")
  require("config.keymaps")
  require("config.autocmds")
end

return M
