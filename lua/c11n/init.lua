--- Initialization and utilities for configuration (c11n)
local M = {}

local Util = require("c11n.util")

--- Current platform
M.OS = "unknown"
if Util.has("linux") or Util.has("unix") then
  M.OS = "unix"
elseif Util.has("win32") then
  M.OS = "windows"
elseif Util.has("wsl") then
  M.OS = "wsl"
end

--- Initialize editor configuration
function M.init() 
  local Lazy = require("c11n.lazy")
  local Settings = require("c11n.settings")

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
