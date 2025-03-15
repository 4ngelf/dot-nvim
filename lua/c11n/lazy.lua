--- lazy.nvim package manager setup
local M = {}

---@type LazyVimOptions
---@diagnostic disable-next-line: missing-fields
local LAZYVIM_CONFIG = {
  colorscheme = require("c11n.settings").colorscheme,
  defaults = {
    autocmds = false,
  },
  news = {
    lazyvim = true,
    neovim = true,
  },
}

---@type LazyConfig
local LAZY_CONFIG = {
  spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = LAZYVIM_CONFIG,
    },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = {
    colorscheme = { require("c11n.settings").colorscheme, "habamax" },
  },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = true, -- notify on update
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = require("c11n.settings").disabled_plugins,
    },
  },
}

--- setup lazy.nvim
function M.setup()
  require("lazy").setup(LAZY_CONFIG)
end

return M
