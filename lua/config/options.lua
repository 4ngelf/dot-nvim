-- Globals
vim.g.mapleader = vim.keycode("<Space>")
vim.g.maplocalleader = "\\"

vim.g.lazyvim_cmp = "blink.cmp"
vim.g.lazyvim_picker = "snacks"
vim.g.lazyvim_python_lsp = "basedpyright"

local c11n = require("c11n")
local shells
if c11n.has("windows") then
  shells = { "nu", "pwsh", "powershell" }
else
  shells = { "nu", "zsh", "bash" }
end

for _, shell in ipairs(shells) do
  if vim.fn.executable(shell) then
    vim.go.shell = shell
    c11n.util.try_set_shell_options()
    break
  end
end

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
