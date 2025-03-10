--- Some adaptations for windows
if require("c11n").OS ~= "windows" then
  return
end

local uv_spawn = vim.uv.spawn

-- HACK: uv.spawn() now can find and execute batch scripts by name.
--       ie: 'luarocks' could invoke 'luarocks.bat'
-- TODO: figure out a solution that only requires a single invocation to uv.spawn
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
