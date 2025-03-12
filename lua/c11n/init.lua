--- Initialization and utilities for configuration (c11n)
local M = {}

local util = require("c11n.util")

---@type string
M.local_config_path = vim.fs.joinpath(vim.fn.stdpath("data"), "neovim.local.lua")

---@alias OS
---| "unknown"
---| "unix"
---| "termux"
---| "windows"
---| "wsl"

--- Current operating system
---@type OS
M.OS = "unknown"
if util.has("linux") or util.has("unix") then
  M.OS = "unix"
  if vim.uv.fs_stat("/data/data/com.termux/files") then
    M.OS = "termux"
  end
elseif util.has("win32") then
  M.OS = "windows"
elseif util.has("wsl") then
  M.OS = "wsl"
end

--- Initialize editor configuration
function M.init()
  --- Load local machine configuration
  --- TIP: see lazy.events to execute code in different stages of the configuration
  if vim.uv.fs_stat(local_config_path) then
    vim.cmd.source(local_config_path)
  end

  -- Apply settings
  local settings = require("c11n.settings")
  util.load_colorscheme(settings.colorscheme)
  vim.cmd.language(settings.language)

  -- Load all the plugins
  require("c11n.lazy").init()

  -- Load configuration for external tools
  require("externals").init()

  -- Load management utilities
  require("c11n.manage").init()
end

return M
