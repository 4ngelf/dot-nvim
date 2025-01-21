---@module c11n
--- # Base configuration module
---
--- This module contains the basic logic and data
--- to use the configuration without rocks dependencies. It also includes
--- the bootstraping code for rocks.nvim
local M = {}

local U = require("c11n.util")
local const = require("c11n.const")

function M.init() 
  -- Initialization
  U.initialize({
    "c11n.external",
    "c11n.editor"
  })

  if not const.use_rocks then 
    vim.notify("Rocks plugins are currently disabled")
  end
end

-- Allows checking that this configuration is loaded
if not vim.g.loaded_c11n then
  vim.g.loaded_c11n = true
end

return M
