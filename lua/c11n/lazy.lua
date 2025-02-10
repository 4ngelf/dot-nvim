--- lazy.nvim package manager initialization routines
local M = {}

local Const = require("c11n.const")

---@type string
local LAZY_REPO = "https://github.com/folke/lazy.nvim.git"

---@type string
local LAZY_PATH = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")

---@type LazyConfig
local LAZY_CONFIG = {
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
  },
  install = { colorscheme = Const.settings.colorscheme },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = true, -- notify on update
  }, 
  performance = {
    rtp = {
      -- disable some rtp plugins
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
    },
  },
}

--- Tries to installs lazy.nvim and add it to the runtime path.
---@return bool success
function M.try_install()
  if not (vim.uv or vim.loop).fs_stat(LAZY_PATH) then
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", LAZY_REPO, LAZY_PATH })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})

      return false
    end
  end

  if not vim.tbl_contains(vim.opt.rtp:get(), LAZY_PATH) then
    vim.opt.runtimepath:prepend(LAZY_PATH)
  end

  return true
end

--- Setups and starts lazy
function M.setup()
  require("lazy").setup(LAZY_CONFIG)
  vim.go.c11n_lazy = true
end

return M
