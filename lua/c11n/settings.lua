local M = {}

---@class c11n.Settings
local DEFAULT_SETTINGS = {
  --- Preferred colorscheme
  ---@type string
  colorscheme = "catppuccin-macchiato",

  ---@type string
  language = "en_US.utf-8",

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

  ---@type string?
  preset = nil,
}

--- Get value of `vim.g.c11n_settings` if it is valid.
---@return c11n.Settings?
local function get_user_settings()
  local user = vim.g.c11n_settings
  local is_valid, error = pcall(vim.validate, {
    colorsheme = { user.colorscheme, "string" },
    language = { user.language, "string" },
    highlight_on_yank_timeout = { user.highlight_on_yank_timeout, "number" },
    disabled_plugins = { user.disabled_plugins, "table" },
    preset = { user.preset, { "string", "nil" } },
  })

  if is_valid then
    ---@cast user c11n.Settings
    return user
  else
    vim.notify(error, vim.log.levels.ERROR)
    return nil
  end
end

--- Get current settings
---@return c11n.Settings
function M.get()
  local user_settings = get_user_settings() or {}
  return vim.tbl_deep_extend("force", DEFAULT_SETTINGS, user_settings)
end

return M
