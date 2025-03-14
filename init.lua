-- Neovim configuration entry point.

---@type string
local LAZY_PATH = vim.fs.joinpath(vim.fn.stdpath("data") --[[@as string]], "lazy", "lazy.nvim")

local function abort(msg)
  local headless = #vim.api.nvim_list_uis() == 0
  if headless then
    vim.notify(msg .. "\n", vim.log.levels.ERROR)
    os.exit(1)
  else
    -- Stop executing lua code
    error(msg)
  end
end

local function initialize()
  vim.opt.runtimepath:prepend(LAZY_PATH)

  if not pcall(require, "lazy") then
    abort("lazy.nvim is broken. You should try again after erasing " .. LAZY_PATH)
  end

  -- Initialize configuration (c11n)
  require("c11n").init()
end

local nvim_version = "nvim-0.10.0"
if vim.fn.has(nvim_version) ~= 1 then
  abort("this configuration needs " .. nvim_version .. " or later")
end

if vim.uv.fs_stat(LAZY_PATH) then
  initialize()
else
  vim.system({
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
    if out.code == 0 then
      vim.schedule(initialize)
    else
      abort("couldn't clone lazy.nvim")
    end
  end)
end
