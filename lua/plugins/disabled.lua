--- Disabled lazyvim plugins
local disabled_plugins = {

}

return vim.tbl_map(function(plugin_name)
  return { plugin_name, enabled = false }
end, disabled_plugins)
