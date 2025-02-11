--- Editor related utilities
local M = {}

--- Notifications about nvim current state
M.run_notifications = vim.schedule_wrap(function()
  messages = {}

  if vim.env.NVIM_APPNAME then
    table.insert(messages, {"Info: ", "Title"})
    table.insert(messages, {"Using alternative configuration: ", "MsgArea"})
    table.insert(messages, {vim.env.NVIM_APPNAME.."\n", "Title"})
  end

  if not require("c11n.lazy").using_lazy() then
    table.insert(messages, { "Warning: ", "WarningMsg"})
    table.insert(messages, { "Lazy package manager is currently disabled\n", "MsgArea"})
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

  colors = require("c11n.util").data.tbl_wrap(colors)

  for _, color in ipairs(colors) do
    local ok, _ = pcall(vim.cmd.colorscheme, color)
    if ok then
      return 
    end
  end
end

return M
