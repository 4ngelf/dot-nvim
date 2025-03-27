--- Initialization and utilities for configuration (c11n)
local M = {}

local util = require("c11n.util")
local did_init = false

M.has = util.has

---@type string
M.local_config_path = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "neovim.local.lua")

--- Load local machine configuration.
local function load_local_config()
  local extend_settings = require("c11n.settings").extend
  local get_local_settings = loadfile(M.local_config_path)

  if get_local_settings then
    local local_settings = get_local_settings()
    local ok, error = pcall(extend_settings, local_settings)
    if not ok then
      util.on_user("VeryLazy", function(_)
        vim.notify(error, vim.log.levels.ERROR)
      end)
    end
  end
end

--- setup lazy.nvim
local function lazy_setup()
  local settings = require("c11n.settings").get()

  ---@type LazySpec
  local lazy_spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = settings.colorscheme,
        news = {
          lazyvim = true,
          neovim = true,
        },
      },
    },
    -- default basic configuration
    { import = "plugins._base" },
  }

  -- add selected preset
  if settings.preset then
    ---@diagnostic disable-next-line: param-type-mismatch
    table.insert(lazy_spec, { import = "plugins." .. settings.preset })
  end

  -- add selected preset
  if settings.lazyspec then
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.list_extend(lazy_spec, settings.lazyspec)
  end

  ---@type LazyConfig
  local lazy_config = {
    spec = lazy_spec,
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
  util.on_user("VeryLazy", function(_)
    require("c11n.manage").setup()
  end)

  lazy_setup()
end

return M
