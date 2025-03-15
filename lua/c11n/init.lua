--- Initialization and utilities for configuration (c11n)
local M = {}

local util = require("c11n.util")
local did_init = false

---@type string
M.local_config_path = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "neovim.local.lua")

M.has = util.has

--- Common for `init()` and `fallback()`
local function prepare()
  did_init = true

  --- Load local machine configuration
  --- TIP: see lazy.events to execute code in different stages of the configuration
  local load_local = loadfile(M.local_config_path)
  if load_local then
    load_local()
  end

  -- Apply settings
  local settings = require("c11n.settings")
  vim.cmd.language(settings.language)
end

--- Initialize editor with fallback configuration
--- It just applies some things from c11n.settings and loads the config.basic.* modules
function M.fallback()
  if did_init then
    return
  end
  prepare()

  vim.notify("Running fallback configuration")

  local settings = require("c11n.settings")
  for plugin in ipairs(settings.disabled_plugins) do
    vim.g["loaded_" .. plugin] = true
  end

  local ok_color = pcall(vim.cmd.colorscheme, settings.colorscheme)
  if not ok_color then
    vim.cmd.colorscheme("habamax")
  end

  require("config.basic.options")
  require("config.basic.keymaps")
  require("config.basic.autocmds")
end

--- Initialize editor configuration
function M.init()
  if did_init then
    return
  end
  prepare()

  -- Load configuration for external tools
  require("lazy.core.util").lsmod("c11n.externals", function(modname, _)
    require(modname)
  end)

  -- Load management utilities
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function(_)
      require("c11n.manage").setup()
    end,
  })

  -- delegate to lazy.nvim
  require("c11n.lazy").setup()
end

return M
