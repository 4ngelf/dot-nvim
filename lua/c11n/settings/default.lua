---@class c11n.settings.default
local M = M(...)

---@class c11n.Settings
M.DEFAULT_SETTINGS = {
  ---@class c11n.Settings.Editor
  editor = {
    --- Preferred colorscheme. Priority from left to right.
    ---@type string[]
    colorscheme = {
      "catppuccin-frappe",
      "catppuccin",
      "habamax",
      "default"
    },
    ---@type string
    language = "en_US",
    ---@type string
    mapleader = vim.keycode "<Space>"
    ---@type string
    maplocalleader = vim.keycode "<BS>"
  },
  ---@type { string: any }
  option = {},
  ---@type c11n.Settings.KeymapGroup[]
  keymap = {},
}

---@type { string: any }
M.DEFAULT_SETTINGS.option = {
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

---@class c11n.Settings.KeymapGroup
---@field [1] c11n.Settings.Keymap[] List of keymaps to create
---@field group? string Group for keymap definitions. Default: "c11n.misc"
---@field mode? string|string[] mode. Default: "n"
---@field noremap? bool Disables recursive_mapping. Default: true
---@field replace_keycodes? bool Replace keycodes in final string. Default: true
---@field buffer? integer|boolean Creates buffer-local mapping. 0 or true for current buffer

---@class c11n.Settings.Keymap
---@field [1] string lhs
---@field [2] string|fun() rhs
---@field desc? string Description of mapping
---@field mode? string|string[]

---@type c11n.Settings.KeymapGroup[]
M.DEFAULT_SETTINGS.keymap = {
  {
    {
      -- Scrolling
      { "<C-d>", "<C-d>zz", desc = "Scroll down and center cursor" },
      { "<C-u>", "<C-u>zz", desc = "Scroll up and center cursor" },
      { "n", "nzz", desc = "Find next and center cursor" },
      { "N", "Nzz", desc = "Find previous and center cursor" },

      -- Search
      {
        "<leader>S",
        [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
        desc = "Substitute all coincidences with word under cursor"
      },

      -- Windows
      { "<C-Up>", "<cmd>resize +2<cr>", desc = "Increase window height" },
      { "<C-Down>", "<cmd>resize -2<cr>", desc = "Decrease window height" },
      { "<C-Left>", "<cmd>vertical resize -2<cr>", desc = "Decrease window width" },
      { "<C-Right>", "<cmd>vertical resize +2<cr>", desc = "Increase window width" },

      -- Formatting
      { "J", "mzJ`z", desc = "Join lines without moving the cursor" },
    },
    group = "c11n.basic",
    mode = "n",
  },
  {
    {
      {"J", ":m '>+1<CR>gv", "Move selected line Down" },
      {"K", ":m '<-2<CR>gv", "Move selected line Up" },
      {"<", "<gv", "Better left indenting" },
      {">", ">gv", "Better right indenting" },
    },
    group = "c11n.basic",
    mode = "v"
  },
  {
    {
      -- Windows
      {"<C-h>", "<C-w>h", desc = "Go to left window" },
      {"<C-j>", "<C-w>j", desc = "Go to lower window" },
      {"<C-k>", "<C-w>k", desc = "Go to upper window" },
      {"<C-l>", "<C-w>l", desc = "Go to right window" },
    },
    group = "c11n.basic",
    mode = "n",
    noremap = false,
  },
  {
    {
      { "<leader><tab><tab>", "<cmd>tabnew<cr>", desc = "New tab" },
      { "<leader><tab>d", "<cmd>tabclose<cr>", desc = "Close tab" },
      { "<leader><tab>f", "<cmd>tabfirst<cr>", desc = "Go to first tab" },
      { "<leader><tab>l", "<cmd>tablast<cr>", desc = "Go to last tab" },
      { "<leader><tab>]", "<cmd>tabnext<cr>", desc = "Go to next tab" },
      { "<leader><tab>[", "<cmd>tabprevious<cr>", desc = "Go to previous tab" },
    },
    group = "c11n.tab",
    mode = "n",
  },
}

return M
