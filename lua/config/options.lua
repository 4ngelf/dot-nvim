-- Options
require("config.basic.options")

vim.g.lazyvim_cmp = "blink.cmp"
vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_python_lsp = "basedpyright"

LazyVim.terminal.setup("pwsh")
-- TODO: Configure nushell
-- fallback to either powershell or bash depending on the OS
