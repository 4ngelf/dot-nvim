---@class c11n.Settings
local DEFAULT_SETTINGS = {
  --- Preferred colorscheme. Priority from left to right.
  ---@type string[]|function
  colorscheme = {
    "catppuccin",
    "habamax",
    "default",
  },

  ---@type string
  language = "en_US",

  ---@type number
  highlight_on_yank_timeout = 1000,

  ---@type string[]
  disabled_plugins = {
    "gzip",
    -- "matchit",
    -- "matchparen",
    -- "netrwPlugin",
    "tarPlugin",
    "tohtml",
    -- "tutor",
    "zipPlugin",
  },

  ---@alias Provider
  ---| "python"
  ---| "node"
  ---| "ruby"
  ---| "perl"
  ---| "clipboard"

  ---@type Provider[]
  install_providers = {},
}

---@class c11n.UserSettings
---@field colorscheme? string[]|function
---@field language? string
---@field disabled_plugins? string[]
---@field install_providers? Provider[]

---@type c11n.UserSettings
vim.g.c11n_settings = type(vim.g.c11n_settings) == "table" and vim.g.c11n_settings or {}

---@type c11n.Settings
local effective_settings = vim.tbl_deep_extend("force", DEFAULT_SETTINGS, vim.g.c11n_settings)
return effective_settings
