--- Utilities
local M = {}
M.data = require("c11n.util.data")
M.editor = require("c11n.util.editor")

--- Checks feature availability. Fallbacks to vim.fn.has()
---@return bool
function M.has(feature) 
  if feature == "lazy" then
    return require("c11n.lazy").using_lazy() and true or false
  else
    return vim.fn.has(feature) == 1
  end
end

--- Raises a notification
function M.notify(msg) 
  vim.api.nvim_echo(msg, true, {})
end

return M
