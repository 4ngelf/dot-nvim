--- Relative require function. This is a function to make lua module management
--- a little bit nicer. Inspired in python's "from ... import ..." syntax, this
--- is a function that allows to load modules with a relative path.
---
--- # Usage
---
---```lua
--- -- In entry point (init.lua)
--- -- Just require it into global space
--- M = require("function_M").get_M(require)
---
--- -- Now you can use it in the whole project!
--- ```
---
--- With this project structure:
--- ```
--- lua/
---   foo/
---     another.lua
---     bar/
---       init.lua
---       baz.lua
---     init.lua
--- ```
---
--- You can make declare a module and use require() relative to that module:
---
--- ```lua
---  -- lua/foo/bar.lua
---  -- At file top:
---  local M = M(...)
---  -- or write the module path if you are outside the root scope of the file:
---  local M = M("foo.bar")
---  
---  -- Now you can make relative requires
---  local baz = M.require("baz") -- is require("foo.bar.baz")
---  local baz = M.require(".baz") -- is require("foo.bar.baz") too
---  local foo = M.require("..") -- is require("foo")
---  local another = M.require("..another") -- is require("foo.another")
---  local self = M.require("") -- is require("foo.bar")
---  local self = M.require(".") -- is require("foo.bar") too
---  local self = M.require("...foo.bar") -- is also require("foo.bar")
--- 
---  -- It only includes require(...) function to M so you can use M as a
---  -- normal module
---  function M.some_function() end
---  M.some_number = 123
--- 
---  return M
--- ```
---
--- # Caveats
---
--- If you declare `M(...)` with a module path different from the current
--- module, you will get unexpected results.
---
--- ```lua
--- -- In module "foo.bar"
--- local M = M("foo")
---
--- -- This will return module "foo.baz", not module "foo.bar.baz"
--- baz = M.require("baz")
--- ```
local M = {}

---@class Module
--- This is a module returned by M(...)

---@alias ModulePath string

--- Splits string by '.'
---@param s string
---@return string[]
local function split_dot(s)
  local result = {}
  for part in s:gmatch("[^.]+") do
    table.insert(result, part)
  end

  return result
end

--- Get the first n elements of list
---@param list any[] List of elements
---@param n number Number of elements to take
---@return any[]
local function take(list, n)
  local new_list = {}
  for i, item in ipairs(list) do
    if i <= n then
      table.insert(new_list, item)
    else
      break
    end
  end

  return new_list
end

--- Helper function to calculate relative paths
---@param path ModulePath Current module path
---@param subpath ModulePath Requested module path
---@return ModulePath
local function get_fullpath(path, subpath)
  local parts = { path }

  -- subpath starts with dot
  if subpath:sub(1, 1) == "." then
    local depth = #subpath:match("%.*")

    -- strip later parts by depth
    parts = split_dot(parts[1])
    parts = take(parts, #parts - depth + 1)

    -- canonalize subpath
    subpath = subpath:sub(depth + 1)
  end

  if subpath ~= "" then
    table.insert(parts, subpath)
  end

  return table.concat(parts, ".")
end

--- Make function M which uses the given require() function
---
---@usage [[
--- -- In program entry point (init.lua)
--- M = require("fucntion_M").get_M(require)
---]]
---@param require_fn fun(path: ModulePath):any require() function to use for module loading.
---@return function function_M The M function
function M.get_M(require_fn)
  --- Declare the current module. The given path must be equal to that of the
  --- current module or else its require function will yield unexpected results.
  ---
  ---@usage [[
  --- -- In module "foo.bar"
  --- local M = M(...)
  --- -- or declared explicitly
  --- local M = M("foo.bar")
  ---]]
  ---@param path ModulePath The full path of the current module
  ---@return Module
  return function(path)
    return {
      --- Loads a module relative to the current module. If subpath starts with
      --- '.', it will look into current module, if it starts with '..' it will
      --- look into parent module, and so on.
      ---@param subpath ModulePath Relative path of module
      ---@return any
      require = function(subpath)
        local fullpath = get_fullpath(path, subpath)
        return require_fn(fullpath)
      end
    }
  end
end

return M
