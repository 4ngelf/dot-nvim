local M = {}

---@type string[]
local externals = {
  "neovide",
  "localconfig",
}

function M.init() 
  table.foreach(externals, function(_, external) 
    require("config.extern."..external)
  end)
end

return M
