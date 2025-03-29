--- Initialization and utilities for configuration (c11n)
local M = {}

M.util = require("c11n.util")
M.has = M.util.has
M.on_user = M.util.on_user

M.settings = require("c11n.settings")

---@type string
M.local_config_path = vim.fn.stdpath("data") .. "/c11n.local.lua"

return M
