-- This is the editor module
-- This later will be core of the configuration. And have functions
-- to modify features, initialize the configuration and apply defaults.

return {}

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
