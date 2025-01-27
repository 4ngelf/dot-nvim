--- Options management
local M = M(...)

---@type { string: any }
M.options = {
  --Scrolling
  number = true,
  relativenumber = true,
  scrolloff = 8,

  --Tabs
  expandtab = true,
  shiftwidth = 4,
  tabstop = 4,
  smartindent = true,

  --Folding
  foldmethod = "marker",
  foldenable = true,
  foldnestmax = 3,
  foldlevelstart = 99,

  --Search
  ignorecase = true,
  smartcase = true,
  showmatch = true,
  hlsearch = false,

  --Windows
  splitbelow = true,
  splitright = true,

  --Wild Menu
  wildmenu = true,
  wildmode = "longest:full,full",

  --Formatting
  formatoptions = "tcro/q2lj", -- default: tcqj
  textwidth = 100,
  wrap = false,
  joinspaces = false,

  --System
  termguicolors = true,
  spelllang = { "en" },
}

return M
