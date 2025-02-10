--- Constant information about the current neovim instance
local M = {}

local has = require("c11n.util").has

---@class c11n.Settings
local DEFAULT_SETTINGS = {
  --- Preferred colorscheme. Priority from left to right.
  ---@type string[]|function
  colorscheme = {
    "catppuccin-frappe",
    "catppuccin",
    "habamax",
    "default"
  },
  ---@type string
  language = "en_US",
  --- Whether lazy and plugins loaded by it
  ---@type bool
  use_lazy = true,
}

---@class c11n.UserSettings
---@field colorscheme? string[]|function
---@field language? string
M.settings = vim.tbl_deep_extend("force", {}, DEFAULT_SETTINGS, vim.g.c11n_settings or {})

--- Current platform
M.platform = {
  ---Is Unix-like
  unix = has("linux") or has("unix"),
  ---Is Windows
  windows = has("win64") or has("win32"),
  ---Is Windows but it is wsl
  wsl = has("wsl"),
}

-- Give priority if vim.env.NO_ROCKS is defined
if vim.env.NO_LAZY ~= nil then
  M.settings.use_lazy = false
end

return M
