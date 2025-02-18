--- Management for editor
local M = {}
local log = require("c11n.util").log

---@class c11n.CommandDefinition
---@field callback string|fun(opts: table)
---@field complete? string|string[]|fun(lead: string, args: string[], position: number):string[]
---@field desc? string

---@type table<string, c11n.CommandDefinition>
local SUBCOMMANDS = {}

--- Register a command for :C11n. It replaces old commands if given
--- a name that already exists
---@param name string subcommand
---@param cmd c11n.CommandDefinition callbacks
function M.register_command(name, cmd)
  SUBCOMMANDS[name] = cmd
end

---@param opts table
local function main_command(opts)
  if #opts.fargs == 0 then
    local subcommands = vim.iter(vim.tbl_keys(SUBCOMMANDS))
    subcommands = subcommands:map(function(cmd) return (" [%s] %s"):format(cmd, SUBCOMMANDS[cmd].desc or "") end)
    subcommands = subcommands:join("\n")
    if subcommands ~= "" then
      log("Available commands:\n"..subcommands)
    else
      log.error("No commands available")
    end
    return
  end

  local name = opts.fargs[1]
  opts.fargs = vim.list_slice(opts.fargs, 2, #opts.fargs)

  local callback = vim.tbl_get(SUBCOMMANDS, name, "callback")
  if type(callback) == "function" then
    callback(opts)
  elseif type(callback) == "string" then
    vim.cmd(callback)
  else
    log.error("Command "..name.." not found")
  end
end

local function main_complete(arg_lead, line, position)
  if line:match("^C11n%s+"..arg_lead.."$") then
    return vim.tbl_keys(SUBCOMMANDS)
  end

  local name = line:match("%s+(%w*)%s+") or ""
  local complete = vim.tbl_get(SUBCOMMANDS, name, "complete")

  if complete then
    return complete(arg_lead, line, position)
  end

  return {}
end

function M.init()
  vim.api.nvim_create_user_command("C11n", main_command, {
    nargs = "*",
    complete = main_complete,
    desc = "Management commands for c11n"
  })
  require("c11n.manage.commands").register_default_commands()
end

return M
