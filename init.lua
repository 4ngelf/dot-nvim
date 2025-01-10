--[[
--# Neovim configuration entry point.
--
--This is but a guard to ensure the current neovim session
--fullfills the runtime requirements and to notify the user
--information about the current session.
--]]


-- Runtime dependencies
nvim_version = "nvim-0.10.0"
if vim.fn.has(nvim_version) == 0 then
  vim.notify("ERROR: This configuration needs at least " .. nvim_version .. " to work properly.", vim.log.levels.ERROR)
  return {}
end

local function check(program) 
  if vim.fn.executable(program) == 0 then
    vim.notify("ERROR: "..program.." is not installed", vim.log.levels.ERROR)
    return false
  end
  return true
end

assert(check("git"))
assert(check("lua") or check("luajit"))
assert(check("luarocks"))


-- Run after vim initialization
vim.schedule(function()
  if vim.env.NVIM_APPNAME then
    vim.notify("Using alternative configuration: " .. vim.env.NVIM_APPNAME)
  end
end)


-- Actual configuration (c11n is an alias for 'configuration')
require("c11n")
