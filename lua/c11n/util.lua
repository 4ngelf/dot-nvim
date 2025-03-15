--- Utilities
local M = {}

---@alias c11n.Feature
---| "windows"
---| "termux"
---| "neovide"
---| "lazy"
---| any

--- Checks feature availability. Extends vim.fn.has()
---@param feature c11n.Feature
---@return bool
function M.has(feature)
  local has = vim.fn.has
  if feature == "windows" then
    return has("win32") == 1 or has("win64") == 1
  elseif feature == "termux" then
    return vim.uv.fs_stat("/data/data/com.termux/files") ~= nil
  elseif feature == "neovide" then
    return vim.g.neovide ~= nil
  elseif feature == "lazy" then
    return package.loaded["lazy"] ~= nil
  else
    return has(feature) == 1
  end
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

--- vim.keymap.set wrapper
--- the third argument can be just a string to put the description
--- Example:
---   keymap.n(...) -- set normal
---   keymap.nv(...) -- set normal and visual
---   keymap.tci(...) -- set terminal, command and insert
---   keymap.nicvxsotl(...) -- Set in all modes
M.keymap = setmetatable({}, {
  __tostring = function(_)
    return "vim.keymap.set"
  end,
  __index = function(_, mode)
    mode = vim.split(mode, "")

    -- ---@type fun(lhs: string, rhs:string|fun(), desc_or_opts: vim.keymap.set.Opts | string)
    ---@param lhs string
    ---@param rhs string | fun()
    ---@param desc_or_opts string | vim.keymap.set.Opts
    return function(lhs, rhs, desc_or_opts)
      if type(desc_or_opts) == "string" then
        desc_or_opts = { desc = desc_or_opts }
      end

      vim.keymap.set(mode, lhs, rhs, desc_or_opts)
    end
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

return M
