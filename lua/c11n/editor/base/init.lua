--- Editor without plugins
local M = M(...)

M.keymaps = M.require("keymaps").keymaps
M.options = M.require("options").options

function M.init()
end

return M
