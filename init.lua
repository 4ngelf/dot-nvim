--[[
--# Neovim configuration entry point.
--
--This tells nvim how to find and load the configuration.
--]]

local nvim_version = "nvim-0.10.0"
if vim.fn.has(nvim_version) == 0 then
  vim.notify("ERROR: This configuration needs at least " .. nvim_version .. " to work properly.", vim.log.levels.ERROR)
  return {}
end

vim.uv = vim.uv or vim.loop

--- Will raise an error to indicate unfinished code.
---@param msg? string Optional message to indicate context
---@return any
function todo(msg)
  msg = msg and ": " .. msg or ""
  error("Not yet implemented" .. msg, 0)
end

-- Initialize configuration (c11n)
require("c11n").init()
