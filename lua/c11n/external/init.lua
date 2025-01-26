---@module c11n-external
---Make adjustements for external programs
local M = M(...)
local U = require("c11n.util")
local C = require("c11n.const")

function M.init() 
  U.initialize({
    M.require("neovide"),
  })
end

return M
