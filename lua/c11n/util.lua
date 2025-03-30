--- Utilities
local M = {}

---@alias c11n.Feature
---| "windows"
---| "termux"
---| "neovide"
---| "lazy"
---| "linux"
---| "unix"
---| "wsl"
---| "win64"
---| "win32"
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

--- Get a template file from `stdpath("config").."/templates"`
---@param file string
---@return PathlibPath
function M.template(file)
  local Path = require("pathlib")
  return Path.stdpath("config", "templates", file)
end

do
  ---@class c11n.ShellOptions
  ---@field shellcmdflag? string
  ---@field shellpipe? string
  ---@field shellquote? string
  ---@field shellredir? string
  ---@field shelltemp? boolean
  ---@field shellxescape? string
  ---@field shellxquote? string

  ---@type table<string, c11n.ShellOptions>
  local _shell = {
    nu = {
      shellcmdflag = "--stdin --no-newline -c",
      shellredir = "out+err> %s",
      shellpipe = "| complete "
        .. "| update stderr { ansi strip } "
        .. "| tee { get stderr | save --force --raw %s } "
        .. "| into record",
      shelltemp = false,
      shellxquote = "",
      shellquote = "",
    },
    powershell = {
      shellcmdflag = "-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command "
        .. "[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();"
        .. "$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
        .. "$PSStyle.OutputRendering='plaintext';"
        .. "Remove-Alias -Force -ErrorAction SilentlyContinue tee;",
      shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode',
      shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode',
      shelltemp = true,
      shellquote = "",
      shellxquote = "",
    },
    bash = {
      shellcmdflag = "-c",
      shellpipe = M.has("windows") and "2>&1 | tee" or "| tee",
      shellquote = M.has("windows") and '"' or "",
      shellredir = ">%s 2>&1",
      shelltemp = true,
      shellxescape = "",
      shellxquote = M.has("windows") and '"' or "",
    },
  }
  --- Options are the same
  _shell.pwsh = _shell.powershell
  _shell.zsh = _shell.bash

  ---@param shell string
  local function set_shell_options(shell)
    local function set(opt)
      local opt_value = _shell[shell][opt]
      if opt_value then
        vim.go[opt] = opt_value
      end
    end

    set("shellcmdflag")
    set("shellpipe")
    set("shellquote")
    set("shellredir")
    set("shelltemp")
    set("shellxescape")
    set("shellxquote")
  end

  --- Set optimized 'shell*' options is a 'shell' is known
  --- 'shell' must be set ahead of time.
  ---@return boolean success Whether shell is known and options were set
  function M.try_set_shell_options()
    ---@type string
    local exename = (vim.go.shell --[[@as string]]):match(".-([^\\/]-%.?[^%.\\/]*)$")

    for shell, _ in pairs(_shell) do
      if exename:match("^" .. shell) then
        set_shell_options(shell)
        return true
      end
    end

    return false
  end
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
---@param name string
---@return LazySpec
function M.plugin.disable(name)
  return { name, enabled = false }
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
