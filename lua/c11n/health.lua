local M = {}

function M.check()
  local settings = require("c11n.settings").get()

  vim.health.start("State")

  vim.health.info("vim.env.NVIM_APPNAME = " .. vim.env.NVIM_APPNAME)
  vim.health.info("current settings = " .. vim.inspect(settings))
end

return M
