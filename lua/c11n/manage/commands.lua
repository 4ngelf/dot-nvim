local M = {}

M.default_commands = {}

M.default_commands["edit_local"] = {
  callback = function()
    local c11n = require("c11n")
    local Path = require("pathlib")

    local local_file = Path(c11n.local_config_path)

    if not local_file:exists(false) then
      local name = local_file:basename()
      local template = c11n.util.template(name)

      template:copy(local_file)
    end

    vim.cmd.edit(c11n.local_config_path)
  end,
  desc = "Edit local machine configuration",
}

--- Register the default commands
function M.register_default_commands()
  for cmd, definition in pairs(M.default_commands) do
    require("c11n.manage").register_command(cmd, definition)
  end
end

return M
