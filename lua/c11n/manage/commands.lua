local M = {}
local Lazy = require("c11n.lazy")

local MAP = {}

if Lazy.status ~= "ok" then
  MAP.install_lazy = {
    callback = function(opts)
      -- TODO: use vim.ui.input to confirm
      Lazy.setup()
    end,
    desc = "Install lazynvim right now"
  }
end

--- Registers some standard commands
function M.register_default_commands()
  for cmd, definition in pairs(MAP) do
    require("c11n.manage").register_command(cmd, definition)
  end
end

return M
