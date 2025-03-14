--- Initialization and utilities for configuration (c11n)
local M = {}

local util = require("c11n.util")

---@type string
M.local_config_path = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "neovim.local.lua")

M.has = util.has

--- Initialize editor configuration
function M.init()
  --- Load local machine configuration
  --- TIP: see lazy.events to execute code in different stages of the configuration
  local load_local = loadfile(M.local_config_path)
  if load_local then
    load_local()
  end

  -- Apply settings
  local settings = require("c11n.settings")
  vim.cmd.language(settings.language)

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
