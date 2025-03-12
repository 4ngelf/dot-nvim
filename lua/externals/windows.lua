--- Some adaptations for windows
if require("c11n").OS ~= "windows" then
  return
end

-- HACK: On windows, uv.spawn only tries `.COM` and `.EXE` extensions. We will try other extensions
-- if those are not found. `on_exit` is only called when the spawned process exits.
-- see: https://github.com/libuv/libuv/blob/4681d5d5705be932f82e1e79eff72f17b5bf82e2/src/win/process.c#L332
do
  local uv_spawn = vim.uv.spawn
  local exts = { "", ".bat", ".cmd" }

  vim.uv.spawn = function(path, options, on_exit)
    local h, pid, err
    for _, ext in ipairs(exts) do
      h, pid, err = uv_spawn(path..ext, options, on_exit)
      if h or err ~= "ENOENT" then
        break
      end
    end

    return h, pid, err
  end
end
