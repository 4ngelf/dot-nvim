--- Make adjustements for external programs
local M = M(...)

---@type string[]
local externals = {
  "neovide",
}

function M.init() 
  table.foreach(externals, function(_, external) 
    M.require(external).init()
  end)
end

return M
