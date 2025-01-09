--[[
--# Neovim configuration entry point.
--
--This is but a guard to ensure the current neovim session
--fullfills the runtime requirements and to notify the user
--information about the current session.
--]]

nvim_version = "nvim-0.10.0"
if vim.fn.has(nvim_version) == 0 then
    vim.notify(
        "ERROR: This configuration needs at least "..nvim_version.." to work properly.",
        vim.log.levels.ERROR
    )
    return {}
end

-- Run after vim initialization
vim.schedule(function() 
    if vim.env.NVIM_APPNAME then
        vim.notify("Currently using alternative configuration: "..vim.env.NVIM_APPNAME)
    end
end)

require("c11n") -- Alias for 'configuration'
