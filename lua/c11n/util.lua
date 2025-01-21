---@module c11n.util
local M = {}

---Wraps any lua type into a table
---@param value any
---@param key string? Optional key for value in the table
---@return table wrapped Wrapped value
function M.wrap(value, key)
  if type(value) == "table" then
    return value
  elseif key ~= nil then
    return { [key] = value }
  else
    return { value }
  end
end

---Loads and runs init() on all given modules in order
---@param modules string|string[]
function M.initialize(modules)
  local mods = M.wrap(modules)
  for _, mod in ipairs(mods) do
    require(mod).init()
  end
end

---Partially applies a function
---@generic A
---@param fn fn(...):A
---@param ... any?
---@return fn(...):A
function M.partial(fn, ...)
  local args = {...}
  return function(...)
    return fn(unpack(args), ...)
  end
end

return M
