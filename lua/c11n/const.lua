---Some constant data

local uv = vim.uv or vim.loop
local fn = vim.fn
local fs = vim.fs

local norocks_file = fs.joinpath(fn.stdpath("config"), "norocks")

local M = {}

---Current platform
M.platform = {
  ---Is Windows
  windows = fn.has("win64") == 1 or fn.has("win32") == 1,
  ---Is Unix-like
  unix = fn.has("linux") == 1 or fn.has("unix") == 1 or fn.has("wsl") == 1
}

---Whether to use rocks.nvim and rocks packages
M.use_rocks = uv.fs_stat(norocks_file) == nil

return M
