--- # Base configuration module
---
--- This is the configuration module which makes all the magic work.
--- In code 'configuration' is abbreviated as 'c11n.'
local M = M(...)
local U = require("c11n.util")
local C = require("c11n.const")

local startup_notifications = {}

--- Get information about startup
---@return string[]
function M.startup_notifications()
  if #startup_notifications == 0 then
    if vim.env.NVIM_APPNAME then
      table.insert(
        startup_notifications,
        "Using alternative configuration: " .. vim.env.NVIM_APPNAME)
    end

    if not C.use_rocks then 
      table.insert(
        startup_notifications,
        "Rocks plugins are currently disabled")
    end
  end

  return startup_notifications
end

function M.init() 
  -- Initialization
  U.initialize({
    M.require("external"),
    M.require("rocks"),
    M.require("editor"),
  })

  vim.schedule(function()
    local notifications = M.startup_notifications()
    vim.notify(table.concat(notifications, "\n"))
  end)
end

return M
