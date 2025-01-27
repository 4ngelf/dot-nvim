---@mod c11n.rocks
---@brief [[
---
--- Operations related to rocks.nvim
--- 
---@brief ]]
---
---NOTE: part of the code comes from https://raw.githubusercontent.com/nvim-neorocks/rocks.nvim/master/bootstrap.lua
local M = M(...)

local rocks_binaries_supported_arch_map = {
    Darwin = {
        arm64 = "macosx-aarch64",
        aarch64 = "macosx-aarch64",
        x86_64 = "macosx-x86_64",
    },
    Linux = {
        x86_64 = "linux-x86_64",
    },
    Windows_NT = {
        x86_64 = "win32-x86_64",
    },
}

local uname = vim.uv.os_uname()
local supported_arch = rocks_binaries_supported_arch_map[uname.sysname][uname.machine]

local function join_normalize(...) 
  return vim.fs.normalize(vim.fs.joinpath(...))
end

---@param cmd string[]
---@param opts? vim.SystemOpts
---@return vim.SystemCompleted
local function exec(cmd, opts)
    ---@type boolean, vim.SystemObj | string
    local ok, so_or_err = pcall(vim.system, cmd, opts)
    if not ok then
        ---@cast so_or_err string
        return {
            code = 1,
            signal = 0,
            stderr = ([[
Failed to execute:
%s
%s]]):format(table.concat(cmd, " "), so_or_err),
        }
    end
    ---@cast so_or_err vim.SystemObj
    return so_or_err:wait()
end

---Configure neovim and lua runtime to use rocks.nvim
local function configure_rocks_runtime()
  if not vim.g.rocks_nvim then
    local rocks_config = {
      rocks_path = join_normalize(vim.fn.stdpath("data"), "rocks"),
    }
    vim.g.rocks_nvim = rocks_config

    -- Runtime configuration
    local luarocks_path = vim.list_extend(vim.split(package.path, ";"), {
      join_normalize(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
      join_normalize(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
    })
    package.path = table.concat(luarocks_path, ";")

    local luarocks_cpath = vim.list_extend(vim.split(package.cpath, ";"), (vim.fn.has("win32") == 1) and {
      join_normalize(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dylib"),
      join_normalize(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dylib"),
      join_normalize(rocks_config.rocks_path, "lib", "lua", "5.1", "?.dll"),
      join_normalize(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.dll"),
    } or {
      join_normalize(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
      join_normalize(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
    })
    package.cpath = table.concat(luarocks_cpath, ";")

    vim.opt.runtimepath:append(join_normalize(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))
  end
end

---@return bool success
local function install_rocks_nvim()
  local install_cmd = {
      "luarocks",
      "--lua-version=5.1",
      "--tree=" .. vim.g.rocks_nvim.rocks_path,
      "install",
      "rocks.nvim",
  }

  if supported_arch then
      table.insert(install_cmd, 4, "--server='https://nvim-neorocks.github.io/rocks-binaries/'")
  end

  vim.notify("Installing rocks.nvim...")
  local sc = exec(install_cmd)

  if sc.code ~= 0 then
      notify_output("Installing rocks.nvim failed:", sc, vim.log.levels.ERROR)
      return
  end

  vim.print("rocks.nvim installed successfully!")

end


---Install rocks.nvim if necessary
---@return bool success
function M.ensure_rocks()
  configure_rocks_runtime()
  if not pcall(require, "rocks") then
    return install_rocks_nvim()
  end
  return true
end

function M.init()
  -- TODO: Initialization if rocks.nvim is installed
end

return M
