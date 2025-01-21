---@module c11n.editor
---This is the module that controls the nvim text editor
if require("c11n.core.const").use_rocks then
  return require("c11n.editor.full")
else
  return require("c11n.editor.base")
end
