-- Neovim configuration entry point.
local nvim_version = "0.10.0"
assert(
  vim.fn.has("nvim-" .. nvim_version) == 1,
  "this configuration needs at least neovim v" .. nvim_version .. " or greater"
)

---@type string
local LAZY_PATH = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "lazy", "lazy.nvim")

---@type boolean
local headless = #vim.api.nvim_list_uis() == 0

---@param msg string
local function abort(msg)
  vim.notify(msg .. "\n", vim.log.levels.ERROR)

  if headless then
    os.exit(1)
  else
    require("c11n").fallback()
  end
end

---@param on_success? fun()
---@return vim.SystemObj
local function download_lazy(on_success)
  return vim.system({
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
  }, function(out)
    if out.code ~= 0 then
      abort("couldn't clone lazy.nvim")
    end

    if on_success then
      vim.schedule(on_success)
    end
  end)
end

local function initialize()
  vim.opt.runtimepath:prepend(LAZY_PATH)

  if not pcall(require, "lazy") then
    abort("lazy.nvim is broken. You should try again after erasing " .. LAZY_PATH)
  end

  -- Initialize configuration
  require("c11n").init()
end

--- Synchronization logic below

local cloning_lazy
if not vim.uv.fs_stat(LAZY_PATH) then
  if not headless then
    -- async
    cloning_lazy = download_lazy(initialize)
  else
    -- sync
    download_lazy():wait()
  end
end

if not cloning_lazy then
  initialize() -- immediately
end
