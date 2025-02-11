--- Initialization and utilities.
--- In code 'configuration' is abbreviated as 'c11n'
local M = {}

local Const = require("c11n.const")
local Util = require("c11n.util")

--- Initialization
function M.init() 
  local Lazy = require("c11n.lazy")

  if Lazy.status() == "ok" then
    Lazy.setup()
  else
    require("c11n.fallback").init()
  end

  Util.editor.load_colorscheme(Const.settings.colorscheme)
  vim.cmd.language(Const.settings.language)

  Util.editor.run_notifications()

  require('c11n.command').init()
end

return M
