--- # Base configuration module
---
--- This is the configuration module which makes all the magic work.
--- In code 'configuration' is abbreviated as 'c11n.'
local M = {}

local U = require("c11n.util")
local const = require("c11n.const")

--Re-exports
M.notify = U.notify

local function notify_relevant()
  if vim.env.NVIM_APPNAME then
    M.notify("Using alternative configuration: " .. vim.env.NVIM_APPNAME)
  end

  if not const.use_rocks then 
    M.notify("Rocks plugins are currently disabled")
  end
end

function M.init() 
  -- Initialization
  U.initialize({
    "c11n.external",
    "c11n.editor"
  })

  vim.schedule(notify_relevant)
end

-- Allows checking that this configuration is loaded
if not vim.g.loaded_c11n then
  vim.g.loaded_c11n = true
end

return M
