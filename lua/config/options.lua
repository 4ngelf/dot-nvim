-- Globals
vim.g.mapleader = vim.keycode "<Space>"
vim.g.maplocalleader = "\\"

vim.g.lazyvim_cmp = "blink.cmp"

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

--  NOT LAZY.NVIM
if not require("c11n.util").has("lazy") then
  -- Folding
  o.foldmethod = "marker"
  o.foldenable = true
  o.foldnestmax = 3
  o.foldlevelstart = 99

end

-- Settings for external tools
require("config.extern").init()
