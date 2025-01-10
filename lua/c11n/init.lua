---# Base configuration module
---
---This module contains the basic logic and data
---to use the configuration without rocks dependencies. It also includes
---the bootstraping code for rocks.nvim
local M = {}

--require("c11n.rocks").ensure_rocks()

return M

--[[
local globals = vim.go
local defaults = require("editor.defaults")

local M = {}

function M.apply_defaults ()
    for option, default in pairs(defaults.GLOBAL_OPTIONS) do
	    globals[option] = default
    end

end

return M
]]

--[[ Previous contents of defaults.lua:
-- This configuration defaults

local fn = vim.fn

local M = {}

M.GLOBAL_OPTIONS = {
    shell = fn.has("win32") and fn.exepath("cmd.exe") or fn.exepath("bash")
}

return M
]]
