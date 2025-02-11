--- Editor related utilities
local M = {}
local Data = require("c11n.util.data")

--- Notifications about nvim current state
M.run_notifications = vim.schedule_wrap(function()
  messages = {}

  if vim.env.NVIM_APPNAME then
    table.insert(messages, {"Info: ", "Title"})
    table.insert(messages, {("Using alternative configuration: %s\n"):format(vim.env.NVIM_APPNAME), "MsgArea"})
  end

  if not require("c11n.util").has("lazy") then
    table.insert(messages, { "Warning: ", "WarningMsg"})
    table.insert(messages, { "Lazy package manager is currently unused\n", "MsgArea"})
  end

  vim.api.nvim_echo(messages, true, {})
end)

--- Load first available colorscheme
---@param colors string|string[]|function
function M.load_colorscheme(colors)
  if type(colors) == "function" then
    colors()
    return
  end

  colors = Data.tbl_wrap(colors)

  for _, color in ipairs(colors) do
    local ok, _ = pcall(vim.cmd.colorscheme, color)
    if ok then
      return 
    end
  end
end

return M
