local M = {}

---@module "lazy"

--- Settings for configuration (c11n)
---@class (exact) c11n.Settings
---
--- Preferred colorscheme
---@field colorscheme string?
---
--- Sets language locale. Default: "en_US.utf-8"
---@field language string?
---
--- Highlight on yank timeout
---@field highlight_on_yank_timeout number?
---
--- Disabled built-in plugins
---@field disabled_plugins string[]?
---
--- Custom preset of plugin configuration to use
---@field preset string?
---
--- LazySpec to inject to lazy.nvim after importing all plugins.
---@field lazyspec LazySpec?
local _settings = {
  colorscheme = "catppuccin-macchiato",
  language = "en_US.utf-8",
  highlight_on_yank_timeout = 1000,
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
  preset = nil,
  lazyspec = nil,
}

--- Validates and merge settings on current settings
---@param settings c11n.Settings
function M.extend(settings)
  vim.validate({
    ["settings"] = { settings, "table" },
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
