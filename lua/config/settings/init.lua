--- Make adjustements for some events
local M = {}

---@type string[]
local externals = {
  "neovim",
  "neovide",
  "localconfig"
}

function M.init() 
  table.foreach(externals, function(_, external) 
    require("config.settings."..external)
  end)
end

return M
