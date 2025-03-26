-- Autocommands

---@param name string
---@diagnostic disable-next-line: unused-function, unused-local
local function augroup(name)
  return vim.api.nvim_create_augroup("c11n_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("lazyvim_highlight_yank", { clear = true }),
  desc = "Highlight on yank",
  callback = function()
    (vim.hl or vim.highlight).on_yank({
      timeout = require("c11n.settings").get().highlight_on_yank_timeout,
    })
  end,
})
