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

-- Initialize configuration (c11n is an alias for 'configuration')
require("c11n").init()
