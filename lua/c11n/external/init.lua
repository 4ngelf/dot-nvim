---@module c11n-external
---Make adjustements for external programs
local M = {}

local U = require("c11n.util")

function M.init() 
  U.initialize({
    "c11n.external.neovide"
  })
end

return M
