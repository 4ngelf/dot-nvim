local M = {}

---@type string[]
local externals = {
  "windows",
  "neovide",
  "localconfig",
}

function M.init() 
  table.foreach(externals, function(_, external) 
    require("config.extern."..external)
  end)
end

return M
