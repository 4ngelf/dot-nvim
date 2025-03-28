--
-- Neovim configuration
--

local nvim_version = "0.10.0"
if vim.fn.has("nvim-" .. nvim_version) ~= 1 then
  vim.notify("neovim version required: >=" .. nvim_version, vim.log.levels.ERROR)
  return
end

--
-- Get lazy.nvim
--

---@type string
local LAZY_PATH = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "lazy", "lazy.nvim")

if not vim.uv.fs_stat(LAZY_PATH) then
  local result = vim
    .system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      LAZY_PATH,
    }, {
      stdout = false,
      stderr = false,
    })
    :wait()

  if result.code ~= 0 then
    vim.notify("couldn't clone lazy.nvim", vim.log.levels.ERROR)
    return
  end
end

vim.opt.runtimepath:prepend(LAZY_PATH)

if not pcall(require, "lazy") then
  vim.notify("lazy.nvim is broken. Try erasing " .. LAZY_PATH, vim.log.levels.ERROR)
  return
end

local c11n = require("c11n")

--
-- Load configuration for external tools
--

require("lazy.core.util").lsmod("c11n.externals", function(modname, _)
  require(modname)
end)

--
-- Load management utilities
--

c11n.on_user("VeryLazy", function(_)
  require("c11n.manage").setup()
end)

--
-- Apply settings
--

local get_local_settings = loadfile(c11n.local_config_path)
if get_local_settings then
  local local_settings = get_local_settings()

  local ok, error = pcall(c11n.settings.extend, local_settings)
  if not ok then
    c11n.on_user("VeryLazy", function(_)
      vim.notify(error, vim.log.levels.ERROR)
    end)
  end
end

local settings = c11n.settings.get()

-- Language
local _ = pcall(vim.cmd.language, settings.language)

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

--
-- Setup
--

require("lazy").setup(lazy_config)

-- Initialization end
