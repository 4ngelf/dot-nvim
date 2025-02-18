--- Some adaptations for windows
if require("c11n.util").platform() ~= "windows" then
  return
end

local uv_spawn = vim.uv.spawn
-- HACK: uv.spawn() now can find and execute batch scripts by name.
--       ie: luarocks.bat
-- TODO: find a better solution
vim.uv.spawn = function(path, options, on_exit)
  local exts = { "", ".bat", ".cmd" }
  local h, pid, err

  for _, ext in ipairs(exts) do
    h, pid, err = uv_spawn(path..ext, options, on_exit)
    if h or err ~= "ENOENT" then
      break
    end
  end

  return h, pid, err
end
