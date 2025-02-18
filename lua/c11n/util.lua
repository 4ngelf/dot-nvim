--- Utilities
local M = {}

--- Checks feature availability. Fallbacks to vim.fn.has()
---@return bool
function M.has(feature) 
  if feature == "lazy" then
    return require("c11n.lazy").status() == "ok"
  else
    return vim.fn.has(feature) == 1
  end
end

---Wraps any lua type into a table
---@param value any
---@param key? string Optional key for value in the table
---@return table wrapped Wrapped value
function M.tbl_wrap(value, key)
  if type(value) == "table" then
    return value
  elseif key ~= nil then
    return { [key] = value }
  else
    return { value }
  end
end

local function _make_logger(level, msg_prefix)
  return function(msg)
    if require("c11n.lazy").status() == "ok" then
      vim.notify(msg, level)
    else
      vim.api.nvim_echo({ msg_prefix, {" "}, { msg } }, true, {})
    end
  end
end

local _log = {
  debug = _make_logger(vim.log.levels.DEBUG, { " DEBUG ", "Visual" }),
  error = _make_logger(vim.log.levels.ERROR, { " ERROR ", "ErrorMsg" }),
  info  = _make_logger(vim.log.levels.INFO, { " INFO ", "Visual" }),
  trace = _make_logger(vim.log.levels.TRACE, { " TRACE ", "Normal" }),
  warn  = _make_logger(vim.log.levels.WARN, { " WARN ", "WarningMsg" }),
}

M.log = setmetatable(_log, {
  __call = function(t, msg) 
    return t.info(msg)
  end
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

  colors = M.tbl_wrap(colors)

  for _, color in ipairs(colors) do
    local ok, _ = pcall(vim.cmd.colorscheme, color)
    if ok then
      return 
    end
  end
end

return M
