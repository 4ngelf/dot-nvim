--- Management for editor
local M = {}

-- TODO: Add capability to add subcommands
local subcommands = {}

function M.init()
  vim.api.nvim_create_user_command("C11n", function(opts)
    if opts.fargs[1] == "install_lazy" then
      require("c11n.lazy").setup()
    end
  end, {nargs = 1, complete = function(_,_,_) return { "install_lazy" } end})
end

return M
