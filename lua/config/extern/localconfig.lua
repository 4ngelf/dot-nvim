-- Local machine configuration support.
--
-- This allows to load custom configuration in local to a machine.
-- It loads after all options and settings are loaded to allow overrides.
local local_file = vim.fs.joinpath(vim.fn.stdpath("data"), "c11n_local.lua")

if vim.uv.fs_stat(local_file) then
  vim.cmd.source(local_file)
end

-- TODO: Include a 'C11n EditLocal' command to edit file
vim.api.nvim_create_user_command("C11nEditLocal", "edit "..local_file, { desc = "Edit machine local configuration"})
