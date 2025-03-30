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

vim.api.nvim_create_autocmd("OptionSet", {
  group = augroup("set_shell_options"),
  desc = "Set options for a shell",
  pattern = "shell",
  callback = function(_)
    require("c11n").util.try_set_shell_options()
  end,
})
