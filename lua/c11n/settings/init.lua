---@class c11n.settings
--- Settings for c11n
local M = M(...)

---@return c11n.Settings
local function defaults()
  local s = M.require("default").DEFAULT_SETTINGS
  return vim.deepcopy(s, true)
end

return M
