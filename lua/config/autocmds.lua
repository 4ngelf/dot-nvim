-- Autocommands
-- Much of them are copied from default autocmds from lazynvim
require("config.basic.autocmds")

---@diagnostic disable-next-line: unused-local, unused-function
local function augroup(name)
  return vim.api.nvim_create_augroup("c11n_" .. name, { clear = true })
end
