-- Autocommands

---@param name string
local function augroup(name)
  return vim.api.nvim_create_augroup("c11n_" .. name, { clear = true })
end

vim.api.nvim_del_augroup_by_name("lazyvim_highlight_yank")
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  desc = "Highlight on yank",
  callback = function()
    (vim.hl or vim.highlight).on_yank({
      timeout = require("c11n.settings").get().highlight_on_yank_timeout,
    })
  end,
})
