local M = {}

-- TODO: nvim_get_runtime_file()?
---@type string[]
local externals = {
  "windows",
  "neovide",
}

function M.init()
  table.foreach(externals, function(_, external)
    require("externals." .. external)
  end)
end

return M
