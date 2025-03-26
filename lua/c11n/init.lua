--- Initialization and utilities for configuration (c11n)
local M = {}

local util = require("c11n.util")
local did_init = false

M.has = util.has

--- Load local machine configuration.
--- TIP: see `lazy.events` to execute code in different stages of the configuration
local function load_local_config()
  ---@type string
  local local_config_path = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "neovim.local.lua")

  local load_local = loadfile(M.local_config_path)
  if load_local then
    load_local()
  end
end

--- setup lazy.nvim
---@param c11n.Settings
local function lazy_setup(settings)
  ---@type LazyVimOptions
  ---@diagnostic disable-next-line: missing-fields
  local lazyvim_config = {
    colorscheme = settings.colorscheme,
    defaults = {
      autocmds = false,
    },
    news = {
      lazyvim = true,
      neovim = true,
    },
  }

  ---@type LazyConfig
  local lazy_config = {
    spec = {
      -- add LazyVim and import its plugins
      {
        "LazyVim/LazyVim",
        import = "lazyvim.plugins",
        opts = lazyvim_config,
      },

      -- add default plugins
      { import = "plugins.base" },
    },
    defaults = {
      lazy = false,
      version = false, -- always use the latest git commit
    },
    install = {
      colorscheme = { settings.colorscheme, "habamax" },
    },
    checker = {
      enabled = true, -- check for plugin updates periodically
      notify = true, -- notify on update
    },
    performance = {
      rtp = {
        -- disable some rtp plugins
        disabled_plugins = settings.disabled_plugins,
      },
    },
  }

  -- add selected preset
  if settings.preset then
    table.insert(lazy_config.spec, { import = "plugins." .. settings.preset })
  end

  require("lazy").setup(lazy_config)
end

--- Initialize configuration
function M.init()
  if did_init then
    return
  end
  did_init = true

  load_local_config()

  local settings = require("c11n.settings").get()

  local _ = pcall(vim.cmd.language, settings.language)

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

  lazy_setup(settings)
end

return M
