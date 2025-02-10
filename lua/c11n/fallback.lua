--- Fallback when lazy is not available somehow
local M = {}

local try_require = function(mod)
  pcall(require, mod)
end

function M.init()
  try_require("config.options")
  try_require("config.keymaps")
  try_require("config.autocmds")
end

return M
