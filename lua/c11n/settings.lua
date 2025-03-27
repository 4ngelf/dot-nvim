local M = {}

---@class c11n.Settings
local _settings = {
  --- Preferred colorscheme
  ---@type string?
  colorscheme = "catppuccin-macchiato",

  ---@type string?
  language = "en_US.utf-8",

  ---@type number?
  highlight_on_yank_timeout = 1000,

  ---@type string[]?
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

  ---@type LazySpec?
  lazyspec = nil,
}

--- Validates and merge settings on current settings
---@param settings C11n.Settings
function M.extend(settings)
  vim.validate({
    ["settings"] = { settings, "table" }
  })
  vim.validate({
    ["settings.colorsheme"] = { settings.colorscheme, "string", true },
    ["settings.language"] = { settings.language, "string", true },
    ["settings.highlight_on_yank_timeout"] = { settings.highlight_on_yank_timeout, "number", true },
    ["settings.disabled_plugins"] = { settings.disabled_plugins, "table", true },
    ["settings.preset"] = { settings.preset, "string", true },
    ["settings.lazyspec"] = { settings.lazyspec, "table", true },
  })

  _settings = vim.tbl_deep_extend("force", _settings, settings)
end

--- Get current settings
---@return c11n.Settings
function M.get()
  return _settings
end

return M
