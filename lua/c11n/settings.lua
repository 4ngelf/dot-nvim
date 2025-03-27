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

  ---@type LazySpec
  lazyspec = nil,
}

--- Get value of `vim.g.c11n_settings` if it is valid.
---@return table
local function get_user_settings()
  local user = vim.g.c11n_settings
  if type(user) ~= "table" then
    return {}
  end

  local is_valid, error = pcall(vim.validate, {
    colorsheme = { user.colorscheme, "string", true },
    language = { user.language, "string", true },
    highlight_on_yank_timeout = { user.highlight_on_yank_timeout, "number", true },
    disabled_plugins = { user.disabled_plugins, "table", true },
    preset = { user.preset, "string", true },
    lazyspec = { user.lazyspec, "table", true },
  })

  if is_valid then
    return user
  else
    vim.notify(error, vim.log.levels.ERROR)
    return {}
  end
end

--- Get current settings
---@return c11n.Settings
function M.get()
  local user_settings = get_user_settings()
  return vim.tbl_deep_extend("force", DEFAULT_SETTINGS, user_settings --[[@as c11n.Settings]])
end

return M
