--- Options
local o = vim.opt

-- General settings
require("config.settings")

-- Scrolling
o.number = true,
o.relativenumber = true,
o.scrolloff = 8,

-- Tabs
o.expandtab = true,
o.shiftwidth = 2,
o.tabstop = 2,
o.smartindent = true,

-- Search
o.ignorecase = true,
o.smartcase = true,
o.hlsearch = false,

-- Formatting
o.formatoptions = "tcro/q2lnj", --  default: tcqj
o.textwidth = 100,

-- Display
o.showmatch = true,
o.wrap = false,
o.splitbelow = true,
o.splitright = true,

-- System
o.wildmode = "longest:full,full",
o.clipboard = ""

--------------------------------------------------------------------------------
--  NOT LAZY.NVIM
if not vim.go.c11_lazy then
  -- Folding
  o.foldmethod = "marker",
  o.foldenable = true,
  o.foldnestmax = 3,
  o.foldlevelstart = 99,

  -- System
  o.termguicolors = true,
  o.spelllang = { "en" },
end
