--- Make adjustements for external programs
local M = {}

---@type string[]
local externals = {
  "neovide",
}

function M.init() 
  table.foreach(externals, function(_, external) 
    require("c11n.external."..external).init()
  end)
end

return M
