---@module c11n.const
---Constant information about the current neovim instance
local M = M(...)
local U = require("c11n.util")

local uv = vim.uv or vim.loop
local fn = vim.fn
local fs = vim.fs

---If this file exists, neovim will ignore rocks plugins
local NOROCKS_FILE = fs.joinpath(fn.stdpath("config"), "norocks")

---Whether a feature is available
---@param feature string Feature to check
---@return bool
local function feat(feature)
  return fn.has(feature) == 1
end

---Current platform
M.platform = {
  ---Is Unix-like
  unix = feat("linux") or feat("unix"),
  ---Is Windows
  windows = feat("win64") or feat("win32"),
  ---Is Windows but it is wsl
  wsl = feat("wsl"),
}

---Whether to use rocks.nvim and rocks packages
M.use_rocks = (uv.fs_stat(NOROCKS_FILE) == nil and vim.env.NO_ROCKS == nil)

return M
