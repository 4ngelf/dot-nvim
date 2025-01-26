---@class c11n.editor
--- This is the module that controls the nvim text editor
local M = M(...)
local C = require("c11n.const")

if C.use_rocks then
  return M.require("full")
else
  return M.require("base")
end
