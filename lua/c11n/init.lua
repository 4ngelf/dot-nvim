--- Initialization and utilities for configuration (c11n)
local M = {}

--- Initialize editor configuration
function M.init() 
  local Lazy = require("c11n.lazy")
  local Settings = require("c11n.settings")
  local Util = require("c11n.util")

  -- Try to setup lazyvim
  if Lazy.status() == "ok" then
    Lazy.setup()
  else
    require("c11n.fallback").init()
  end

  -- Apply settings
  Util.load_colorscheme(Settings.colorscheme)
  vim.cmd.language(Settings.language)

  -- Load management utilities
  require('c11n.management').init()
end

return M
