--- Keymaps

local keymap = require("c11n.util").keymap

-- Formatting
keymap("n", "J", "mzJ`z", "Join lines without moving the cursor")

keymap("v", "J", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", "Move selected line Down")
keymap("v", "K", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", "Move selected line Up")
