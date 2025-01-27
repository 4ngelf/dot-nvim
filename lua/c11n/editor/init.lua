--- nvim editor management
local M = M(...)
local rocks = require("c11n.rocks")

if rocks.available() then
  return M.require("extra")
else
  return M.require("base")
end
