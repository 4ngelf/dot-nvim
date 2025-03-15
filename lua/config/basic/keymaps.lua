--- Keymaps

local keymap = require("c11n.util").keymap

-- Scrolling
keymap.n("<C-d>", "<C-d>zz", "Scroll down and center cursor")
keymap.n("<C-u>", "<C-u>zz", "Scroll up and center cursor")
keymap.n("n", "nzz", "Find next and center cursor")
keymap.n("N", "Nzz", "Find previous and center cursor")

-- Search
keymap.n(
  "<leader>S",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  "Substitute all coincidences with word under cursor"
)

-- Windows
keymap.n("<C-Up>", "<cmd>resize +2<cr>", "Increase window height")
keymap.n("<C-Down>", "<cmd>resize -2<cr>", "Decrease window height")
keymap.n("<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
keymap.n("<C-Right>", "<cmd>vertical resize +2<cr>", "Increase window width")

-- Formatting
keymap.n("J", "mzJ`z", "Join lines without moving the cursor")

keymap.v("J", ":m '>+1<CR>gv", "Move selected line Down")
keymap.v("K", ":m '<-2<CR>gv", "Move selected line Up")
keymap.v("<", "<gv", "Better left indenting")
keymap.v(">", ">gv", "Better right indenting")

-- Windows
keymap.n("<C-h>", "<C-w>h", "Go to left window")
keymap.n("<C-j>", "<C-w>j", "Go to lower window")
keymap.n("<C-k>", "<C-w>k", "Go to upper window")
keymap.n("<C-l>", "<C-w>l", "Go to right window")

-- Tabs
keymap.n("<leader><tab><tab>", "<cmd>tabnew<cr>", "New tab")
keymap.n("<leader><tab>d", "<cmd>tabclose<cr>", "Close tab")
keymap.n("<leader><tab>f", "<cmd>tabfirst<cr>", "Go to first tab")
keymap.n("<leader><tab>l", "<cmd>tablast<cr>", "Go to last tab")
keymap.n("<leader><tab>]", "<cmd>tabnext<cr>", "Go to next tab")
keymap.n("<leader><tab>[", "<cmd>tabprevious<cr>", "Go to previous tab")
