--- Utilities
local M = {}

---@alias c11n.Feature
---| "windows"
---| "termux"
---| "neovide"
---| "lazy"
---| any

--- Checks feature availability. Extends vim.fn.has()
---@param feature c11n.Feature
---@return boolean
function M.has(feature)
  local has = vim.fn.has
  if feature == "windows" then
    return has("win32") == 1 or has("win64") == 1
  elseif feature == "termux" then
    return vim.uv.fs_stat("/data/data/com.termux/files") ~= nil
  elseif feature == "neovide" then
    return vim.g.neovide ~= nil
  elseif feature == "lazy" then
    return package.loaded["lazy"] ~= nil
  else
    return has(feature) == 1
  end
end

--- `vim.keymap.set` wrapper.
--- The mode argument can be a string
--- The third argument can be a string to put the description
---
--- ```lua
--- -- This:
--- keymap("nxt", "<C-e>", [[echo "hello"]], "prints hello")
--- -- Is equivalent to:
--- vim.keymap.set({ "n", "x", "t" }, "<C-e>", [[echo "hello"]], {
---   desc = "prints hello"
--- })
--- ```
---@param mode elem_or_list<string>
---@param lhs string
---@param rhs string | fun()
---@param desc_or_opts string | vim.keymap.set.Opts
function M.keymap(mode, lhs, rhs, desc_or_opts)
  mode = type(mode) == "string" and vim.split(mode, "") or mode

  if type(desc_or_opts) == "string" then
    desc_or_opts = { desc = desc_or_opts }
  end

  vim.keymap.set(mode, lhs, rhs, desc_or_opts)
end

return M
