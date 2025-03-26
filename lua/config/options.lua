-- Globals
vim.g.mapleader = vim.keycode("<Space>")
vim.g.maplocalleader = "\\"

vim.g.lazyvim_cmp = "blink.cmp"
vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_python_lsp = "basedpyright"

LazyVim.terminal.setup("pwsh")
-- TODO: Configure nushell
-- fallback to either powershell or bash depending on the OS

-- Options
local o = vim.opt

-- Scrolling
o.number = true
o.relativenumber = true
o.scrolloff = 8

-- Tabs
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = false

-- Formatting
o.formatoptions = "tcro/q2lnj" --  default: tcqj
o.textwidth = 100

-- Display
o.showmatch = true
o.wrap = false
o.splitbelow = true
o.splitright = true

-- System
o.termguicolors = true
o.spelllang = { "en" }
o.clipboard = ""
