---@class c11n.util
local M = M(...)

--- Lua types utilities
M.data = {}

---Wraps any lua type into a table
---@param value any
---@param key string? Optional key for value in the table
---@return table wrapped Wrapped value
function M.data.tbl_wrap(value, key)
  if type(value) == "table" then
    return value
  elseif key ~= nil then
    return { [key] = value }
  else
    return { value }
  end
end

---Partially applies a function
---@generic A
---@param fn fn(...):A
---@param ... any?
---@return fn(...):A
function M.data.partial(fn, ...)
  local args = {...}
  return function(...)
    return fn(unpack(args), ...)
  end
end

return M
