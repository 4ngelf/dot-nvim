--- Utilities
local M = {}

--- Checks feature availability. Fallbacks to vim.fn.has()
---@return bool
function M.has(feature)
  return vim.fn.has(feature) == 1
end

local function _make_logger(level, msg_prefix)
  return function(msg)
    if pcall(require, "lazy") then
      vim.notify(msg, level)
    else
      vim.api.nvim_echo({ msg_prefix, { " " }, { msg } }, true, {})
    end
  end
end

local _log = {
  debug = _make_logger(vim.log.levels.DEBUG, { " DEBUG ", "Visual" }),
  error = _make_logger(vim.log.levels.ERROR, { " ERROR ", "ErrorMsg" }),
  info = _make_logger(vim.log.levels.INFO, { " INFO ", "Visual" }),
  trace = _make_logger(vim.log.levels.TRACE, { " TRACE ", "Normal" }),
  warn = _make_logger(vim.log.levels.WARN, { " WARN ", "WarningMsg" }),
}

M.log = setmetatable(_log, {
  __call = function(log, msg)
    return log.info(msg)
  end,
})

--TODO: Turn this into information for :checkhealth
--
--- Notifications about nvim current state
-- M.run_notifications = vim.schedule_wrap(function()
--   messages = {}
--
--   if vim.env.NVIM_APPNAME then
--     table.insert(messages, {"Info: ", "Title"})
--     table.insert(messages, {("Using alternative configuration: %s\n"):format(vim.env.NVIM_APPNAME), "MsgArea"})
--   end
--
--   if not require("c11n.util").has("lazy") then
--     table.insert(messages, { "Warning: ", "WarningMsg"})
--     table.insert(messages, { "Lazy package manager is currently unused\n", "MsgArea"})
--   end
--
--   vim.api.nvim_echo(messages, true, {})
-- end)

--- Load first available colorscheme
---@param colors string|string[]|function
function M.load_colorscheme(colors)
  if type(colors) == "function" then
    colors()
    return
  end

  colors = type(colors) == "table" and colors or { colors }

  for _, color in ipairs(colors) do
    local ok, _ = pcall(vim.cmd.colorscheme, color)
    if ok then
      return
    end
  end
end

return M
