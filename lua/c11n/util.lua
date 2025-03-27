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

--- Callback on user event
---@param user_event string
---@param fn fun(ev: table)
function M.on_user(user_event, fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = user_event,
    callback = fn,
  })
end

--- Check if headless
---@return boolean
M.headless = require("lazy.core.config").headless

--- Utilities plugin specs
M.plugin = {}

--- Spec of a disabled plugin
--- Example:
--- ```lua
--- local spec = util.plugin.disable("bufferline.nvim")
--- local expected = { "bufferline.nvim", enabled = false }
---
--- assert(vim.deep_equal(spec, expected))
--- ```
---@param plugin_name
---@return LazySpec
function M.plugin.disable(plugin_name)
  return { plugin_name, enabled = false }
end

--- Spec of an imported lazyvim extra.
--- Example:
--- ```lua
--- local spec = util.plugin.extra("lang.rust")
--- local expected = { import = "lazyvim.plugins.extras.lang.rust" }
---
--- assert(vim.deep_equal(spec, expected))
--- ```
---@param extra_path string
---@return LazySpecImport
function M.plugin.extra(extra_path)
  return { import = "lazyvim.plugins.extras." .. extra_path }
end

return M
