--- Keymaps

local keymap = require("c11n.util").keymap

-- Formatting
keymap("n", "J", "mzJ`z", "Join lines without moving the cursor")

keymap("v", "J", ":m '>+1<CR>gv", "Move selected line Down")
keymap("v", "K", ":m '<-2<CR>gv", "Move selected line Up")
keymap("v", "<", "<gv", "Better left indenting")
keymap("v", ">", ">gv", "Better right indenting")
