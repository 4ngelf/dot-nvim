-- Neovim configuration entry point.
local nvim_version = "0.10.0"
if vim.fn.has("nvim-" .. nvim_version) ~= 1 then
  vim.notify("neovim version required: >=" .. nvim_version, vim.log.levels.ERROR)
  return
end

---@type string
local LAZY_PATH = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "lazy", "lazy.nvim")

if not vim.uv.fs_stat(LAZY_PATH) then
  local result = vim
    .system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=stable",
      "https://github.com/folke/lazy.nvim.git",
      LAZY_PATH,
    }, {
      text = true,
      stdout = false,
      stderr = false,
    })
    :wait()

  if result.code ~= 0 then
    vim.notify("couldn't clone lazy.nvim", vim.log.levels.ERROR)
    return
  end
end

vim.opt.runtimepath:prepend(LAZY_PATH)

if not pcall(require, "lazy") then
  vim.notify("lazy.nvim is broken. Try erasing " .. LAZY_PATH, vim.log.levels.ERROR)
  return
end

-- Initialize configuration
require("c11n").init()
