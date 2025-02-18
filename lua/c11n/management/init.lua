--- Management for editor
local M = {}
local log = require("c11n.util").log

---@class c11n.CommandDefinition
---@field callback string|fun(opts: table)
---@field complete string|string[]|fun(lead: string, args: string[], position: number):string[]

---@type c11n.CommandDefinition[]
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
    local subcommands = table.concat(vim.tbl_keys(SUBCOMMANDS), ", ")
    if subcommands ~= "" then
      log("Available commands: "..subcommands)
    else
      log.error("No commands available")
    end
    return
  end

  local name = opts.fargs[1]
  opts.fargs = vim.list_slice(opts.fargs, 2, #opts.fargs)

  local callback = vim.tbl_get(SUBCOMMANDS, name, "callback")
  if callback then
    callback(opts)
  else
    log.error("Command "..name.." not found")
  end
end

local function main_completion(arg_lead, line, position)
  if line:match("^C11n%s+$") then
    return vim.tbl_keys(SUBCOMMANDS)
  end

  local name = line:match("%s+(%w*)%s+")
  local complete = vim.tbl_get(SUBCOMMANDS, name, "complete")

  if complete then
    return complete(arg_lead, line, position)
  end

  return {}
end

function M.init()
  vim.api.nvim_create_user_command("C11n", main_command, {nargs = "*", complete = main_completion} )
end

return M
