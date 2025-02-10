--- Utilities
local M = {}
M.data = require("c11n.util.data")

--- Checks feature availability. Fallbacks to vim.fn.has()
---@return bool
function M.has(feature) 
  if feature == "lazy" then
    return vim.g.c11n_lazy and true or false
  else
    return vim.fn.has(feature) == 1
  end
end

--- Load first available colorscheme
---@param colors string|string[]|function
function M.load_colorscheme(colors)
  if type(colors) == "function" then
    colors()
    return
  end

  colors = M.data.tbl_wrap(colors)

  for _, color in ipairs(colors) do
    local ok, _ = pcall(vim.fn.colorscheme, color)
    if ok then
      return 
    end
  end
end

return M
