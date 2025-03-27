--- Settings
vim.g.c11n_settings = {
  colorscheme = "catppuccin-macchiato",
  language = "en_US.utf-8",
  highlight_on_yank_timeout = 1000,
  disabled_plugins = {
    "gzip",
    -- "matchit",
    -- "matchparen",
    -- "netrwPlugin",
    "tarPlugin",
    "tohtml",
    -- "tutor",
    "zipPlugin",
  },
  preset = nil,
  lazyspec = nil,
}

-- Useful events:
-- - VeryLazy: After LazyDone and VimEnter autocmds
-- - LazyVimOptionsDefaults: after loading default options
-- - LazyVimOptions: after loading user options
-- - LazyVimKeymapsDefaults: after loading default keymaps
-- - LazyVimKeymaps: after loading user keymaps
-- - LazyVimAutocmdsDefaults: after loading default autocmds
-- - LazyVimAutocmds: after loading user autocmds
--
-- local on = require("c11n.util").on_user
-- on("VeryLazy", function(ev)
--   -- Execute on VeryLazy
-- end)
