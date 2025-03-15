local M = {}

M.default_commands = {}

M.default_commands["edit_local"] = {
  callback = "edit " .. require("c11n").local_config_path,
  desc = "Edit local machine configuration",
}

--- Register the default commands
function M.register_default_commands()
  for cmd, definition in pairs(M.default_commands) do
    require("c11n.manage").register_command(cmd, definition)
  end
end

return M
