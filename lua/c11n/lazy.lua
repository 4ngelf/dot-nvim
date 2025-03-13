--- lazy.nvim package manager setup
local M = {}

---@type string
local LAZY_REPO = "https://github.com/folke/lazy.nvim.git"

---@type string
local LAZY_PATH = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "lazy", "lazy.nvim")

---@type LazyConfig
local LAZY_CONFIG = {
  spec = {
    -- add LazyVim and import its plugins
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = {
        colorscheme = require("c11n.settings").colorscheme,
        defaults = {
          autocmds = false,
        },
      },
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

local did_init = false
--- Tries to initialize and setup lazy.nvim
function M.init()
  if did_init then
    return
  end
  did_init = true

  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", LAZY_REPO, LAZY_PATH })
  if vim.v.shell_error ~= 0 then
    require("c11n.util").log.error("Failed to clone lazy.nvim")
    return
  end
  vim.opt.runtimepath:prepend(LAZY_PATH)

  require("lazy").setup(LAZY_CONFIG)
end

return M
