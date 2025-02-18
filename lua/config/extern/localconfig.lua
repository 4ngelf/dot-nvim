-- Local machine configuration support.
--
-- This allows to load custom configuration in local to a machine.
-- It loads after all options and settings are loaded to allow overrides.
local local_file = vim.fs.joinpath(vim.fn.stdpath("data"), "c11n_local.lua")

if vim.uv.fs_stat(local_file) then
  vim.cmd.source(local_file)
end

require("c11n.manage").register_command("edit_local", {
  callback = "edit "..local_file,
  desc = "Edit local machine configuration",
})
