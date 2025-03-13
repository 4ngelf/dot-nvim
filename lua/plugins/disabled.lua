---@param plugin_name string
local function disable(plugin_name)
  return { plugin_name, enabled = false }
end

return {
  disable("bufferline"),
  disable("mason"),
  disable("mason-lspconfig"),
}
