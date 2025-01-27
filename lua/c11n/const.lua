--- Constant information about the current neovim instance
local M = M(...)

local fn = vim.fn
local k = vim.keycode

---Whether a feature is available
---@param feature string Feature to check
---@return bool
local function feat(feature)
  return fn.has(feature) == 1
end

---@class c11n.Settings
local DEFAULT_SETTINGS = {
  --- Preferred colorscheme. Priority from left to right.
  ---@type string[]
  colorscheme = {
    "catppuccin-frappe",
    "catppuccin",
    "habamax",
    "default"
  },
  ---@type string
  language = "en_US",
  ---@type string
  mapleader = vim.keycode "<Space>",
  ---@type string
  maplocalleader = vim.keycode "<BS>",
  --- Uses treesitter folding. If not available or false, use "marker"
  ---@type bool
  treesitter_folding = true,
  --- Whether rocks.nvim and rocks packages should be used
  ---@type bool
  use_rocks = true,
}

---@class c11n.UserSettings
---@field colorscheme? string[]
---@field language? string
---@field mapleader? string
---@field maplocalleader? string
---@field treesitter_folding? bool
M.settings = vim.tbl_deep_extend("force", {}, DEFAULT_SETTINGS, vim.g.c11n_settings or {})

---Current platform
M.platform = {
  ---Is Unix-like
  unix = feat("linux") or feat("unix"),
  ---Is Windows
  windows = feat("win64") or feat("win32"),
  ---Is Windows but it is wsl
  wsl = feat("wsl"),
}

-- Give priority if vim.env.NO_ROCKS is defined
if vim.env.NO_ROCKS ~= nil then
  M.settings.use_rocks = false
end

-- shorcut to M.settings.use_rocks
M.use_rocks = M.settings.use_rocks

return M
