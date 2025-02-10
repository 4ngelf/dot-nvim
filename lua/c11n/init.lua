--- Initialization and utilities.
--- In code 'configuration' is abbreviated as 'c11n'
local M = {}

local Const = require("c11n.const")
local Util = require("c11n.util")

--- Notifications about nvim current state
local run_notifications = vim.schedule_wrap(function()
  local notify = function(msg)
    vim.api.nvim_echo(msg, true, {})
  end

  if vim.env.NVIM_APPNAME then
    notify {
      {"Using alternative configuration: ", "MsgArea"},
      {vim.env.NVIM_APPNAME, "Title"}
    }
  end

  if not vim.g.c11n_lazy then
    notify {
      { "Warning: ", "WarningMsg"},
      { "Lazy and plugins loaded by Lazy are currently disabled", "MsgArea"}
    }
  end
end)

--- Initialization
function M.init() 
  require("c11n.external").init()

  local Lazy = require("c11n.lazy")
  -- Lazy.try_install()
  if Const.settings.use_lazy and true then
    -- Lazy.setup()
    vim.notify("did setup")
  else
    require("c11n.fallback").init()
  end

  Util.load_colorscheme(Const.settings.colorscheme)
  vim.cmd.language(Const.settings.language)

  run_notifications()
end

return M
